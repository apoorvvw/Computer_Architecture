/*
  Apoorv Wairagade  
  awairaga@purdue.edu

  ALU file interface
*/
`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
  // import types
  import cpu_types_pkg::*;

  logic z_flag, n_flag, v_flag;
  aluop_t aluop;
  word_t porta, portb, porto;

  // alu ports
  modport af (
    input   porta, portb, aluop,
    output  z_flag, n_flag, v_flag, porto
  );
  // alu tb
  modport tb (
    input   z_flag, n_flag, v_flag, porto,
    output  porta, portb, aluop
  );
endinterface

`endif //ALU_IF_VH
