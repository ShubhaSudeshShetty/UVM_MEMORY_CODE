//------------------------------------------------------------------------------
// Project      : Memory 
// File Name    : sateesh_mem_agent
// Developers   : sateesh mahadev 
// Created Date : 21/07/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//--------------------------------------------------------------------------

`include "sateesh_mem_sequence_item.sv"
`include "sateesh_mem_sequencer.sv"
`include "sateesh_mem_sequence.sv"
`include "sateesh_mem_driver.sv"
`include "sateesh_mem_monitor.sv"

class mem_agent extends uvm_agent;
  mem_driver    mem_driver_1;
  mem_sequencer mem_sequencer_1;
  mem_monitor   mem_monitor_1;

  `uvm_component_utils(mem_agent)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction 

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(get_is_active() == UVM_ACTIVE) begin
      mem_driver_1 = mem_driver::type_id::create("mem_driver_1", this);
      mem_sequencer_1 = mem_sequencer::type_id::create("mem_sequencer_1", this);
    end

    mem_monitor_1 = mem_monitor::type_id::create("mem_monitor_1", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
      mem_driver_1.seq_item_port.connect(mem_sequencer_1.seq_item_export);
    end
  endfunction

endclass
