`timescale 1ns / 1ps

module top_2(
    input clk,clr,ready,
    input [7:0] tx_data,
    output txd
    );
    
logic td;
    trans_mod tr(.clk(clk),.clr(clr),.ready(ready),.tx_data(tx_data),.txd(txd),.tdre(td));
endmodule
