/*
# Team ID:          2496
# Theme:            Logic-Quest
# Author List:      S M Kavin, Revanth Reddy
# Filename:         t1_riscv_cpu.v
# File Description: logic for main decoder
# Global variables: None
*/

module main_decoder (
    input  [6:0] op,
    output [1:0] ResultSrc,
    output       MemWrite, Branch, ALUSrc,
    output       RegWrite, Jump, jalrsel,
    output [2:0] ImmSrc,
    output [1:0] ALUOp
);

reg [12:0] controls;

always @(*) begin
    casez (op)
        // RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp_Jump_Jalr
        7'b0000011: controls = 13'b1_000_1_0_01_0_00_0_0; // I-type Memory Read
        7'b0100011: controls = 13'b0_001_1_1_00_0_00_0_0; // S-type Memory Write
        7'b0110011: controls = 13'b1_xxx_0_0_00_0_10_0_0; // R–type
        7'b1100011: controls = 13'b0_010_0_0_00_1_11_0_0; // B-type
        7'b0010011: controls = 13'b1_000_1_0_00_0_10_0_0; // I–type ALU
        7'b1101111: controls = 13'b1_011_0_0_10_0_00_1_0; // jal
		  7'b1100111: controls = 13'b1_000_1_0_10_0_00_0_1; // Jalr
		  7'b0?10111: controls = 13'b1_100_x_0_11_0_xx_0_0;  // lui, auipc
		  default:    controls = 13'bx_xxx_x_x_xx_x_xx_x_x; // ???
    endcase
end

assign {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump, jalrsel} = controls;

endmodule

