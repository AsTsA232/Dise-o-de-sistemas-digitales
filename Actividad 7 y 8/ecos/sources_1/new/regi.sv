`timescale 1ns / 1ps

module regi(
    input logic clr,clk,
    input logic [7:0] v_in,
    output logic [15:0] v_out
    );

typedef enum {n1,n2,stp} state_t;
state_t state_reg, state_next;

logic [7:0] v_dec,v_uni;
    
always_ff @(posedge clk, posedge clr)
    if (clr) begin
        state_reg<=n1;
        v_out<=16'h0;
    end
    else begin
    state_reg<=state_next;
        if(v_in>=8'h30 & v_in<=8'h39)
            case(state_reg)
            n1: v_dec<=v_in*10;
            n2: v_uni<=v_in;
            stp: v_out<=v_dec+v_uni;  
            endcase
        else
            v_out<=0;
     end     
always_comb
    case(state_reg)
    n1:
        state_next<=n2;
    n2:
        if(v_in==8'h0D)
            state_next<=stp;
        else
            state_next<=n1;
    default: state_next<=n1;
    endcase
endmodule
