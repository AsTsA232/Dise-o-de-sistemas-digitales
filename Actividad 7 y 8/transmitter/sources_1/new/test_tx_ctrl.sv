`timescale 1ns / 1ps

module test_tx_ctrl(
    input go,clr,tdre,cclk,
    output logic ready
    );
    
typedef enum{wtgo,wtdre,load,wtngo} state_type;
state_type state_reg, state_next;

always_ff @(posedge cclk, posedge clr)
    if(clr)
        state_reg<=wtgo;
    else 
        state_reg<=state_next;
    

always_comb
    case (state_reg)
    wtgo:begin
    ready<=1'b0;
        if(go)
            state_next<=wtdre;
        else
            state_next<=wtgo;
    end
    
    wtdre:
        if(tdre)
            state_next<=load;
        else
            state_next<=wtdre;
     load:begin
        ready<=1'b1;
        state_next<=wtngo;
     end
     
     wtngo:begin
     ready<=1'b0;
        if(go)
            state_next<=wtngo;
        else
            state_next<=wtgo;
      end     
    default: state_next<=wtgo;
    endcase
endmodule
