

class mem_driver extends uvm_driver #(mem_sequence_item);

  virtual mem_interface vif;

  `uvm_component_utils(mem_driver)
    
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

     if(!uvm_config_db#(virtual mem_interface)::get(this, "", "vif", vif))

       `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});

  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
    seq_item_port.get_next_item(req);
    drive();
    seq_item_port.item_done();
    end
  endtask 

  virtual task drive();
    req.print();
      vif.wr_en <= 0;
      vif.rd_en <= 0;
      @(posedge vif.DRIVER.clk);
      vif.address <= req.address;
    if(req.wr_en) begin
        vif.wr_en <= req.wr_en;
        vif.wdata <= req.wdata;
        @(posedge vif.DRIVER.clk);
      end
    if(req.rd_en) begin
        vif.rd_en <= req.rd_en;
        @(posedge vif.DRIVER.clk);
        vif.rd_en <= 0;
        @(posedge vif.DRIVER.clk);
        req.rdata = vif.rdata;
      end
  endtask

endclass
