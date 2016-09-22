/*
  Apoorv Wairagade
  awairaga@purdue.edu

  ALU sv file
*/

`include "alu_if.vh"
`include "cpu_types_pkg.vh"

module alu
(
    alu_if.af aluif
);

import cpu_types_pkg::*;

always_comb begin
	
	aluif.v_flag = 1'b0;
	aluif.porto = '0;

	casez(aluif.aluop)
		ALU_SLL: begin
			aluif.porto = aluif.porta << aluif.portb; // Doesn't Sign extends
		end // ALU_SLL:
		
		ALU_SRL: begin
			aluif.porto = aluif.porta >> aluif.portb; // Doesn't Sign extends
		end // ALU_SRL:
		
		ALU_ADD: begin
			aluif.porto = $signed(aluif.porta) + $signed(aluif.portb);
			if (aluif.porta[31] == aluif.portb[31]) begin
				if (aluif.portb[31] != aluif.porto[31])
					aluif.v_flag = 1'b1;
				else
					aluif.v_flag = 1'b0;
			end
			else
				aluif.v_flag = 1'b0;
		end // ALU_ADD:
		
		ALU_SUB: begin
			aluif.porto = $signed(aluif.porta) - $signed(aluif.portb);
			if (( aluif.porta[31] != aluif.portb[31] )) begin
				if (aluif.portb[31] ==  aluif.porto[31])
					aluif.v_flag = 1'b1;
				else
					aluif.v_flag = 1'b0;
			end
			else
				aluif.v_flag = 1'b0;
		end // ALU_SUB:
		
		ALU_AND: begin
			aluif.porto = aluif.porta & aluif.portb;
		end // ALU_AND:
		
		ALU_OR: begin
			aluif.porto = aluif.porta | aluif.portb;
		end // ALU_OR:
		
		ALU_XOR: begin
			aluif.porto = aluif.porta ^ aluif.portb;
		end // ALU_XOR:
		
		ALU_NOR: begin
			aluif.porto = ~(aluif.porta | aluif.portb);
		end // ALU_NOR:
		
		ALU_SLT: begin
			aluif.porto = ($signed(aluif.porta)) < ($signed(aluif.portb));
		end // ALU_SLT:

		ALU_SLTU : begin
			aluif.porto = aluif.porta < aluif.portb;
		end // ALU_SLTU :
	endcase
end // always_comb

assign aluif.n_flag = aluif.porto[31];
assign aluif.z_flag = aluif.porto ? 1'b0 : 1'b1;

endmodule // alu