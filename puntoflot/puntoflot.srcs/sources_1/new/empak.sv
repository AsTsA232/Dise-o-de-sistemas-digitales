`timescale 1ns / 1ps
package empak;

typedef struct packed {
    logic signo;
    logic [3:0] expon;
    logic [7:0] frac;
} fp_t;

endpackage: empak
