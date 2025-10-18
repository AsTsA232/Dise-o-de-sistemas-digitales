`timescale 1ns / 1ps

module control_u(
    input logic go,clr,clk, eqflg, ltflg,
    output logic ysel, xsel, xld, yld, gld
    );

//Señales--------------------------------------------------------
typedef enum{start,inp,test_1,test_2,done,y,x} state_type;
state_type state_reg, state_next;

//Reset----------------------------------------------------------
always_ff @(posedge clk, posedge clr)
    if(clr)begin
        state_reg<=start;
        xsel<=1'b0;
        ysel<=1'b0;
        xld<=1'b0;
        yld<=1'b0;
        gld<=1'b0;
    end
    else
        state_reg<=state_next;
        
//Maquina de estados---------------------------------------------      
always_comb
begin
    //state_reg=state_next;
    case(state_reg)
    start:
        if(go)
            state_next<=inp;
        else
            state_next<=start;
    inp:
    begin 
    xsel<=1'b1;
    ysel<=1'b1;
    xld<=1'b1;
    yld<=1'b1;
    gld<=1'b0;
    state_next<=test_1;    
    end
    
    test_1:begin
    xld<=1'b0;
    yld<=1'b0;    
        if(eqflg)
            state_next<=done;
         else 
            state_next<=test_2;
     end
     test_2:begin
        if(ltflg) //(x<y)
            state_next<=y;
         else
            state_next<=x;  
     end 
     y:
     begin
        yld<=1'b1;
        ysel<=1'b0;
        
        state_next<=test_1; 
     end
     
     x:
     begin
        xld<=1'b1;
        xsel<=1'b0;
        state_next<=test_1; 
     end
     done:begin
      gld<=1'b1;
      state_next<=done;
      end
    default: state_next<=start;
    endcase
end
endmodule