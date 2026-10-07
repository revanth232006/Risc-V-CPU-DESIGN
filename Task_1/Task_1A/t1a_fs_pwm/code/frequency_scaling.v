// Logic Quest Bot : Task 1A : Frequency Scaling
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a module which will scale down the 50MHz Clock Frequency to clk_5MHz

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//Frequency Scaling
//Inputs : clk_50MHz
//Output : 5MHz

/*
# Team ID:          2496
# Theme:            Logic-Quest
# Author List:      S M Kavin, Revanth Reddy
# Filename:         frequency_scaling.v
# File Description: Scales down 50MHz clock signal to 5MHz
# Global variables: None
*/
module frequency_scaling (
    input clk_50MHz,
    input reset_n,
    output reg clk_5MHz
);

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE //////////////////
reg [2:0] counter = 0; //Counts clk cycles between successive toggles of 5OMHz clk.
reg trigger = 0; //trigger flag so that output clk toggled once immediately after reset
initial begin
    clk_5MHz = 0;
end

always @ (posedge clk_50MHz) begin

//Generates a 5 MHz clock from the 50 MHz input clock using a counter

	 if(!reset_n) begin
		trigger <= 0;
		counter <= 0;
		clk_5MHz <= 0;
	end 
	else if (!trigger) begin
	 trigger <= 1;
	 clk_5MHz <= ~clk_5MHz;
	 end
    else if (counter == 3'b100) begin
	 clk_5MHz <= ~clk_5MHz;
	 counter <= 0;
	end 
	else
    counter <= counter + 1'b1; 
end

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE //////////////////

endmodule

