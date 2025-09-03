`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SISTEMAS DIGITALES FESC
// Engineer: MARÍA TERESA HURTADO GALLARDO
// Create Date: 02.09.2025 20:03:30
// Design Name: ALU
// Module Name: alu
// Project Name: ACTIVIDAD 2
// Target Devices: BASYS3 
//////////////////////////////////////////////////////////////////////////////////

module alu(
//2 BUSES DE ENTRADA
    input [3:0] a,
    input [3:0] b,
    
//BUS DE OPERADOR 
    input [2:0] op,
    
//BUS DE SALIDA
    output [4:0] out,
    
//BANDERAS DE LA ALU
    output n,
    output z,
    output o,
    output c
    );
    
    logic [4:0] outs;
    logic zs, ns, os; 
    
    always_comb
    begin
        ns = 1'b0;
        zs = 1'b0;
        os = 1'b0;
        
//FUNCIONES PRINCIPALES DE LA ALU
        case(op)
            3'b000: outs = {0,a};                      
            3'b001: outs = a+b; 
            
// A-B                            
            3'b010: begin                          
                if (a>b) begin
                    ns = 1'b0;
                    outs = a-b;
                end else begin
                    ns = 1'b1;
                    outs = b-a;
                end
            end
// B-A
            3'b011: begin                          
                if (b>=a) 
                    begin
                        ns = 1'b0;
                        outs = b-a;
                    end 
                else 
                    begin
                        ns = 1'b1;
                        outs = a-b;
                    end
            end
            
            3'b100: outs = {0,~a};                    
            3'b101: outs = a & b;                 
            3'b110: outs = a | b;                 
            3'b111: outs = (~a&b)|(~b&a);   
            default: outs = 5'b00000;             
        endcase
        
// BANDERAS
        if (outs == 5'b00000) zs = 1'b1;
        os = outs[4];

    end
    
    assign out = outs;
    assign c = os;
    assign o = os;
    assign z = zs;
    assign n = ns;
endmodule


