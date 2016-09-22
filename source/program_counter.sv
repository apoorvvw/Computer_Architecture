/*
  Apoorv Wairagade
  awairaga@purdue.edu
  mg286
  Sep 14, 2016

  program counter - Counts the program
*/

`include "program_counter_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module program_counter (
  input logic CLK, nRST,
  program_counter_if.p_c pcif
);
  import cpu_types_pkg::*;

  word_t currentPC, nextPC;

  always_ff @(posedge CLK , negedge nRST) begin : proc_PC
    if(~nRST) begin
      currentPC <= 0;
    end else begin
      if(pcif.updatePC)
        currentPC <= nextPC; 
      else 
        currentPC <= currentPC;
    end
  end

  always_comb begin : proc_Next_State_Logic
    if(pcif.pcSel == 2'b00)
      nextPC = pcif.rdat1;
    else if (pcif.pcSel == 2'b01)
      nextPC = pcif.npc;
    else if (pcif.pcSel == 2'b10)
      nextPC = pcif.jump;
    else
      nextPC = currentPC;
  end

assign pcif.pc = currentPC;

endmodule