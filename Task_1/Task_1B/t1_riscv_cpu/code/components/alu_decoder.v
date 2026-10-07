/*
# Team ID:          2496
# Theme:            Logic-Quest
# Author List:      S M Kavin, Revanth Reddy
# Filename:         t1_riscv_cpu.v
# File Description: logic for ALU decoder
# Global variables: None
*/
module alu_decoder (
    input            opb5,
    input [2:0]      funct3,
    input            funct7b5,
    input [1:0]      ALUOp,
    output reg [2:0] ALUControl,
	 output reg			sltflag
);

always @(*) begin
    case (ALUOp)
        2'b00: ALUControl = 3'b000;             // addition
        2'b01: ALUControl = 3'b001;             // subtraction
		  2'b11: begin
		   if (funct3[2]) begin
				ALUControl = 3'b101;
			end
			else begin
				ALUControl = 3'b001;
			end
			end
        default:
            case (funct3) // R-type or I-type ALU
                3'b000: begin
                    // True for R-type subtract
                    if   (funct7b5 & opb5) ALUControl = 3'b001; //sub
                    else ALUControl = 3'b000; // add, addi
                end
					 3'b001:  ALUControl = 3'b100; //shift left logical
					 3'b101:  ALUControl = 3'b111; // shift right logical, shift right arith
                3'b010,3'b011:  ALUControl = 3'b101; // slt, slti, sltiu
					 3'b100:  ALUControl = 3'b110; //xori
                3'b110:  ALUControl = 3'b011; // or, ori
                3'b111:  ALUControl = 3'b010; // and, andi
                default: ALUControl = 3'bxxx; // ???
            endcase
    endcase
	 
	 // sltflag : checks if slt or uslt needs to be performed
	 sltflag = ~funct3[1] || ( ~funct3[0] && ~funct3[2] );
end

endmodule

