//------------------------------------------------------------------------------
// Project      : Memory 
// File Name    : sateesh_mem_scoreboard
// Developers   : sateesh mahadev 
// Created Date : 21/07/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//--------------------------------------------------------------------------

class mem_scoreboard extends uvm_scoreboard;

mem_sequence_item packet_queue[$];

bit [7:0]smem[4];

  `uvm_component_utils(mem_scoreboard)

  uvm_analysis_imp#(mem_sequence_item, mem_scoreboard) item_collected_export;

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export", this);
	foreach(smem[i])
	       smem[i] = 8'hFF;
  endfunction
  
  virtual function void write(mem_sequence_item packet_1);
    $display("Scoreboard is received:: Packet");
    packet_queue.push_back(packet_1);
  endfunction

  virtual task run_phase(uvm_phase phase);

     mem_sequence_item packet_2;

	 forever begin
	    wait(packet_queue.size() > 0);
		packet_2 = packet_queue.pop_front();
		if(packet_2.wr_en)begin

		   smem[packet_2.address] = packet_2.wdata;

        `uvm_info(get_type_name(),$sformatf("------ :: WRITE DATA :: ------"),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf("Addr: %0h",packet_2.address),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf("Data: %0h",packet_2.wdata),UVM_LOW)
        `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)        
      end
      else if(packet_2.rd_en) begin
        if(sc_mem[packet_2.address] == packet_2.rdata) begin
          `uvm_info(get_type_name(),$sformatf("------ :: READ DATA Match :: ------"),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Addr: %0h",packet_2.address),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",smem[packet_2.address],packet_2.rdata),UVM_LOW)
          `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        end
        else begin
          `uvm_error(get_type_name(),"------ :: READ DATA MisMatch :: ------")
          `uvm_info(get_type_name(),$sformatf("Addr: %0h",packet_2.address),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",smem[packet_2.adr],packet_2.rdata),UVM_LOW)
          `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        end
      end
    end
  endtask
endclass

