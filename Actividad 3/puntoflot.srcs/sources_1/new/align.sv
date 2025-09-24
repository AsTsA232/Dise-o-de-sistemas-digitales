`timescale 1ns / 1ps

import empak::fp_t;

module align(
    input fp_t nga,
    input fp_t npa,
    output fp_t alineo );
    
    logic [3:0] exp_diff;
    always_comb
    begin
        exp_diff=nga.expon - npa.expon;
        alineo.frac=npa.frac >> exp_diff;
        alineo.expon=nga.expon;
        alineo.signo=npa.signo;        
    end
endmodule