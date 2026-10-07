/*
# Team ID:          2496
# Theme:            Logic-Quest
# Author List:      S M Kavin, Revanth Reddy
# Filename:         t1_riscv_cpu.v
# File Description: ALU module
# Global variables: None
*/
module alu #(parameter WIDTH = 32) (
    input       [WIDTH-1:0] a, b,      // operands
    input       [2:0] alu_ctrl,        // ALU control
    output reg  [WIDTH-1:0] alu_out,   // ALU output
    output      zero, lt_flag,         // zero flag
	 input		 sltflag						// slt flag
);

always @(a, b, alu_ctrl, sltflag) begin
    case (alu_ctrl)
        3'b000:  alu_out <= a + b;       // ADD
        3'b001:  alu_out <= a + ~b + 1;  // SUB
        3'b010:  alu_out <= a & b;       // AND
        3'b011:  alu_out <= a | b;       // OR
		  3'b100:  alu_out <= (a<<b[4:0]); //SHIFT LEFT LOGICAL
        3'b101:  begin                   // SIGNED LESS THAN, UNSIGNED LESS THAN
                     if (a[31] != b[31] && sltflag) alu_out <= a[31] ? 1 : 0;
                     else alu_out <= a < b ? 1 : 0;
                 end
			3'b110: alu_out <= a^b; //XOR
			3'b111: begin 
						if (b[10]) begin
							alu_out <= $signed(a) >>> b[4:0]; //SHIFT RIGHT LOGICAL
						end
						else alu_out <= a>>b[4:0]; //SHIFT RIGHT ARITH
						end
	
        default: alu_out = 0;
    endcase
end

assign zero = (alu_out == 0) ? 1'b1 : 1'b0; // Generates zero flag
assign lt_flag =  (alu_out == 0) ? 1'b1 : 1'b0; // Generates less than flag

endmodule

