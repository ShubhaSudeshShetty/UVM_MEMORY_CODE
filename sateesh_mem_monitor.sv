//------------------------------------------------------------------------------
// Project      : Memory 
// File Name    : sateesh_mem_monitor
// Developers   : sateesh mahadev 
// Created Date : 21/07/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//--------------------------------------------------------------------------

`define MONITOR_IF vif.MONITOR.mem_monitor_cb

class mem_monitor extends uvm_monitor;

  virtual mem_interface vif;

  uvm_analysis_port #(mem_sequence_item) item_collected_port;

  mem_sequence_item mem_sequence_item_1;

  `uvm_component_utils(monitor)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    mem_sequence_item_1 = new();
    item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual mem_interface)::get(this, "", "vif", vif))
       `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.MONITOR.clk);
      wait(MONITOR_IF.wr_en || MONITOR_IF.rd_en);
        mem_sequence_item_1.address = MONITOR_IF.address;
      if(MONITOR_IF.wr_en) begin
        mem_sequence_item_1.wr_en = MONITOR_IF.wr_en;
        mem_sequence_item_1.wdata = MONITOR_IF.wdata;
        mem_sequence_item_1.rd_en = 0;
        @(posedge vif.MONITOR.clk);
      end
      if(MONITOR_IF.rd_en) begin
        mem_sequence_item_1.rd_en = MONITOR_IF.rd_en;
        mem_sequence_item_1.wr_en = 0;
        @(posedge vif.MONITOR.clk);
        @(posedge vif.MONITOR.clk);
        mem_sequence_item_1.rdata = MONITOR_IF.rdata;
      end
      item_collected_port.write(mem_sequence_item_1);
    end 
  endtask

endclass

