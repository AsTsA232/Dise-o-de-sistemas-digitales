`timescale 1ns / 1ps

module filpflopd(
    input clk, d,reset,
    output q
    );
 logic qs;
   always_ff @(posedge clk,posedge reset)
   if (reset)
   qs <= 1'b0;
   else
   qs <= d;

assign q=qs;
endmodule
