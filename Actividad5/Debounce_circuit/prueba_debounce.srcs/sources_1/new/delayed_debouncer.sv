`timescale 1ns / 1ps

module delayed_debouncer
#(parameter N=20)
(
        input logic sw,
        input logic reset,
        input logic clk, // genrally the 100MHz
        output logic db
    );

//señales delay----------------------------------------------------------------------------    
logic[N-1:0] state_r=0;
logic[N-1:0] state_n;

//Delay de 10ms-----------------------------------------------------------------------------
always_ff @(posedge clk)
    state_r<=state_n;
assign state_n=state_r+1;
assign m_tick = (state_r == 19'b0000000000000000000) ? 1'b1: 1'b0;         
    
    
//declaracion de señales
typedef enum {zero, wait1_1, wait1_2, wait1_3, one, wait0_1, wait0_2, wait0_3} state_type;
 state_type state_reg, state_next;
    
// cambio de estados------------------------------------------------------------------------
    always_ff @(posedge clk, posedge reset)
        if(reset)
            state_reg <= zero;
        else
            state_reg <= state_next;
            
    
// maquina de estados------------------------------------------------------------------------
    always_comb
    begin
        db<=1'b0;
        case(state_reg)
            zero:
                    if(sw)
                        state_next = wait1_1;
                    else
                        state_next = zero;
            wait1_1:
                    if(sw)
                        if(m_tick)
                            state_next = wait1_2;
                        else
                            state_next = wait1_1;
                    else
                        state_next = zero;
            wait1_2:
                     if(sw)
                        if(m_tick)
                            state_next = wait1_3;
                        else
                            state_next = wait1_2;
                    else
                        state_next = zero;                   
            wait1_3:
                     if(sw)
                        if(m_tick)
                            state_next = one;
                        else 
                            state_next = wait1_3;
                    else
                        state_next = zero;    
            one:begin
            db<=1'b1;
                    if(~sw)
                        state_next = wait0_1;
                    else
                        state_next = one;
            end
            wait0_1:begin
            db<=1'b1;
                    if(~sw)
                        if(~m_tick)
                            state_next = wait0_1;
                        else
                            state_next = wait0_2;
                    else
                        state_next = one;
            end
            wait0_2:begin
            db<=1'b1;
                     if(~sw)
                        if(~m_tick)
                            state_next = wait0_2;
                        else 
                            state_next = wait0_3;
                    else
                        state_next = one;                   
            end
            wait0_3:begin
            db<=1'b1;
                     if(~sw)
                        if(~m_tick)
                            state_next = wait0_3;
                        else
                            state_next = zero;
                    else
                        state_next = one; 
            end
            default: state_next = zero;
        endcase
    end
endmodule

