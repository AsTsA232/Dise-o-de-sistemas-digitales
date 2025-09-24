
`timescale 1ns / 1ps

import empak::fp_t;

module norm(
    input logic co,
    input fp_t unnorm,
    output fp_t norml  );

    logic [2:0] l_z;
    
    lead U1(.num(unnorm.frac),.l(l_z));

    always_comb
    begin
        if(co) 
            begin
                norml.expon = unnorm.expon + 1;
                norml.frac = {1'b1, unnorm.frac[7:1]};
            end else if(l_z > unnorm.expon)
            begin
                norml.expon = 0; 
                norml.frac = 0;
            end else
            begin
                norml.expon = unnorm.expon - l_z;
                norml.frac = unnorm.frac << l_z; 
            end
        norml.signo = unnorm.signo;
    end
endmodule