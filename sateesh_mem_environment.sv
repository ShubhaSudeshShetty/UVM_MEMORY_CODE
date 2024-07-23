//------------------------------------------------------------------------------
// Project      : Memory 
// File Name    : sateesh_mem_environment.sv
// Developers   : sateesh mahadev 
// Created Date : 21/07/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//--------------------------------------------------------------------------

`include "sateesh_mem_agent.sv"
`include "sateesh_mem_scoreboard.sv"

class mem_environment extends uvm_env;
  mem_agent      mem_agent_1;
  mem_scoreboard mem_scoreboard_1;
  
  `uvm_component_utils(mem_environment)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    mem_agent_1 = mem_agent::type_id::create("agent_1", this);
    mem_scoreboard_1 = mem_scoreboard::type_id::create("scoreboard_1", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    mem_agent_1.mem_monitor_1.item_collected_port.connect(mem_scoreboard_1.item_collected_export);
  endfunction

endclass
