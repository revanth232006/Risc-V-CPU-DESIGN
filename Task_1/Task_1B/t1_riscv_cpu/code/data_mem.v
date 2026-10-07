/*
# Team ID:          2496
# Theme:            Logic-Quest
# Author List:      S M Kavin, Revanth Reddy
# Filename:         t1_riscv_cpu.v
# File Description: Data Memory
# Global variables: None
*/

module data_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 64) (
    input       clk, wr_en,
	 input 		 [2:0] Instr,
    input       [ADDR_WIDTH-1:0] wr_addr,
	 input       [ADDR_WIDTH-1:0] wr_data,
    output   reg [DATA_WIDTH-1:0] rd_data_mem
);

// array of 64 32-bit words or data
reg [DATA_WIDTH-1:0] data_ram [0:MEM_SIZE-1];
reg [ADDR_WIDTH-1:0] wr_data_reg ;
// combinational read logic
// word-aligned memory access
wire [DATA_WIDTH-1:0] read_word = data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE];

// synchronous write logic
always @(*) begin
	case(Instr)
		3'b000: begin 
			wr_data_reg = {{24{wr_data[31]}} ,wr_data[7:0]}; //sb
			rd_data_mem = {{24{read_word[31]}} , read_word[7:0]}; //lb
		end
		3'b001:begin
			wr_data_reg = {{16{wr_data[31]}} ,wr_data[15:0]}; //sh
			rd_data_mem = {{16{read_word[31]}} , read_word[15:0]}; //lh
		end
		3'b010:begin
			wr_data_reg = wr_data; //sw
			rd_data_mem = read_word;//sw
		end
		3'b100: begin
			wr_data_reg = wr_data;
			rd_data_mem = {{24{1'b0}} , read_word[7:0]}; //lbu
		end
		3'b101:begin
			wr_data_reg = wr_data;
			rd_data_mem = {{16{1'b0}} , read_word[15:0]}; //lhu
		end
		default: begin
			wr_data_reg = wr_data;
			rd_data_mem = read_word;
		end
	endcase
end
// synchronous write logic
always @(posedge clk) begin
    if (wr_en) data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE] <= wr_data_reg;
end

endmodule

