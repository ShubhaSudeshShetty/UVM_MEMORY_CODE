//------------------------------------------------------------------------------
// Project      : Memory 
// File Name    : sateesh_mem_design
// Developers   : sateesh mahadev 
// Created Date : 21/07/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//--------------------------------------------------------------------------

`include "uvm_pkg.sv"
`include "uvm_macros.svh"

`include "memory_interface.sv"
`include "memory_test.sv"
`include "memory_test_validation.sv"


module top;
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
    .adr(intf.adr),
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
