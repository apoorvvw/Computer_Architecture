/*
  Apoorv Wairagade
  awairaga@purdue.edu

  controller unit test bench
*/

// interface include
`include "control_unit_if.vh"
`include "cpu_ram_if.vh"
// memory types
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module control_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  control_unit_if cuif();

  // test program
  test PROG (CLK,nRST,cuif);
  // DUT
`ifndef MAPPED
  memory_control DUT(CLK, nRST, ccif);
`endif

endmodule

program test(
  input logic CLK,
  output logic nRST,
  control_unit_if cif); 

  import cpu_types_pkg::*;
  initial begin

    nRST = 0;

    // dump_memory();
    $finish;
  end
endprogram
