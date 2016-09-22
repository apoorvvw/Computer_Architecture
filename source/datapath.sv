/*
  Apoorv Wairagade
  awairaga@purdue.edu
  mg286
  Sept 14, 2016

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "register_file_if.vh"
`include "request_unit_if.vh"
`include "alu_if.vh"
`include "program_counter_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;

  word_t branchAddr, npc, jumpAddress;

  program_counter_if pcif ();
  register_file_if   rfif ();
  request_unit_if    ruif ();
  control_unit_if    cuif ();
  alu_if             aluif();

  register_file   RF  (CLK, nRST, rfif);
  request_unit    RU  (CLK, nRST, ruif);
  alu             ALU (aluif);
  control_unit    CU  (cuif);
  program_counter PC  (CLK, nRST, pcif);

  //--------------------------------------------
  // Program Counter
  
  assign pcif.rdat1 = rfif.rdat1;
  assign pcif.jump = jumpAddress;
  assign pcif.pcSel = cuif.pcSel;
  assign pcif.npc = ((cuif.branchSel != aluif.z_flag) && cuif.branchEnable) ? npc + branchAddr : npc ;
  assign pcif.updatePC = ruif.updatePC;

  //--------------------------------------------
  //Cache
  assign dpif.imemREN   = ruif.iren;
  assign dpif.imemaddr  = pcif.pc;

  assign dpif.dmemREN   = ruif.dren;
  assign dpif.dmemWEN   = ruif.dwen;
  assign dpif.dmemaddr  = aluif.porto;
  assign dpif.dmemstore = rfif.rdat2;

  always_ff @(posedge CLK or negedge nRST) begin
    if(~nRST) begin
      dpif.halt <= 0;
    end else begin
      dpif.halt <= cuif.halt;
    end
  end

  //--------------------------------------------
  //Request Unit
  assign ruif.ihit = dpif.ihit;
  assign ruif.dhit = dpif.dhit;
  assign ruif.CUhalt = cuif.halt;
  assign ruif.CUdwen = cuif.dwen;
  assign ruif.CUdren = cuif.dren;

  //--------------------------------------------
  //Register File
  assign rfif.WEN   = cuif.wen  & (dpif.ihit | dpif.dhit);
  assign rfif.rsel1 = cuif.rs;
  assign rfif.rsel2 = cuif.rt;
  // rfif.wdat done in proc_MUX
  // rfif.wsel done in proc_MUX
  
  //--------------------------------------------
  // ALU
  assign aluif.porta = rfif.rdat1;
  // aluif.portb done in proc_MUX
  assign aluif.aluop = cuif.aluOp;

  //--------------------------------------------
  // Control Unitf
  assign cuif.instruction = dpif.imemload;

  //--------------------------------------------

  logic[27:0] jump_left2;
  always_comb begin : proc_calculation
    
    // Calculating Jump address
    npc = pcif.pc + 32'h4;
    jump_left2 = {2'b00 , cuif.jump} << 2;
    jumpAddress = {npc[31:28],jump_left2};

    // Calculating branch address
    branchAddr = { {16{dpif.imemload[15]}}, dpif.imemload[15:0] } << 2 ;
  end

  //--------------------------------------------

  always_comb begin : proc_MUX
    
    // ALUSrc
    if(cuif.aluSrc == 2'b00)
      aluif.portb = rfif.rdat2;
    else if (cuif.aluSrc == 2'b01)
      aluif.portb = cuif.shamt;
    else 
      aluif.portb = cuif.imm;

    // memToRegSel
    if(cuif.memToRegSel == 2'b00)    
      rfif.wdat = aluif.porto;
    else if (cuif.memToRegSel == 2'b01)
      rfif.wdat = npc;
    else
      rfif.wdat = dpif.dmemload;

    // InstrType
    if(cuif.instrType == 2'b00)
      rfif.wsel = cuif.rd;
    else if (cuif.instrType == 2'b01)
      rfif.wsel = 32'd31; // TODO: Change to $31
    else
      rfif.wsel = cuif.rt;
  end


endmodule