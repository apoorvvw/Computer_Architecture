/*
  Apoorv Wairagade
  awairaga@purdue.edu
  mg286
  Sept 11, 2016

  request unit interface
*/
`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

// datapath signals
  // stop processing
  logic halt;

// Cache signals
  word_t instruction;

// Request Unit signals
  logic dwen, dren;

// ALU
  aluop_t aluOp;
  logic [1:0] aluSrc, memToRegSel, extndOp;

  word_t imm;
  logic [SHAM_W-1:0]  shamt;

// Register File
  logic[1:0] instrType; 
  regbits_t rd, rs, rt;
  logic wen;

// PC 
  logic[1:0] pcSel;
  logic [25:0] jump;
  logic branchEnable, branchSel;


  // control unit ports
  modport cu (
    input   instruction,

    output  halt, 
      dwen, dren,  
      aluOp, aluSrc, imm, 
      memToRegSel, extndOp, shamt, 
      instrType, rd, rs, rt, wen,
      pcSel, jump, branchEnable, branchSel
  );
  // register file tb
  modport tb (
    output   halt, 
      dwen, dren,  
      aluOp, aluSrc, imm, 
      memToRegSel, extndOp, shamt, 
      instrType, rd, rs, rt, wen,
      pcSel, jump, branchEnable, branchSel,
    input  instruction
  );
endinterface

`endif //REQUEST_UNIT_IF_VH