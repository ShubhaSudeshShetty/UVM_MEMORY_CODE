//------------------------------------------------------------------------------
// Project      : Memory 
// File Name    : sateesh_mem_driver
// Developers   : sateesh mahadev 
// Created Date : 21/07/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//--------------------------------------------------------------------------

`define DRIVER_IF vif.DRIVER.mem_driver_cb

class mem_driver extends uvm_driver #(mem_sequence_item);

  virtual mem_interface vif;

  `uvm_component_utils(mem_driver)
    
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

     if(!uvm_config_db#(virtual mem_interface)::get(this, "", "vif", vif))

       `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});

  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
    seq_item_port.get_next_item(req);
    drive();
    seq_item_port.item_done();
    end
  endtask 

  virtual task drive();
    req.print();
      `DRIVER_IF.wr_en <= 0;
      `DRIVER_IF.rd_en <= 0;
      @(posedge vif.DRIVER.clk);
      `DRIVER_IF.address <= req.address;
    if(req.wr_en) begin
        `DRIVER_IF.wr_en <= req.wr_en;
        `DRIVER_IF.wdata <= req.wdata;
        @(posedge vif.DRIVER.clk);
      end
    if(req.rd_en) begin
        `DRIVER_IF.rd_en <= req.rd_en;
        @(posedge vif.DRIVER.clk);
        `DRIVER_IF.rd_en <= 0;
        @(posedge vif.DRIVER.clk);
        req.rdata = `DRIVER_IF.rdata;
      end
  endtask

endclass
