`timescale 1ns / 1ps

module substractor(
    input logic [7:0] g_vec, l_vec,
    output logic [7:0] out_v
    );
    
always_comb
    out_v<=g_vec-l_vec;
    
endmodule
