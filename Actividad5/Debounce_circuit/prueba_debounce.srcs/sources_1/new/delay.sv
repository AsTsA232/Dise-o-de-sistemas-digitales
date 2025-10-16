`timescale 1ns / 1ps

module delay
#(parameter N=20)(
    input clk,reset,
    output logic m_tick
    );
    
logic[N-1:0] state_reg=0;
logic[N-1:0] state_next;

always_ff @(posedge clk)
    state_reg<=state_next;
assign state_next=state_reg+1;
assign m_tick = (state_reg == 19'b0000000000000000000) ? 1'b1: 1'b0;         
endmodule
