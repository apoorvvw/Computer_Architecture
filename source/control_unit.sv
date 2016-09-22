/*
  Apoorv Wairagade
  awairaga@purdue.edu
  mg286
  Sept 12, 2016

  Control Unit 
*/

`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module control_unit (
  control_unit_if.cu cuif
);
  // DECLARE VARIABLES
  opcode_t opcode;
  funct_t rtype;
  aluop_t aluop;

  logic[IMM_W - 1:0] immediate;

  assign opcode = opcode_t'(cuif.instruction[31:26]);
  assign rtype  = funct_t' (cuif.instruction[5:0 ]);

  assign immediate = cuif.instruction[15:0];
  assign cuif.shamt = cuif.instruction[10:6];
  assign cuif.rd = cuif.instruction[15:11];
  assign cuif.rs = cuif.instruction[25:21];
  assign cuif.rt = cuif.instruction[20:16];
  
  assign cuif.jump = cuif.instruction[25:0];

  always_comb begin : CPU
    // Default case
    cuif.branchSel = 1;
    cuif.halt = 0;
    cuif.dwen = 0;
    cuif.dren = 0;
    cuif.aluOp = ALU_OR;
    cuif.aluSrc = 0;
    cuif.imm = '0;
    cuif.memToRegSel = 0;
    cuif.extndOp = 0;
    cuif.instrType = 0;
    cuif.wen = 0;
    cuif.pcSel = 1;
    cuif.branchEnable = 0;
    cuif.branchSel = 0;    
    cuif.halt = 0;
    case(opcode)
      default: begin
        // Default case
        cuif.branchSel = 1;
        cuif.halt = 0;
        cuif.dwen = 0;
        cuif.dren = 0;
        cuif.aluOp = ALU_OR;
        cuif.aluSrc = 0;
        cuif.imm = '0;
        cuif.memToRegSel = 0;
        cuif.extndOp = 0;
        cuif.instrType = 0;
        cuif.wen = 0;
        cuif.pcSel = 1;
        cuif.branchEnable = 0;
        cuif.branchSel = 0;
      end

      HALT: begin
        cuif.halt = 1;
      end

      RTYPE: begin
        // Default case
        cuif.branchEnable = 0;    
        case(rtype)
          SLL : begin
            cuif.aluOp = ALU_SLL;

            cuif.aluSrc = 2'b01;
            cuif.instrType = 2'b00; // Select input 2
            cuif.memToRegSel = 2'b00;
            
            // PC to npc
            cuif.branchEnable = 0;
            cuif.pcSel = 2'b01; 

            cuif.wen = 1; // Enable Reg write
            cuif.dren = 0;// Disable RAM read
            cuif.dwen = 0;// Disable RAM write
          end
          SRL : begin
            cuif.aluOp = ALU_SRL;

            cuif.aluSrc = 2'b01;
            cuif.instrType = 2'b00; // Select input 2
            cuif.memToRegSel = 2'b00;
            
            // PC to npc
            cuif.branchEnable = 0;
            cuif.pcSel = 2'b01; 

            cuif.wen = 1; // Enable Reg write
            cuif.dren = 0;// Disable RAM read
            cuif.dwen = 0;// Disable RAM write            
          end
          JR: begin
            cuif.pcSel = 2'b00;
          end
          ADD: begin
            cuif.aluOp = ALU_ADD;

            cuif.aluSrc = 2'b00;
            cuif.instrType = 2'b00; // Select input 2
            cuif.memToRegSel = 2'b00;
            
            // PC to npc
            cuif.branchEnable = 0;
            cuif.pcSel = 2'b01; 

            cuif.wen = 1; // Enable Reg write
            cuif.dren = 0;// Disable RAM read
            cuif.dwen = 0;// Disable RAM write
          end
          ADDU: begin
            cuif.aluOp = ALU_ADD;

            cuif.aluSrc = 2'b00;
            cuif.instrType = 2'b00; // Select input 2
            cuif.memToRegSel = 2'b00;
            // PC to npc
            cuif.branchEnable = 0;
            cuif.pcSel = 2'b01; 

            cuif.wen = 1; // Enable Reg write
            cuif.dren = 0;// Disable RAM read
            cuif.dwen = 0;// Disable RAM write
          end
          SUB: begin
            cuif.aluOp = ALU_SUB;

            cuif.aluSrc = 2'b00;
            cuif.instrType = 2'b00; // Select input 2
            cuif.memToRegSel = 2'b00;
            // PC to npc
            cuif.branchEnable = 0;
            cuif.pcSel = 2'b01; 

            cuif.wen = 1; // Enable Reg write
            cuif.dren = 0;// Disable RAM read
            cuif.dwen = 0;// Disable RAM write
          end
          SUBU: begin
            cuif.aluOp = ALU_SUB;

            cuif.aluSrc = 2'b00;
            cuif.instrType = 2'b00; // Select input 2
            cuif.memToRegSel = 2'b00;
            // PC to npc
            cuif.branchEnable = 0;
            cuif.pcSel = 2'b01; 

            cuif.wen = 1; // Enable Reg write
            cuif.dren = 0;// Disable RAM read
            cuif.dwen = 0;// Disable RAM write
          end
          AND: begin
            cuif.aluOp = ALU_AND;

            cuif.aluSrc = 2'b00;
            cuif.instrType = 2'b00; // Select input 2
            cuif.memToRegSel = 2'b00;
            // PC to npc
            cuif.branchEnable = 0;
            cuif.pcSel = 2'b01; 

            cuif.wen = 1; // Enable Reg write
            cuif.dren = 0;// Disable RAM read
            cuif.dwen = 0;// Disable RAM write
          end
          OR: begin
            cuif.aluOp = ALU_OR;

            cuif.aluSrc = 2'b00;
            cuif.instrType = 2'b00; // Select input 2
            cuif.memToRegSel = 2'b00;
            // PC to npc
            cuif.branchEnable = 0;
            cuif.pcSel = 2'b01; 

            cuif.wen = 1; // Enable Reg write
            cuif.dren = 0;// Disable RAM read
            cuif.dwen = 0;// Disable RAM write
          end
          XOR: begin
            cuif.aluOp = ALU_XOR;

            cuif.aluSrc = 2'b00;
            cuif.instrType = 2'b00; // Select input 2
            cuif.memToRegSel = 2'b00;
            // PC to npc
            cuif.branchEnable = 0;
            cuif.pcSel = 2'b01; 

            cuif.wen = 1; // Enable Reg write
            cuif.dren = 0;// Disable RAM read
            cuif.dwen = 0;// Disable RAM write
          end          
          NOR: begin
            cuif.aluOp = ALU_NOR;

            cuif.aluSrc = 2'b00;
            cuif.instrType = 2'b00; // Select input 2
            cuif.memToRegSel = 2'b00;
            // PC to npc
            cuif.branchEnable = 0;
            cuif.pcSel = 2'b01; 

            cuif.wen = 1; // Enable Reg write
            cuif.dren = 0;// Disable RAM read
            cuif.dwen = 0;// Disable RAM write
          end
          SLT: begin
            cuif.aluOp = ALU_SLT;

            cuif.aluSrc = 2'b00;
            cuif.instrType = 2'b00; // Select input 2
            cuif.memToRegSel = 2'b00;
            // PC to npc
            cuif.branchEnable = 0;
            cuif.pcSel = 2'b01; 

            cuif.wen = 1; // Enable Reg write
            cuif.dren = 0;// Disable RAM read
            cuif.dwen = 0;// Disable RAM write
          end
          SLTU: begin
            cuif.aluOp = ALU_SLTU;

            cuif.aluSrc = 2'b00;
            cuif.instrType = 2'b00; // Select input 2
            cuif.memToRegSel = 2'b00;
            // PC to npc
            cuif.branchEnable = 0;
            cuif.pcSel = 2'b01; 

            cuif.wen = 1; // Enable Reg write
            cuif.dren = 0;// Disable RAM read
            cuif.dwen = 0;// Disable RAM write
          end                
        endcase // rtype
      end

      J: begin
        // PC to npc
        cuif.branchEnable = 0;
        cuif.pcSel = 2'b10; 

        cuif.dren = 0;// Disable RAM read
        cuif.dwen = 0;// Disable RAM write        
      end

      JAL: begin
            cuif.aluOp = ALU_ADD;

            cuif.aluSrc = 2'b10;
            cuif.instrType = 2'b01; // Select input 2
            cuif.memToRegSel = 2'b01;
            cuif.extndOp = 2'b10;
            cuif.imm = 16'b0;
            // PC to npc
            cuif.branchEnable = 0;
            cuif.pcSel = 2'b10; 

            cuif.wen = 1; // Enable Reg write
            cuif.dren = 0;// Disable RAM read
            cuif.dwen = 0;// Disable RAM write        
      end

      BEQ: begin
        cuif.aluOp = ALU_SUB;
        cuif.aluSrc = 0;
        cuif.instrType = 2'b01; // Select input 2
        cuif.memToRegSel = 2'b00;
        
        // PC to npc
        cuif.branchEnable = 1;
        cuif.branchSel = 0;
        cuif.pcSel = 2'b01; 

        cuif.wen  = 0; // Enable Reg write
        cuif.dren = 0;// Disable RAM read
        cuif.dwen = 0;// Disable RAM write
      end
      BNE: begin
        cuif.aluOp = ALU_SUB;
        cuif.aluSrc = 0;
        cuif.instrType = 2'b01; // Select input 2
        cuif.memToRegSel = 2'b00;
        
        // PC to npc
        cuif.branchEnable = 1;
        cuif.branchSel = 1;
        cuif.pcSel = 2'b01; 

        cuif.wen  = 0; // Enable Reg write
        cuif.dren = 0;// Disable RAM read
        cuif.dwen = 0;// Disable RAM write
      end
      
      ADDI: begin
        cuif.aluOp = ALU_ADD;
        cuif.extndOp = 2'b00;
        cuif.aluSrc = 2'b10;
        cuif.instrType = 2'b10; // Select input 2
        cuif.memToRegSel = 2'b00;
        
        // PC to npc
        cuif.branchEnable = 0;
        cuif.pcSel = 2'b01; 

        cuif.wen = 1; // Enable Reg write
        cuif.dren = 0;// Disable RAM read
        cuif.dwen = 0;// Disable RAM write
      end

      ADDIU: begin
        cuif.aluOp = ALU_ADD;
        cuif.extndOp = 2'b00;
        cuif.aluSrc = 2'b10;
        cuif.instrType = 2'b10; // Select input 2
        cuif.memToRegSel = 2'b00;
        
        // PC to npc
        cuif.branchEnable = 0;
        cuif.pcSel = 2'b01; 

        cuif.wen = 1; // Enable Reg write
        cuif.dren = 0;// Disable RAM read
        cuif.dwen = 0;// Disable RAM write
      end
      ANDI: begin
        cuif.aluOp = ALU_AND;
        cuif.extndOp = 2'b01;
        cuif.aluSrc = 2'b10;
        cuif.instrType = 2'b10; // Select input 2
        cuif.memToRegSel = 2'b00;
        
        // PC to npc
        cuif.branchEnable = 0;
        cuif.pcSel = 2'b01; 

        cuif.wen = 1; // Enable Reg write
        cuif.dren = 0;// Disable RAM read
        cuif.dwen = 0;// Disable RAM write
      end

      SLTI: begin
        cuif.aluOp = ALU_SLT;
        cuif.extndOp = 2'b00;
        cuif.aluSrc = 2'b10;
        cuif.instrType = 2'b10; // Select input 2
        cuif.memToRegSel = 2'b00;
        
        // PC to npc
        cuif.branchEnable = 0;
        cuif.pcSel = 2'b01; 

        cuif.wen = 1; // Enable Reg write
        cuif.dren = 0;// Disable RAM read
        cuif.dwen = 0;// Disable RAM write
      end
      SLTIU: begin
        cuif.aluOp = ALU_SLTU;
        cuif.extndOp = 2'b00;
        cuif.aluSrc = 2'b10;
        cuif.instrType = 2'b10; // Select input 2
        cuif.memToRegSel = 2'b00;
        
        // PC to npc
        cuif.branchEnable = 0;
        cuif.pcSel = 2'b01; 

        cuif.wen = 1; // Enable Reg write
        cuif.dren = 0;// Disable RAM read
        cuif.dwen = 0;// Disable RAM write
      end
      
      ORI: begin
        cuif.aluOp = ALU_OR;
        cuif.extndOp = 2'b01;
        cuif.aluSrc = 2'b10;
        cuif.instrType = 2'b10; // Select input 2
        cuif.memToRegSel = 2'b00;
        
        // PC to npc
        cuif.branchEnable = 0;
        cuif.pcSel = 2'b01; 

        cuif.wen = 1; // Enable Reg write
        cuif.dren = 0;// Disable RAM read
        cuif.dwen = 0;// Disable RAM write
      end      

      XORI: begin
        cuif.aluOp = ALU_XOR;
        cuif.extndOp = 2'b01;
        cuif.aluSrc = 2'b10;
        cuif.instrType = 2'b10; // Select input 2
        cuif.memToRegSel = 2'b00;
        
        // PC to npc
        cuif.branchEnable = 0;
        cuif.pcSel = 2'b01; 

        cuif.wen = 1; // Enable Reg write
        cuif.dren = 0;// Disable RAM read
        cuif.dwen = 0;// Disable RAM write
      end

      SLT: begin
        cuif.aluOp = ALU_SLT;
        cuif.extndOp = 2'b00;
        cuif.aluSrc = 2'b10;
        cuif.instrType = 2'b10; // Select input 2
        cuif.memToRegSel = 2'b00;
        
        // PC to npc
        cuif.branchEnable = 0;
        cuif.pcSel = 2'b01; 

        cuif.wen = 1; // Enable Reg write
        cuif.dren = 0;// Disable RAM read
        cuif.dwen = 0;// Disable RAM write
      end

      LW: begin 
        cuif.aluOp = ALU_ADD;
        cuif.extndOp = 2'b00;
        cuif.aluSrc = 2'b10;
        cuif.instrType = 2'b10; // Select input 2
        cuif.memToRegSel = 2'b10;
        
        // PC to npc
        cuif.branchEnable = 0;
        cuif.pcSel = 2'b01; 

        cuif.wen  = 1; // Enable Reg write
        cuif.dren = 1;// Enable RAM read
        cuif.dwen = 0;// Disable RAM write
      end

      SW: begin 
        cuif.aluOp = ALU_ADD;
        cuif.extndOp = 2'b00;
        cuif.aluSrc = 2'b10;
        cuif.instrType = 2'b10; // Select input 2
        cuif.memToRegSel = 2'b10;
        
        // PC to npc
        cuif.branchEnable = 0;
        cuif.pcSel = 2'b01; 

        cuif.wen  = 0; // Enable Reg write
        cuif.dren = 0;// Disable RAM read
        cuif.dwen = 1;// Disable RAM write
      end

      LUI: begin 
        cuif.aluOp = ALU_ADD;
        cuif.extndOp = 2'b10;
        cuif.aluSrc = 2'b10;
        cuif.instrType = 2'b10; // Select input 2
        cuif.memToRegSel = 2'b00;
        cuif.imm = '0;
        // PC to npc
        cuif.branchEnable = 0;
        cuif.pcSel = 2'b01; 

        cuif.wen  = 1; // Enable Reg write
        cuif.dren = 0;// Disable RAM read
        cuif.dwen = 0;// Disable RAM write        
      end

    endcase // opcpode 

    // Extend Block
    if(cuif.extndOp == 2'b00)
      cuif.imm = { {16{immediate[15]}}, immediate };
    else if (cuif.extndOp == 2'b01)
      cuif.imm = { 16'b0, immediate};
    else if (cuif.extndOp == 2'b10)
      cuif.imm = { immediate , 16'b0 };
    else
      cuif.imm = { {16{immediate[15]}}, immediate };
  end
endmodule