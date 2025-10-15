`timescale 1ns / 1ps

module top_lvl_tb;
    reg level_t;         
	reg clk_t; 
	reg reset;     
	wire e;   
   // wire [6:0]seven_seg;
    //wire [3:0]anodo;

    wire[7:0] c1,c2;
	top_lvl ut (.btn(level_t),.clk(clk_t),.reset(reset),.count1(c1),.count2(c2),.endec(e));

	// Generate a clock of 100MHz
	always #5 clk_t = ~clk_t;

	// Drive stimulus to the design
	initial begin
		clk_t <= 0;
		level_t <= 0;
		#15ms level_t <= 1;
		#20ms level_t <= 0;
		
		#15ms level_t <= 1;
		#10ms level_t <= 0;
		
		#15ms level_t <= 1;
		#30ms level_t <= 0;
		
		#15ms level_t <= 1;
		#2ms level_t <= 0;
		
		#15ms level_t <= 1;
		#2ms level_t <= 0;
		#3ms level_t <= 1;
		#2ms level_t <= 0;
		#3ms level_t <= 1;
		#10ms level_t <= 0;
		//$monitor("time = %0t, seven_seg = %b, anodo = %b", $time, seven_seg, anodo);
		#20 $finish;
	end
endmodule
