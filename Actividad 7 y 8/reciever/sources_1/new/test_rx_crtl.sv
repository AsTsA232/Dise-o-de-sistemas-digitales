`timescale 1ns / 1ps

module test_rx_crtl(
    input clk,clr,rdrf,
    output logic rdrf_clr
    );

typedef enum{wtrdfr, load} state_type;
state_type state_reg, state_next;

always_ff @(posedge clk, posedge clr)
    if(clr)
        state_reg<=wtrdfr;
    else
        state_reg<=state_next;

always_comb
    case(state_reg)
    wtrdfr:begin
        rdrf_clr<=1'b0;
        if(rdrf)
            state_next<=load;
        else    
            state_next<=wtrdfr;
    end
    load:begin
        rdrf_clr<=1'b1;
        state_next<=wtrdfr;
    end
    default: state_next<=wtrdfr;
    endcase
endmodule
