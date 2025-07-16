

class mem_monitor extends uvm_monitor;

  virtual mem_interface vif;

  uvm_analysis_port #(mem_sequence_item) item_collected_port;

  mem_sequence_item mem_sequence_item_1;

  `uvm_component_utils(mem_monitor)

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
      wait(vif.wr_en || vif.rd_en);
        mem_sequence_item_1.address = vif.address;
      if(vif.wr_en) begin
        mem_sequence_item_1.wr_en = vif.wr_en;
        mem_sequence_item_1.wdata = vif.wdata;
        mem_sequence_item_1.rd_en = 0;
        @(posedge vif.MONITOR.clk);
      end
      if(vif.rd_en) begin
        mem_sequence_item_1.rd_en = vif.rd_en;
        mem_sequence_item_1.wr_en = 0;
        @(posedge vif.MONITOR.clk);
        @(posedge vif.MONITOR.clk);
        mem_sequence_item_1.rdata = vif.rdata;
      end
      item_collected_port.write(mem_sequence_item_1);
    end 
  endtask

endclass

