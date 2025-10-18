`timescale 1ns / 1ps

module mux(
    input logic [7:0] vec0,vec1,
    input logic sel,
    output logic [7:0] v_out
    );
    
always_comb
    if(sel)
        v_out<=vec1;
    else
        v_out<=vec0;
        
endmodule
