`timescale 1ns / 1ps


module edge_detect_mealy_tb();
    reg level_t;         // Declare internal TB signal called sig to drive the sig pin of the design
	reg clk_t;         // Declare internal TB signal called clk to drive clock to the design

	// Instantiate the design in TB and connect with signals in TB
	edge_detect_mealy uut (.clk(clk_t),
	                       .reset(reset),
	                       .level(level_t),
        		      	   .tick(tick));

	// Generate a clock of 100MHz
	always #5 clk_t = ~clk_t;

	// Drive stimulus to the design
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
