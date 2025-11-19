`timescale 1ns / 1ps
//Modulo de transmiscion uart rs232
module tx_mod(
    input logic clk,clr, ready,
    input logic [7:0] tx_data,
    output logic txd,tdre
    );
//FSM STATES---------------------------------------------------  
typedef enum{mark,start,delay,shift,stop} state_type;
state_type state_reg, state_next;

//COUNTER------------------------------------------------------
logic [11:0] baud_count=12'h000; //3 bits en hexadecimal
logic [3:0] bit_count;
logic [7:0] tx_buf;
//assign tx_buf=tx_data;
//RST LOGIC----------------------------------------------------
always_ff @(posedge clk, posedge clr)
    if(clr)
        state_next<=mark;
    else
    begin
        state_reg<=state_next;
        case(state_reg)
            mark:begin
                bit_count<=4'b0000;
                tdre<=1'b1;
                tx_buf<=8'b00000000;
                txd<=1'b1;
            end
            
            start: begin
                baud_count<=3'h000;
                txd<=1'b0;
                tdre<=1'b0; 
                tx_buf<=tx_data;
            end
            
            delay: baud_count<=baud_count+1;        
               
            shift: begin
                tdre<=1'b0;
                txd<=tx_buf[0];
                tx_buf[6:0]<=tx_buf[7:1];
                bit_count<=bit_count+1;
                baud_count<=12'h000;
            end
            
            stop:begin
            txd<=1'b1;
            tdre<=1'b0;
            end
        endcase
    end
        
//COMBINATIONAL LOGIC------------------------------------------
always_comb
    case(state_reg)
    mark:
        if(ready)
            state_next<=start;
        else
            state_next<=mark;
    start: state_next<=delay;
    delay:
        if(baud_count<(12'h238))
            state_next<=delay;
        else if ((baud_count >=(12'h238))&(bit_count<(4'h8)))
            state_next<=shift;
        else if ((baud_count >=(12'h238))&(bit_count>=(4'h8)))
            state_next<=stop;
                   
    shift: state_next<=delay;
    stop: 
        if(baud_count<(12'h238))
            state_next<=stop;
        else
            state_next<=mark;
    default: state_next<=mark;
    endcase
endmodule