//------------------------------------------------------------------------------
// Project      : Memory 
// File Name    : sateesh_mem_sequencer
// Developers   : sateesh mahadev 
// Created Date : 21/07/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//--------------------------------------------------------------------------

class mem_sequencer extends uvm_sequencer#(mem_sequence_item);

  `uvm_component_utils(mem_sequencer)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
endclass
