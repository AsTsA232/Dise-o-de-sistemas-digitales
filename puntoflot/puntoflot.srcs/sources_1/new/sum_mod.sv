`timescale 1ns / 1ps

import empak::fp_t;

module sum_mod (
    input fp_t ng,
    input fp_t np,
    output logic [8:0] sum);
    
    assign sum = (ng.signo == np.signo) ?
     {1'b0, ng.frac} + {1'b0, np.frac}
     : {1'b0, ng.frac} - {1'b0, np.frac};
    
endmodule
