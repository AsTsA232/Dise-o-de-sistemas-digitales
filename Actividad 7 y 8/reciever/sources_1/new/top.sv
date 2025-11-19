`timescale 1ns / 1ps

module top(
    input clr,clk,rdx,
    output fe,txd,atg,an
    );

logic rdrfs, rdrf_clrs, tdres, rds, clk2; 
logic [7:0] data;
    test_rx_crtl u1 (.clk(clk),.clr(clr),.rdrf(rdrfs),.rdrf_clr(rdrf_clrs));
    recep_mod u2(.clk(clk),.clr(clr),.rxd(rdx),.rdrf_clr(rdrf_clrs),.rdrf(rdrfs), .fe(fe),.rx_data(data));
    test_tx u3(.go(rdrf_clrs),.clr(clr),.tdre(tdres),.cclk(clk),.ready(rds));
    tx_mod u4(.clk(clk),.clr(clr), .ready(rds),.tx_data(data),.txd(txd),.tdre(tdres));
    seg7(.reset(clr), .clk(clk),.sw(data),.sal(atg), .an(an));
endmodule
