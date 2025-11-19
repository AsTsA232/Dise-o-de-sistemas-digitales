`timescale 1ns / 1ps

module testhola(
    input clk,reset,go,
    output TxD
    );
    
typedef enum logic [1:0] {s0 = 2'b00, s1 = 2'b01, s2=2'b10, s3=2'b11} state_t;
state_t state_reg, state_next;
logic transmit;
logic [7:0] letra; 
//test_trans a3 (.clk(clk), .reset(reset),.transmit(transmit),.TxD(TxD),.data(letra));
always_ff@(posedge clk, posedge reset)
    if(reset) begin
        state_reg<=s0;
        transmit<=1'b0;
    end
    else begin
        state_reg<=state_next;
        case(state_reg)
        s1:begin
        transmit<=1'b1; 
        letra<=8'b01001111;
        end
        s2: begin
        transmit<=1'b1;
        letra<=8'b01101100;
        end
        s3: begin
        transmit<=1'b1;
        letra<=8'b01100001;
        end
        endcase
    end
always_comb
    case(state_reg)
    s0:
        if(go)
            state_next<=s1;
        else
            state_next<=s0;
    s1: state_next<=s2;
    s2: state_next<=s3;
    s3: state_next<=s0;    
    default: state_next<=s0;
    endcase
 
test_trans a3 (.clk(clk), .reset(reset),.transmit(transmit),.TxD(TxD),.data(letra));
endmodule
