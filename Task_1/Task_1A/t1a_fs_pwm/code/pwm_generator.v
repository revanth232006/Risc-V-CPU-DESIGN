/*
# Team ID:          2496
# Theme:            Logic-Quest
# Author List:      S M Kavin, Revanth Reddy
# Filename:         pwm_generator.v
# File Description: Generates pwm signal
# Global variables: None
*/
module pwm_generator(
    input clk_5MHz,
    input reset_n,
    input [4:0] pulse_width,
    output reg clk_500Hz, pwm_signal
);

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE //////////////////
reg [8:0] counter_1 = 0; //counts from 0 to 499
reg [4:0] counter_2 = 0; //counts from 0 to 19 incrementing each time counter_1 resets
initial begin
    clk_500Hz = 0;
	 pwm_signal = 0;
end

always @ (posedge clk_5MHz) begin

//Generates a PWM signal using pluse width and a 500Hz clock signal

	 if(!reset_n) begin
		 counter_1 <= 0;
		 counter_2 <= 0;
		 clk_500Hz <= 0;
	 end 
    else if (counter_1 == 9'd499) begin
	 counter_1 <= 0;
		 if (counter_2 == 5'd19) begin
			 counter_2 <= 5'd0;
		 end
		 else begin
			 counter_2 <= counter_2 + 1;
		 end
	 end 
	 else begin
		 counter_1 <= counter_1 + 1'b1;
	 end
	 
	 if (counter_2 < pulse_width) begin
		 pwm_signal <= 1;
	 end 
	 else begin
		 pwm_signal <= 0;
	 end
	 
	 if (counter_2 < 5'd10) begin
		 clk_500Hz <= 1;
	 end 
	 else begin
		 clk_500Hz <= 0;
	 end
end
//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////
endmodule