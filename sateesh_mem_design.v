//------------------------------------------------------------------------------
// Project      : Memory 
// File Name    : sateesh_mem_design
// Developers   : sateesh mahadev 
// Created Date : 21/07/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//--------------------------------------------------------------------------

module memory(
  input clk,
  input reset,
  input wr_en,
  input rd_en,
  input [9:0]address,
  input [7:0]wdata,
  output reg [7:0]rdata);

  reg [7:0]mem[0:1023];

always @(posedge clk) begin
  if(wr_en)
    mem[address] <= wdata;
    else
      rdata <= mem[address];
end
endmodule
