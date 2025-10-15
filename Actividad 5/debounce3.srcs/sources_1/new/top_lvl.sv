`timescale 1ns / 1ps

module top_lvl(
    input logic btn,
    input logic clk,
    input logic reset,
    output logic [6:0] seven_seg,
    output logic [3:0] anodo
    );
    
logic [15:0] bit_in;     
    
//señales
logic enable_counter1,enablecounter2;
logic [7:0] q1=8'b00000000;
logic [7:0] q2=8'b00000000;
assign bit_in[7:0]=q1[7:0];
assign bit_in [15:8]=q2[7:0];

logic level;

//counter sin debounce-----------------------------------------------------
edge_detector u1 (.clk(clk),.reset(reset),.level(btn),.tick(enable_counter1));
counter u2 (.clk(clk),.reset(reset),.tick(enable_counter1),.q(q1));

//modulo 7 segmentos-------------------------------------------------------
hex_7seg u3 (.bit_in(bit_in),.reset(reset),.clk(clk),.seven_seg(seven_seg),.anodo(anodo));

//counter debounce----------------------------------------------------------
debouncing a1 (.clk(clk), .reset(reset),.sw_inp(btn),.debounced_out(level));
edge_detector a2 (.clk(clk),.reset(reset),.level(level),.tick(enable_counter2));
counter a3 (.clk(clk),.reset(reset),.tick(enable_counter2),.q(q2));


endmodule