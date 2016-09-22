/*
  Apoorv Wairagade  
  awairaga@purdue.edu

  ALU file interface
*/
`ifndef MEMWB_IF_VH
`define MEMWB_IF_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface memwb_if;
  // import types
  import cpu_types_pkg::*;

  word_t npc_exmem, npc_memwb;
  word_t rdat1_exmem, rdat1_memwb;
  word_t imm_exmem, imm_memwb;
  word_t portOut_exmem, portOut_memwb;
  
  logic rwen_exmem, rwen_memwb;
  logic memregSel_exmem, memregSel_memwb;
  logic wSel_exmem, wSel_memwb;



  // memwb ports
  modport mwb (
    input npc_exmem, rdat1_exemem, imm_exemem, 
          portOut_exmem, rwen_exmem, memregSel_exmem,
          wSel_exmem,
    output npc_memwb, rdat1_memwb, imm_memwb, portOut_memwb,
           rwen_memwb, memregSel_memwb, wSel_memwb
  );
  // memwb tb
  modport tb (
    output npc_exmem, rdat1_exemem, imm_exemem, 
           portOut_exmem, rwen_exmem, memregSel_exmem,
           wSel_exmem,
    input npc_memwb, rdat1_memwb, imm_memwb, portOut_memwb,
          rwen_memwb, memregSel_memwb, wSel_memwb
  );
endinterface

`endif //MEMWB_IF_VH
