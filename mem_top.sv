`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "mem_pkg.sv"
`include "mem_interface.sv"
`include "mem_design.v"
module top;
  import mem_pkg::*;
  import uvm_pkg::*;  
  bit clk;
  bit reset;
  
  always #5 clk = ~clk;
  
  initial begin
    reset = 1;
    #5 reset =0;
  end
  mem_interface intf(clk,reset);
  
  memory DUT(
    .clk(intf.clk),
    .reset(intf.reset),
    .address(intf.address),
    .wr_en(intf.wr_en),
    .rd_en(intf.rd_en),
    .wdata(intf.wdata),
    .rdata(intf.rdata)
   );
  
  initial begin 
   uvm_config_db#(virtual mem_interface)::set(uvm_root::get(),"*","vif",intf);
    $dumpfile("dump.vcd");
	$dumpvars;
  end
  
  initial begin 
    run_test("mem_base");
  end
endmodule
