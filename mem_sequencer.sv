
class mem_sequencer extends uvm_sequencer#(mem_sequence_item);

  `uvm_component_utils(mem_sequencer)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
endclass
