`timescale 1ns / 1ps

module BranchUnit #(
    parameter PC_W = 9
) (
    input logic [PC_W-1:0] Cur_PC,
    input logic [31:0] Imm,
    input logic Branch,
    input logic [31:0] AluResult,
    output logic [31:0] PC_Imm,
    output logic [31:0] PC_Four,
    output logic [31:0] BrPC,
    output logic PcSel
);

  logic Branch_Sel;
  logic Jalr_Sel;
  logic [31:0] PC_Full;

  assign PC_Full = {23'b0, Cur_PC};

  assign PC_Imm = PC_Full + Imm;
  assign PC_Four = PC_Full + 32'b100;
  assign Branch_Sel = Branch && AluResult[0];  // 0:Branch is taken; 1:Branch is not taken
 
    assign Jalr = (AluResult != 0 && AluResult != 1) ? 1 : 0: // verifica se a instrucao em questao eh JAL_R

  assign BrPC = (Jalr) ? AluResult : (Branch_Sel) ? Pc_Imm : 32'b0;  // Branch -> PC+Imm   // se for JALR, carrega o endereco a partir da ALU. Se for Branch, carrega a partir de PC + IMM. se nao for branch, BR_PC eh ignorado
  assign PcSel = Branch_Sel || Jalr;  // 1:branch is taken; 0:branch is not taken(choose pc+4)

endmodule
