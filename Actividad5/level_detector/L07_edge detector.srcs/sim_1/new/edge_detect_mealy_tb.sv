`timescale 1ns / 1ps


module edge_detect_mealy_tb();
    reg level_t;         
	reg clk_t;         

	
	edge_detect_mealy uut (.clk(clk_t),
	                       .reset(reset),
	                       .level(level_t),
        		      	   .tick(tick));


	always #5 clk_t = ~clk_t;

	initial begin
		clk_t <= 0;
		level_t <= 0;
		#15 level_t <= 1;
		#20 level_t <= 0;
		#15 level_t <= 1;
		#10 level_t <= 0;
		#20 $finish;
	end
endmodule
