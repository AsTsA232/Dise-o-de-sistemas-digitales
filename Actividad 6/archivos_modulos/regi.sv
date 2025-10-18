`timescale 1ns / 1ps

module regi(
    input logic clr,clk,ld,
    input logic [7:0] v_in,
    output logic [7:0] v_out
    );
    
always_ff @(posedge clk, posedge clr)
    if (clr)
        v_out<=8'b00000000;
    else if (ld)
        v_out<=v_in;
endmodule
