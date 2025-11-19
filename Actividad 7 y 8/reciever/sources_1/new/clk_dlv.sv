`timescale 1ns / 1ps

module clk_dlv
#(parameter N=18)
    (
    input reset, clk,
    output logic clk2
    );

logic [N-1:0] state_reg,state_next; 

//clk 190hz
always_ff @(posedge clk, posedge reset)
   if (reset)
   state_reg <= 0;
   else
   state_reg <= state_next;
assign state_next = state_reg + 1;

assign clk2=state_reg[N-1];
endmodule