/*
# Team ID:          2496
# Theme:            Logic-Quest
# Author List:      S M Kavin, Revanth Reddy
# Filename:         t1_riscv_cpu.v
# File Description: logic for 3-to-1 multiplexer
# Global variables: None
*/

module mux3 #(parameter WIDTH = 8) (
    input       [WIDTH-1:0] d0, d1, d2,
    input       [1:0] sel,
    output      [WIDTH-1:0] y
);

assign y = sel[1] ? d2: (sel[0] ? d1 : d0);

endmodule

