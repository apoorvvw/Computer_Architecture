
/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// interface include
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
// memory types
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module memory_control_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  caches_if cif0();
  caches_if cif1();
  cache_control_if #(.CPUS(1)) ccif (cif0,cif1);

  cpu_ram_if ramif();

  // test program
  test PROG (CLK,nRST,cif0);
  // DUT
`ifndef MAPPED
  memory_control DUT(CLK, nRST, ccif);
  ram RAM (CLK, nRST, ramif);
`endif

assign ramif.ramaddr = ccif.ramaddr;
assign ccif.ramstate = ramif.ramstate;
assign ccif.ramload = ramif.ramload;
assign ramif.ramstore = ccif.ramstore;
assign ramif.ramREN = ccif.ramREN;
assign ramif.ramWEN = ccif.ramWEN;

endmodule

program test(
  input logic CLK,
  output logic nRST,
  caches_if cif0); 

  import cpu_types_pkg::*;
  initial begin

    nRST = 0;
    #(2 * memory_control_tb.PERIOD);
    nRST = 1;
    #(2 * memory_control_tb.PERIOD);
    
    cif0.iREN = 1'b0;
    cif0.iaddr = 1'b0;
    
    cif0.dREN = 1'b0;
    cif0.dWEN = 1'b0;
    cif0.dstore = 1'b0;
    cif0.daddr = 1'b0;
    #(2 * memory_control_tb.PERIOD);

    // Read instruction
    cif0.iREN = 1'b1;
    cif0.iaddr = 32'h999;
    #(3 * memory_control_tb.PERIOD);
    // cif0.iREN = 1'b0;

    // Write Data
    cif0.dWEN = 1'b1;
    cif0.daddr = 32'hC00;
    cif0.dstore = 32'hdeadbeef;
    #(3 * memory_control_tb.PERIOD);

    // Read Data
    cif0.dWEN = 1'b0;
    cif0.dREN = 1'b1;
    cif0.daddr = 32'hC00;
    #(3 * memory_control_tb.PERIOD);    
    cif0.dREN = 1'b0;
    
    // Read instruction
    cif0.iREN = 1'b1;
    cif0.iaddr = 32'h999;
    #(6 * memory_control_tb.PERIOD);
    // cif0.iREN = 1'b0;


    // dump_memory();
    $finish;
  end
  task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    // cif0.tbCTRL = 1;
    cif0.daddr = 0;
    cif0.dWEN = 0;
    cif0.dREN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      cif0.daddr = i << 2;
      cif0.dREN = 1;
      repeat (4) @(posedge CLK);
      if (cif0.dload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,cif0.dload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      // cif0.tbCTRL = 0;
      cif0.dREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask
endprogram
