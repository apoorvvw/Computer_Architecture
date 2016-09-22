/*
  Apoorv Wairagade
  awairaga@purdue.edu
  mg286
  Sep 14, 2016

  program counter - Counts the program
*/
`ifndef PROGRAM_COUNTER_IF_VH
`define PROGRAM_COUNTER_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface program_counter_if;
  // import types
  import cpu_types_pkg::*;

  logic       updatePC;
  logic[1:0]  pcSel;    
  word_t      npc, rdat1, pc, jump;

  modport p_c (
    input   jump, npc, rdat1, updatePC, pcSel,
    output  pc
  );

  modport tb (
    input   pc,
    output  jump, npc, rdat1, updatePC, pcSel
  );
endinterface

`endif //PROGRAM_COUNTER_IF_VH
