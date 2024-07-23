//------------------------------------------------------------------------------
// Project      : Memory 
// File Name    : sateesh_mem_interface
// Developers   : sateesh mahadev 
// Created Date : 21/07/2024
// Version      : V1.0
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//--------------------------------------------------------------------------

interface mem_interface(input logic clk,reset);
  logic [9:0] address;
  logic wr_en;
  logic rd_en;
  logic [7:0] wdata;
  logic [7:0] rdata;
  
  clocking mem_driver_cb @(posedge clk);
    default input #1 output #1;
    output address;
    output wr_en;
    output rd_en;
    output wdata;
    input  rdata;  
  endclocking
  
  clocking mem_monitor_cb @(posedge clk);
    default input #1 output #1;
    input address;
    input wr_en;
    input rd_en;
    input wdata;
    input rdata;  
  endclocking
  modport DRIVER  (clocking mem_driver_cb,input clk,reset);
  modport MONITOR (clocking mem_monitor_cb,input clk,reset);
  
endinterface
