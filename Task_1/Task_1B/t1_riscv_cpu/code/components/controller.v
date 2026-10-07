/*
# Team ID:          2496
# Theme:            Logic-Quest
# Author List:      S M Kavin, Revanth Reddy
# Filename:         t1_riscv_cpu.v
# File Description: controller for RISC-V CPU
# Global variables: None
*/

module controller (
    input [6:0]  op,
    input [2:0]  funct3,
    input        funct7b5,
    input        Zero, lt_flag,
    output       [1:0] ResultSrc,
    output       MemWrite,
    output       PCSrc, ALUSrc,
    output       RegWrite, jalrsel, Jump,
    output [2:0] ImmSrc,
    output [2:0] ALUControl,
	 output sltflag
);

wire [1:0] ALUOp;
wire       Branch;
reg flags;

main_decoder    md (op, ResultSrc, MemWrite, Branch,
                    ALUSrc, RegWrite, Jump, jalrsel, ImmSrc, ALUOp);

alu_decoder     ad (op[5], funct3, funct7b5, ALUOp, ALUControl, sltflag);

// for jump and branch
always @(*) begin
	case (funct3)
		3'b000: flags = Zero; //beq
		3'b001: flags = ~Zero; //bne
		3'b100, 3'b110: flags = ~lt_flag; //blt, bltu
		3'b101, 3'b111: flags = lt_flag; //bge, bgeu
		default: flags = 1'bx; 
	endcase
end
assign PCSrc = (Branch & flags) | Jump;
endmodule

