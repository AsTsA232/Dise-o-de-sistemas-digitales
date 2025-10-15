`timescale 1ns / 1ps

module hex_7seg
#(parameter N=18)
(
    input [15:0] bit_in,
    input reset,clk,
    output [6:0] seven_seg,
    output [3:0] anodo
    );
    
logic [N-1:0] state_reg,state_next; 
logic [6:0] salida_mux, salida_decoder;
logic[3:0] salida_anodo;
   
//contador para alimentar los displays
   always_ff @(posedge clk, posedge reset)
   if (reset)
   state_reg <= 0;
   else
   state_reg <= state_next;
   assign state_next = state_reg + 1;

//multiplexor   
always_comb
    case(state_reg[N-1:N-2])
    2'b00:salida_mux<=bit_in[3:0];
    2'b01:salida_mux<=bit_in[7:4];
    2'b10:salida_mux<=bit_in[11:8];
    2'b11:salida_mux<=bit_in[15:12];
    endcase
 
//Hexadecimal a display
always_comb
    case(salida_mux)
        //anodo comun 0=encendido
       //A B C D E F G PNT
    4'h0: salida_decoder<=7'b0000001;
    4'h1: salida_decoder<=7'b1001111;
    4'h2: salida_decoder<=7'b0010010;
    4'h3: salida_decoder<=7'b0000110;
    4'h4: salida_decoder<=7'b1001100;
    4'h5: salida_decoder<=7'b0100100;
    4'h6: salida_decoder<=7'b0100000;
    4'h7: salida_decoder<=7'b0001110;
    4'h8: salida_decoder<=7'b0000000;
    4'h9: salida_decoder<=7'b0000100;
    
    4'ha: salida_decoder<=7'b0001000;
    4'hb: salida_decoder<=7'b0000000;
    4'hc: salida_decoder<=7'b0110001;
    4'hd: salida_decoder<=7'b0000001;
    4'he: salida_decoder<=7'b0110000;
    4'hf: salida_decoder<=7'b0111000;
    
    default:salida_decoder<=7'b0000001;
    endcase
    
//Decodificador
always_comb
    case(state_reg[N-1:N-2])
    2'b00:salida_anodo<=4'b1110;
    2'b01:salida_anodo<=4'b1101;
    2'b10:salida_anodo<=4'b1011;
    2'b11:salida_anodo<=4'b0111;
    endcase
        
 //Asignacion de salidas
 assign sal=salida_decoder;
 assign an=salida_anodo;
endmodule
