/*
  Apoorv Wairagade
  awairaga@purdue.edu

  ALU test bench
*/

// mapped needs this
`include "alu_if.vh"
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module alu_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  alu_if aluif ();
  // test program
  test PROG ();
  // DUT
`ifndef MAPPED
  alu DUT(aluif);
`else
  alu DUT(
    .\aluif.porta (aluif.porta),
    .\aluif.portb (aluif.portb),
    .\aluif.portout (aluif.portout),
    .\aluif.n_flag (aluif.n_flag),
    .\aluif.v_flag (aluif.v_flag),
    .\aluif.z_flag (aluif.z_flag),
    .\aluif.aluop (aluif.aluop)
  );
`endif

endmodule

program test;
  import cpu_types_pkg::*;
  int i, isCorrect; // Loop control variable
  initial begin
    $display("------------------------MY ALU TEST-------------------------------\n");
    
    // Testing SLL
    $display("Testing SLL\n");
    alu_tb.aluif.porta = 32'h3;
    alu_tb.aluif.portb = 32'h1;
    alu_tb.aluif.aluop = ALU_SLL;
    #(3*alu_tb.PERIOD)
    $display("porta : %b %h %d\nportb : %b %h %d\nport0 : %b %h %d",
      alu_tb.aluif.porta,alu_tb.aluif.porta,alu_tb.aluif.porta,
      alu_tb.aluif.portb,alu_tb.aluif.portb,alu_tb.aluif.portb,
      alu_tb.aluif.porto, alu_tb.aluif.porto, alu_tb.aluif.porto);
    $display("v_flag %h ; z_flag %h ; n_flag %h \n",alu_tb.aluif.v_flag,alu_tb.aluif.z_flag,alu_tb.aluif.n_flag);
    if(alu_tb.aluif.porto == 32'd6)
      $display("\tPASSED :: SLL\n");
    else
     $error("\tFAILED :: SLL\n");
    $display("************\n");
    

    // Testing SRL
    $display("Testing SRL\n");
    alu_tb.aluif.porta = 32'd3;
    alu_tb.aluif.portb = 32'd1;
    alu_tb.aluif.aluop = ALU_SRL;
    #(3*alu_tb.PERIOD)
    $display("porta : %b %h %d\nportb : %b %h %d\nport0 : %b %h %d",
      alu_tb.aluif.porta,alu_tb.aluif.porta,alu_tb.aluif.porta,
      alu_tb.aluif.portb,alu_tb.aluif.portb,alu_tb.aluif.portb,
      alu_tb.aluif.porto, alu_tb.aluif.porto, alu_tb.aluif.porto);
    $display("v_flag %h ; z_flag %h ; n_flag %h \n",alu_tb.aluif.v_flag,alu_tb.aluif.z_flag,alu_tb.aluif.n_flag);
    if(alu_tb.aluif.porto == 32'd1)
      $display("\tPASS SRL\n");
    else
     $error("\tFAIL SRL\n");
    $display("************\n");

    // Testing ADD
    $display("Testing ADD\n");
    
    $display("Testing +ve ");
    alu_tb.aluif.porta = 32'd3;
    alu_tb.aluif.portb = 32'd1;
    alu_tb.aluif.aluop = ALU_ADD;
    #(3*alu_tb.PERIOD)
    $display("porta : %b %h %d\nportb : %b %h %d\nport0 : %b %h %d",
      alu_tb.aluif.porta,alu_tb.aluif.porta,alu_tb.aluif.porta,
      alu_tb.aluif.portb,alu_tb.aluif.portb,alu_tb.aluif.portb,
      alu_tb.aluif.porto, alu_tb.aluif.porto, alu_tb.aluif.porto);
    $display("v_flag %h ; z_flag %h ; n_flag %h \n",alu_tb.aluif.v_flag,alu_tb.aluif.z_flag,alu_tb.aluif.n_flag);
    
    if(alu_tb.aluif.porto == 32'd4)
      isCorrect = 1;
    else
     isCorrect = 0; 

    $display("Testing large -ves");
    alu_tb.aluif.porta = 32'hC0000003;
    alu_tb.aluif.portb = 32'hC0000000;
    alu_tb.aluif.aluop = ALU_ADD;
    #(3*alu_tb.PERIOD)
    $display("porta : %b %h %d\nportb : %b %h %d\nporto : %b %h %d",
      alu_tb.aluif.porta,alu_tb.aluif.porta,alu_tb.aluif.porta[30:0],
      alu_tb.aluif.portb,alu_tb.aluif.portb,alu_tb.aluif.portb[30:0],
      alu_tb.aluif.porto, alu_tb.aluif.porto, alu_tb.aluif.porto[30:0]);
    $display("v_flag %h ; z_flag %h ; n_flag %h \n",alu_tb.aluif.v_flag,alu_tb.aluif.z_flag,alu_tb.aluif.n_flag);

    $display("Testing small -ves");
    alu_tb.aluif.porta = 32'hFFFFFFF3;
    alu_tb.aluif.portb = 32'hFFFFFFF2;
    alu_tb.aluif.aluop = ALU_ADD;
    #(3*alu_tb.PERIOD)
    $display("porta : %b %h %d\nportb : %b %h %d\nporto : %b %h %d",
      alu_tb.aluif.porta,alu_tb.aluif.porta,alu_tb.aluif.porta[30:0],
      alu_tb.aluif.portb,alu_tb.aluif.portb,alu_tb.aluif.portb[30:0],
      alu_tb.aluif.porto, alu_tb.aluif.porto, alu_tb.aluif.porto[30:0]);
    $display("v_flag %h ; z_flag %h ; n_flag %h \n",alu_tb.aluif.v_flag,alu_tb.aluif.z_flag,alu_tb.aluif.n_flag);

    $display("Testing +Ve + -ve");
    alu_tb.aluif.porta = 32'h3;
    alu_tb.aluif.portb = 32'hFFFFFFF2;
    alu_tb.aluif.aluop = ALU_ADD;
    #(3*alu_tb.PERIOD)
    $display("porta : %b %h %d\nportb : %b %h %d\nporto : %b %h %d",
      alu_tb.aluif.porta,alu_tb.aluif.porta,alu_tb.aluif.porta[30:0],
      alu_tb.aluif.portb,alu_tb.aluif.portb,alu_tb.aluif.portb[30:0],
      alu_tb.aluif.porto, alu_tb.aluif.porto, alu_tb.aluif.porto[30:0]);
    $display("v_flag %h ; z_flag %h ; n_flag %h \n",alu_tb.aluif.v_flag,alu_tb.aluif.z_flag,alu_tb.aluif.n_flag);

    $display("Testing -VEs + +VE");
    alu_tb.aluif.porta = 32'hFFFFFFF3;
    alu_tb.aluif.portb = 32'h2;
    alu_tb.aluif.aluop = ALU_ADD;
    #(3*alu_tb.PERIOD)
    $display("porta : %b %h -%d\nportb : %b %h %d\nporto : %b %h -%d",
      alu_tb.aluif.porta,alu_tb.aluif.porta,~alu_tb.aluif.porta+1'b1,
      alu_tb.aluif.portb,alu_tb.aluif.portb,alu_tb.aluif.portb,
      alu_tb.aluif.porto, alu_tb.aluif.porto,~alu_tb.aluif.porto+1'b1);
    $display("v_flag %h ; z_flag %h ; n_flag %h \n",alu_tb.aluif.v_flag,alu_tb.aluif.z_flag,alu_tb.aluif.n_flag);

    if(isCorrect)
      $display("\tPASSED :: ADD\n");
    else
     $error("\tFAILED :: ADD\n");
    $display("************\n");

    // Testing SUB
    $display("Testing SUB\n");
    
    //
    alu_tb.aluif.porta = 32'd3;
    alu_tb.aluif.portb = 32'd1;
    alu_tb.aluif.aluop = ALU_SUB;
    #(3*alu_tb.PERIOD)
    
    alu_tb.aluif.porta = 32'hF0000003;
    alu_tb.aluif.portb = 32'hF0000000;
    alu_tb.aluif.aluop = ALU_SUB;
    #(3*alu_tb.PERIOD)
    
    alu_tb.aluif.porta = 32'hC0000003;
    alu_tb.aluif.portb = 32'hC0000000;
    alu_tb.aluif.aluop = ALU_SUB;
    #(3*alu_tb.PERIOD)
   
    alu_tb.aluif.porta = 32'hFFFFFFF3;
    alu_tb.aluif.portb = 32'hFFFFFFF2;
    alu_tb.aluif.aluop = ALU_SUB;
    #(3*alu_tb.PERIOD)
    
    alu_tb.aluif.porta = 32'h3;
    alu_tb.aluif.portb = 32'hFFFFFFF2;
    alu_tb.aluif.aluop = ALU_SUB;
    #(3*alu_tb.PERIOD)
    
    alu_tb.aluif.porta = 32'hFFFFFFF3;
    alu_tb.aluif.portb = 32'h2;
    alu_tb.aluif.aluop = ALU_SUB;
    #(3*alu_tb.PERIOD)

    $display("************\n");

    //Testing AND
    alu_tb.aluif.porta = 32'h6;
    alu_tb.aluif.portb = 32'h2;
    alu_tb.aluif.aluop = ALU_AND;
    #(3*alu_tb.PERIOD)    

    //Testing OR 
    alu_tb.aluif.aluop = ALU_OR;
    #(3*alu_tb.PERIOD)

    //Testing XOR
    alu_tb.aluif.aluop = ALU_XOR;
    #(3*alu_tb.PERIOD)

    alu_tb.aluif.aluop = ALU_NOR;
    #(3*alu_tb.PERIOD)

    alu_tb.aluif.aluop = ALU_SLT;
    #(3*alu_tb.PERIOD)

    alu_tb.aluif.porta = 32'hC0000000;
    alu_tb.aluif.portb = 32'h2;
    #(3*alu_tb.PERIOD)

    alu_tb.aluif.aluop = ALU_SLTU;
    #(3*alu_tb.PERIOD)

    alu_tb.aluif.porta = 32'h6;
    alu_tb.aluif.portb = 32'h2;
    #(3*alu_tb.PERIOD)

    $display("-----------------------END TEST-------------------------------");
  end
endprogram
