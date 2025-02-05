`timescale 1ns / 1ps

module imm_Gen (
    input  logic [31:0] inst_code,
    output logic [31:0] Imm_out
);
// criar condicional para srai, slli, srli(usando funct3

  always_comb
    case (inst_code[6:0])
      7'b0000011:  /*I-type load part*/
      Imm_out = {inst_code[31] ? 20'hFFFFF : 20'b0, inst_code[31:20]};

      7'b0010011: //*I-type (addi, slti, andi, etc
      if((inst_code[14:12] == 3'b001) || inst_code[14:12] == 3'b101) {
	  Imm_out = {27'b, inst_code[24-20]}; // se for srai, srli, slli
      else
      	Imm_out = {inst_code[31] ? 20'hFFFFF : 20'b0, inst_code[31:20]};

      7'b0100011:  /*S-type*/
      Imm_out = {inst_code[31] ? 20'hFFFFF : 20'b0, inst_code[31:25], inst_code[11:7]}; // verifica se o numero eh negativo. se for positivo, os 20 primeiros valores sao 0

      7'b1100011:  /*B-type*/
      Imm_out = {
        inst_code[31] ? 19'h7FFFF : 19'b0,  // verifica se o numero eh negativo
        inst_code[31],
        inst_code[7],
        inst_code[30:25],
        inst_code[11:8],
        1'b0
      };

      default: Imm_out = {32'b0};

    endcase

endmodule
