timescale 1ns / 1ps

module alu#(
        parameter DATA_WIDTH = 32,
        parameter OPCODE_LENGTH = 4
        )
        (
        input logic [DATA_WIDTH-1:0]    SrcA,
        input logic [DATA_WIDTH-1:0]    SrcB,

        input logic [OPCODE_LENGTH-1:0]    Operation,
        output logic[DATA_WIDTH-1:0] ALUResult
        );
    
        always_comb
        begin
            case(Operation)
            4'b0000:        // AND
                    ALUResult = SrcA & SrcB;
	    4'b0001:	    // OR
	            ALUResult = SrA | SrcB;
            4'b0010:        // ADD || LW/SW
                    ALUResult = SrcA + SrcB;
	    4'b0011:	    // SUB
		    ALUResult = SrcA - SrcB
	    4'b0100:	    // Shift Left logico
		    ALUResult = SrcA << Srcb;
	    4'b0101:	    // Shift Right logico
		    ALUResult = SrcA >> SrcB;
	    4'b0111	    // Shift Right Aritmetico
		    ALUResult = SrcA >>> Srcb:
            4'b1000:        // Equal
                    ALUResult = (SrcA == SrcB) ? 1 : 0;
	    4'b1001:         // BNEQ
		    ALUResult = (SrcA == SrcB) ? 0 : 1;
	    4'b1011:	//BLT
		    ALUResult = (SrcA < SrcB) ? 1 : 0;
	    4'b1100:	    // Shift Left Aritmetico
	 	    ALUResult = SrcA <<< SrcB;
	    4'b1101:	    // XOR
		    ALUResult = SrcA ^ SrcB;
	    4'b1111:	    // BGE
		    ALUResult = (SrcA > SrcB) ? 1 : 0;
            default:
                    ALUResult = 0;
            endcase
        end
endmodule
