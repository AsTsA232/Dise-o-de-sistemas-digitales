`timescale 1ns / 10ps

import empak::fp_t;

module sumador_fin (
    input fp_t a, fp_t b,
    output fp_t e
);
    fp_t ngf, npf,  np_a, unm; 
    logic [8:0] sum;  
    
    sotr S1(.a(a), .b(b), .mayor_num(ngf), .menor_num(npf));
    align S2(.alineo(np_a), .nga(ngf), .npa(npf));
    sum_mod S3(.sum(sum), .ng(ngf), .np(np_a));
    norm S4(.co(sum[8]), .unnorm(unm), .norml(e));
    
    assign unm = '{ngf.signo, ngf.expon, sum[7:0]};

endmodule