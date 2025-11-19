`timescale 1ns / 1ps

module recep_mod(
    input logic clk,clr,rxd,rdrf_clr,
    output logic rdrf, fe,
    output logic [7:0] rx_data
    );
typedef enum{mark,start,delay,shift,stop} state_type;
state_type state_reg, state_next;


logic [11:0] baud_count=12'h000; //3 bits en hexadecimal
logic [3:0] bit_count;
logic [7:0] rxdt=8'h00;

always_ff @(posedge clk, posedge clr)
    if(clr)
        state_next<=mark;
    else begin
        state_reg<=state_next;
        case(state_reg)
            mark:begin
                bit_count<=4'h0;
                rdrf<=1'b0;
                fe<=1'b0;
                //rx_data<=8'h00;
            end
            
            start: baud_count<=baud_count+1;
            
            delay: begin
            baud_count<=baud_count+1;
            
            end
            shift: begin
            baud_count<=12'h000;
            rdrf<=1'b0;
            bit_count<=bit_count+1;
            rxdt[0]<=rxd;
            rxdt[7:1]<=rxdt[6:0];
            end   
            
            stop:begin
                if(rdrf_clr)
                    rdrf<=1'b1;
                else 
                    fe<=1'b1;
            end
        endcase
    end
    
always_comb
    case(state_reg)
        mark:
            if(rxd)
                state_next<=mark;
            else
                state_next<=start;
        start:
            if(baud_count<(12'h11C))
                state_next<=start;
            else if(baud_count>=(12'h11C))
                state_next<=delay;
        delay:
            if(baud_count<(12'h238))
                state_next<=delay;
            else if(baud_count>=(12'h238) & bit_count<(4'h8))
                state_next<=shift;
            else if(baud_count>=(12'h238) & bit_count>=(4'h8))
                state_next<=stop;  
                  
        shift: state_next<=delay;
        
        stop: state_next<=mark;        
        
        default state_next<=mark;
    endcase
    
assign rx_data=rxdt;
endmodule 