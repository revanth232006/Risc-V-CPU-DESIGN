/*
# Team ID:          2496
# Theme:            Logic-Quest
# Author List:      S M Kavin, Revanth Reddy
# Filename:         t1_riscv_cpu.v
# File Description: datapath.v
# Global variables: None
*/
module datapath (
    input         clk, reset,
    input [1:0]   ResultSrc,
    input         PCSrc, ALUSrc,
    input         RegWrite,jalrsel,
    input [2:0]   ImmSrc,
    input [2:0]   ALUControl,
    output        Zero, lt_flag,
    output [31:0] PC,
    input  [31:0] Instr,
    output [31:0] Mem_WrAddr, Mem_WrData,
    input  [31:0] ReadData,
    output [31:0] Result,
	 input  sltflag
);

wire [31:0] PCNext, PCPlus4, PCTarget, pcjalr;
wire [31:0] ImmExt, SrcA, SrcB, WriteData, ALUResult, AUIPC , lauipc;

// next PC logic
reset_ff #(32) pcreg(clk, reset, pcjalr, PC);
adder          pcadd4(PC, 32'd4, PCPlus4);
adder          pcaddbranch(PC, ImmExt, PCTarget);
mux2 #(32)     pcmux(PCPlus4, PCTarget, PCSrc, PCNext);

// register file logic
reg_file       rf (clk, RegWrite, Instr[19:15], Instr[24:20], Instr[11:7], Result, SrcA, WriteData);
imm_extend     ext (Instr[31:7], ImmSrc, ImmExt);

// ALU logic
mux2 #(32)     srcbmux(WriteData, ImmExt, ALUSrc, SrcB);
alu            alu (SrcA, SrcB, ALUControl, ALUResult, Zero, lt_flag, sltflag);
mux4 #(32)     resultmux(ALUResult, ReadData, PCPlus4, lauipc, ResultSrc, Result);

//Lui & AUIPC Logic
adder #(32) auipcadder(ImmExt, PC, AUIPC);
mux2 #(32) lauipcmux(AUIPC, ImmExt, Instr[5], lauipc);

// jalr Logic
mux2 #(32) jalrmux(PCNext, ALUResult, jalrsel, pcjalr);

	assign Mem_WrData = WriteData;
	assign Mem_WrAddr = ALUResult;

endmodule

