`timescale 1ns / 1ps

import empak::fp_t;

module sotr(
    input fp_t a, fp_t b,
    output fp_t mayor_num, fp_t menor_num
    );

    assign mayor_num = ({a.expon, a.frac} >= {b.expon, b.frac})? a: b;
    assign menor_num = ({a.expon, a.frac} < {b.expon, b.frac})? a: b;
endmodule