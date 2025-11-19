`timescale 1ns / 1ps

module top(
    input btn,clr,clk,
    input [7:0] sw,
    output logic [6:0]seg,
    output logic [3:0]an,
    output logic txd
    );
logic cclk, gos, reds, tdres;
   clk_dlv u1 (.reset(clr), .clk(clk), .clk2(cclk));
   debounce u2(.clk(cclk), .reset(clr),.sw_inp(btn),.debounced_out(gos));
   test_tx_ctrl u3 (.go(gos),.clr(clr),.tdre(tdres),.cclk(clk),.ready(reds));
   //trans_mod u4 (.clk(cclk),.clr(clr), .ready(reds), .tx_data(sw),.txd(txd),.tdre(tdres));
   seg u5(.reset(clr),.clk(clk),.sw(sw),.sal(seg),.an(an));
endmodule
