`timescale 1ns / 10ps

module conts
#(parameter N=18)
(
    input [7:0] dig,
    input [3:0] botones,
    input reset,clk,
    output bien, mal,
    output [6:0] sal,
    output [3:0] an
    );
    
    
//para el divisor de frecuencia
logic [N-1:0] state_reg,state_nxt;

//para el antibounce
logic [3:0] salida_antib, delay1,delay2,delay3,delay3neg;

//para la maquina de estados
//contraseña 2012
logic [7:0] code=8'b10000110;
logic biens=0,mals=0;
typedef enum{zero,s1,s2,s3,fb,err1,err2,err3,err4,err} state_type;
state_type state_r, state_n;

//para los displays
 logic [6:0] salida_mux, salida_decoder;
 logic[3:0] salida_anodo;
 logic [15:0] palabra;
 
 
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

//--------------------------------------------------

//Maquina de estados--------------------------------
always_ff @(delay3neg, posedge reset)
    if(reset) begin
        state_r <= zero;
        biens <= 1'b0;
        mals <= 1'b0;
    end else 
        state_r <= state_n;


always_comb begin 
    case (state_r)
 zero:
            if (delay3[0] && (dig[1:0] == code[1:0]))
                state_n = s1;
            else 
                state_n = err1;
        

        s1: 
            if (delay3[1] && (dig[3:2] == code[3:2]))
                state_n = s2;
            else 
                state_n = err2;

        s2: 
            if (delay3[2] && (dig[5:4] == code[5:4]))
                state_n = s3;
            else 
                state_n = err3;

        s3: 
            if (delay3[3] && (dig[7:6] == code[7:6]))
                state_n = fb;
            else 
                state_n = err4;
                
        fb: begin
            biens <= 1'b1;   
            state_n <= zero; 
        end
        
        err1: state_n<=err2;
        err2: state_n<=err3;
        err3: state_n<=err4;
        err4: state_n<=err;
        
        err: begin
            mals <= 1'b1;    
            state_n <= zero; 
        end
        default: state_n <= zero;
    endcase
end

//-------------------------Displays de 7 segmentos-----------------------------------------

//condicionales para palabra
//A->1
//C->2
//P->3
//R->4
//S->5
//E->6
//OFF->0
always_comb
    if(biens)
    //palabra pass
    //[3 1 5 5]
    palabra=16'b0011000101010101;
    else if(mals)
    //Palabra ERR
    //[6 4 4 0]
    palabra=16'b0110011001100000;
    else
    palabra=16'b0000000000000000;
    
//Decodificador 2 to 4
always_comb
    case(state_reg[N-1:N-2])
    2'b00:salida_anodo<=4'b1110;
    2'b01:salida_anodo<=4'b1101;
    2'b10:salida_anodo<=4'b1011;
    2'b11:salida_anodo<=4'b0111;
    endcase

//multiplexor   
always_comb
    case(state_reg[N-1:N-2])
    2'b00:salida_mux<=palabra[3:0];
    2'b01:salida_mux<=palabra[7:4];
    2'b10:salida_mux<=palabra[11:8];
    2'b11:salida_mux<=palabra[15:12];
    endcase
 
//Decodificador displays
always_comb
case(salida_mux)
    4'h0:salida_decoder<=7'b1111111;//NULL
    4'h1:salida_decoder<=7'b0001000;//A
    4'h2:salida_decoder<=7'b0110001;//C
    4'h3:salida_decoder<=7'b0011000;//P
    4'h4:salida_decoder<=7'b0001000;//R
    4'h5:salida_decoder<=7'b0100100;//S
    4'h6:salida_decoder<=7'b0110000;//E
    
    default: salida_decoder<=7'b1111111;//NULL
endcase
//Asignacion final
assign sal=salida_decoder;
assign an=salida_anodo;
assign mal = mals;
assign bien = biens;
endmodule
