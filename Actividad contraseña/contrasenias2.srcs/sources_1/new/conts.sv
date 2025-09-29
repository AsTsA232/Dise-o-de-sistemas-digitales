`timescale 1ns / 1ps

module conts
#(parameter N=18)
(
    input [7:0] dig,
    input [3:0] botones,
    input reset,clk,
    output bien, mal
    );
//para el divisor de frecuencia
logic [N-1:0] state_reg,state_nxt;

//para el antibounce
logic [3:0] salida_antib, delay1,delay2,delay3,delay3neg;

//para la maquina de estados
//contraseña 2012
logic [7:0] code=8'b10000110;
logic [2:0] state_mc=3'b000;
logic biens=0,mals=0;

//divisor de frecuencia-------------------------
always_ff @(posedge clk, posedge reset)
    if(reset)
    state_reg<=0;
    else
    state_reg<=state_nxt;
    assign state_nxt=state_reg +1;
//----------------------------------------------
  
//antibounce-------------------------------------

//flipoflop1
always_ff @(posedge state_reg[N-1],posedge reset)
    if (reset)
    delay1 <= 0;
    else
    delay1 <= botones;
    
//flipoflop2 
always_ff @(posedge state_reg[N-1],posedge reset)
    if (reset)
    delay2 <= 0;
    else
    delay2 <= delay1;

//flipoflop3    
always_ff @(posedge state_reg[N-1],posedge reset)
    if (reset)
    delay3 <= 0;
    else
    delay3 <= delay2;
 
assign delay3neg = ~delay3;
assign salida_antib=(delay1 & delay2 & delay3);  

//--------------------------------------------------

//Maquina de estados--------------------------------
always_ff @(posedge delay3neg[3])
    case(state_mc)
        3'b000:
            if((code[1:0]==dig[1:0])&&(salida_antib[0]))
            state_mc<=3'b001;
            else
            state_mc<=3'b101;
        3'b001:
            if((code[3:2]==dig[3:2])&&(salida_antib[1]))
            state_mc<=3'b010;
            else
            state_mc<=3'b101; 
        3'b010:
            if((code[5:4]==dig[5:4])&&(salida_antib[2]))
            state_mc<=3'b011;
            else
            state_mc<=3'b101; 
        3'b011:
            if((code[7:6]==dig[7:6])&&(salida_antib[3]))
            state_mc<=3'b100;
            else
            state_mc<=3'b101;        
        3'b100:begin
            biens<=1'b1;
            state_mc<=3'b000;
        end
        3'b101:begin
            mals<=1'b1;
            state_mc<=3'b000;
        end
    endcase
//----------------------------------------------------------

assign bien=biens;
assign mal=mals;
endmodule
