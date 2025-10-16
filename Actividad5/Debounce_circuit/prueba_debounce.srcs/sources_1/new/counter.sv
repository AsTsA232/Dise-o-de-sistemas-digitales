`timescale 1ns / 1ps

module counter
#(parameter N=8)(
    input clk,reset,tick,
    output [N-1:0] q
);

logic [N-1:0] state_reg,state_nxt;
always_ff @(posedge clk, posedge reset)
    if(reset)
    state_reg<=0;
    else
    state_reg<=state_nxt;  
    
always_comb
    if(tick) 
        state_nxt<=state_reg +1;
    else
        state_nxt<=state_reg;
    
assign q=state_reg;
endmodule
