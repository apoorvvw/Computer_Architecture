/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG (CLK,nRST,rfif);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test(  
    input logic CLK, 
    output logic nRST,
    register_file_if.rf rfif
  );
  int i; // Loop control variable
  int isDone; // flag
  initial begin
    $display("-----------------------MY REGI TESTS----------------------------");
    register_file_tb.rfif.wsel = '0;
    register_file_tb.rfif.rsel1 = '0;
    register_file_tb.rfif.rsel2 = '0;
    register_file_tb.rfif.WEN = 0;
    register_file_tb.rfif.wdat = '1;
    nRST = 0;
    
    #(register_file_tb.PERIOD);
    nRST = 1;

    // Test writes to register 0 
    #(register_file_tb.PERIOD);
    register_file_tb.rfif.WEN = 1;
    register_file_tb.rfif.wsel = 5'b00000;
    register_file_tb.rfif.wdat = 32'h0A0A;
    
    #(2* register_file_tb.PERIOD);
    register_file_tb.rfif.wsel = 5'b00010;
    
    #(2* register_file_tb.PERIOD);
    register_file_tb.rfif.WEN = 0;
    register_file_tb.rfif.rsel1 = 5'b00000;
    register_file_tb.rfif.rsel2 = 5'b00010;
    
    #(2* register_file_tb.PERIOD);
    $display("rdat2 : %h",register_file_tb.rfif.rdat2);
    if(register_file_tb.rfif.rdat1 == 32'b0) begin
      $display("\nPASS - Reading from reg0\n");
    end else begin
      $error("\nFAIL - Reading from reg0\n");
    end

    // Test asynchronous reset of register
    $display("---------------Test asynchronous reset of register---------------------");
    nRST = 0;
    #(2* register_file_tb.PERIOD);
    if(register_file_tb.rfif.rdat2 == 32'b0) begin
      $display("\nPASS - Async Reset\n");
    end else begin
      $error("\nFAIL - Async Reset\n");
    end

    // Verify writes and reads to registers
    $display("---------------Verify writes and reads to registers---------------------");
    register_file_tb.rfif.wsel = '0;
    register_file_tb.rfif.wdat = 32'h0000;
    nRST = 1;
    register_file_tb.rfif.WEN = 1;
    isDone = 0;

    // Store 
    for(i = 0; i < 31; i++) begin
      #(register_file_tb.PERIOD);
      register_file_tb.rfif.wdat = register_file_tb.rfif.wdat + 32'h0001;
      register_file_tb.rfif.wsel = register_file_tb.rfif.wsel + 1;
      $display("Writing : %h   to : %h",register_file_tb.rfif.wdat,register_file_tb.rfif.wsel);
    end
    #(register_file_tb.PERIOD);
    // Read
    register_file_tb.rfif.rsel1 = 5'b00000;
    register_file_tb.rfif.rsel2 = 5'd00000;
    register_file_tb.rfif.WEN = 0;
    for(i = 0; i < 31; i++) begin
      register_file_tb.rfif.rsel1 = register_file_tb.rfif.rsel1 + 1;
      register_file_tb.rfif.rsel2 = register_file_tb.rfif.rsel2 + 1;
      #(register_file_tb.PERIOD);
      $display("Reading rdat1 : %h   rdat2 : %h at %h",register_file_tb.rfif.rdat1,register_file_tb.rfif.rdat2,register_file_tb.rfif.rsel1);
      // $display("Reading rdat1 : %h",register_file_tb.rfif.rdat1[4:0]);
      if ( register_file_tb.rfif.rdat1[4:0] != register_file_tb.rfif.rsel1)
        isDone = 1;
      else
        isDone = 0;
    end
    if (isDone)
      $display("\nPASS - Verify writes and reads to registers\n");
    else
      $display("\nFAIL - Verify writes and reads to registers\n");

    $display("-----------------------END TESTS-------------------------------");
  end
endprogram
