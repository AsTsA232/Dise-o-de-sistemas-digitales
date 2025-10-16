`timescale 1ns / 1ps

module top_lvl(
    input clk,
    input reset,
    input level,
    output tick_Moore, tick_Mealy
    );
    
    edge_detect_mealy u1 (.clk(clk),.reset(reset),.level(level),.tick(tick_Mealy));
    edge_detect_moore u2(.clk(clk),.reset(reset),.level(level),.tick(tick_Moore));
endmodule
