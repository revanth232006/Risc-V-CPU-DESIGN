
// riscv_cpu.v - single-cycle RISC-V CPU Processor
/*
# Team ID:          2496
# Theme:            Logic-Quest
# Author List:      S M Kavin, Revanth Reddy
# Filename:         t1_riscv_cpu.v
# File Description: RIsc-V CPU Module
# Global variables: None
*/

module riscv_cpu (
    input         clk, reset,
    output [31:0] PC,
    input  [31:0] Instr,
    output        MemWrite,
    output [31:0] Mem_WrAddr, Mem_WrData,
    input  [31:0] ReadData,
    output [31:0] Result
);

wire        ALUSrc, RegWrite, Jump, Zero, jalrsel, lt_flag, PCSrc, sltflag;
wire [1:0]  ResultSrc;
wire [2:0]  ALUControl, ImmSrc;

controller  c   (Instr[6:0], Instr[14:12], Instr[30], Zero, lt_flag,
                ResultSrc, MemWrite, PCSrc, ALUSrc, RegWrite, jalrsel, Jump,
                ImmSrc, ALUControl, sltflag);

datapath    dp  (clk, reset, ResultSrc, PCSrc,
                ALUSrc, RegWrite, jalrsel, ImmSrc, ALUControl,
                Zero, lt_flag, PC, Instr, Mem_WrAddr, Mem_WrData, ReadData, Result, sltflag);

endmodule

