`timescale 1ns / 1ps


module top_trans_n(
    input [7:0]sw,
    input reset,
    input btn1,
    input clk,
    output TxD
    );
    logic gos,tr; 
    
    //debounce a1(.clk(clk), .reset(reset),.sw_inp(btn1),.debounced_out(gos));
    //lvl_dtctr a2(.clk(clk),.reset(reset),.level(gos),.tick(tr));
    test_trans a3 (.clk(clk), .reset(reset),.transmit(btn1),.TxD(TxD),.data(sw));


endmodule
