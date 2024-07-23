//------------------------------------------------------------------------------
// Project      : Memory 
// File Name    : sateesh_mem_design
// Developers   : sateesh mahadev 
// Created Date : 21/07/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//--------------------------------------------------------------------------

class wr_rd_test extends uvm_test;
environment environment_1;
  `uvm_component_utils(wr_rd_test)
  wr_rd_sequence_2 seq;

  function new(string name = "wr_rd_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    seq = wr_rd_sequence_2::type_id::create("seq");
  endfunction : build_phase
  
  task run_phase(uvm_phase phase);
    
    phase.raise_objection(this);
      seq.start(environment_1.agent_1.sequencer_1);
    phase.drop_objection(this);
    
    phase.phase_done.set_drain_time(this, 50);
  endtask : run_phase
  
endclass
