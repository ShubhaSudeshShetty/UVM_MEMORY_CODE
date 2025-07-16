


class mem_base extends uvm_test;

  `uvm_component_utils(mem_base)

 mem_environment mem_env;

  function new(string name = "mem_base",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    mem_env = mem_environment::type_id::create("mem_environment", this);
    
  endfunction : build_phase

virtual function void end_of_elaboration();
 print();
endfunction

 function void report_phase(uvm_phase phase);
   uvm_report_server svr;
   super.report_phase(phase);
   
   svr = uvm_report_server::get_server();
   if(svr.get_severity_count(UVM_FATAL)+svr.get_severity_count(UVM_ERROR)>0) begin
     `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
     `uvm_info(get_type_name(), "----            TEST FAIL          ----", UVM_NONE)
     `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    end
    else begin
     `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
     `uvm_info(get_type_name(), "----           TEST PASS           ----", UVM_NONE)
     `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    end
  endfunction 

endclass 



class wr_test extends mem_base;

  `uvm_component_utils(wr_test)

  function new(string name = "wr_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    mem_wr_sequence seq;
    phase.raise_objection(this);

    seq = mem_wr_sequence::type_id::create("seq");
    seq.start(mem_env.mem_agent_1.mem_sequencer_1);

    phase.drop_objection(this);
  endtask

endclass

class rd_test extends mem_base;

  `uvm_component_utils(rd_test)

  function new(string name = "rd_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    mem_rd_sequence seq;
    phase.raise_objection(this);

    seq = mem_rd_sequence::type_id::create("seq");
    seq.start(mem_env.mem_agent_1.mem_sequencer_1);

    phase.drop_objection(this);
  endtask

endclass


class wr_rd_test extends mem_base;

  `uvm_component_utils(wr_rd_test)

  function new(string name = "wr_rd_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    mem_wr_rd_sequence seq;
    phase.raise_objection(this);

    seq = mem_wr_rd_sequence::type_id::create("seq");
    seq.start(mem_env.mem_agent_1.mem_sequencer_1);

    phase.drop_objection(this);
  endtask

endclass

