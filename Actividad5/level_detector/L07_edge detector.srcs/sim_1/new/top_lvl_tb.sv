`timescale 1ns / 1ps

module top_lvl_tb;
    reg level_t;         
	reg clk_t;        


	top_lvl ut (.clk(clk_t),
	            .reset(reset),
	            .level(level_t),
        		.tick_Mealy(tick_Mealy),
        		.tick_Moore(tick_Moore));


	always #5 clk_t = ~clk_t;


	initial begin
		clk_t <= 0;
		level_t <= 0;
		#15 level_t <= 1;
		#20 level_t <= 0;
		
		#15 level_t <= 1;
		#10 level_t <= 0;
		
		#15 level_t <= 1;
		#30 level_t <= 0;
		
		#15 level_t <= 1;
		#2 level_t <= 0;
		
		#15 level_t <= 1;
		#2 level_t <= 0;
		#3 level_t <= 1;
		#2 level_t <= 0;
		#3 level_t <= 1;
		#10 level_t <= 0;
		
		#20 $finish;
	end
endmodule
