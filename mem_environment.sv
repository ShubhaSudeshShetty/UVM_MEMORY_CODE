

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
