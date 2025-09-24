`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SISTEMAS DIGITALES FESC
// Engineer: MARÍA TERESA HURTADO GALLARDO
// Create Date: 02.09.2025 20:03:30
// Design Name: ALU
// Module Name: alu_TB
// Project Name: ACTIVIDAD 2
// Target Devices: BASYS3 
//////////////////////////////////////////////////////////////////////////////////

module alu_TB;
logic [3:0] vect_a, vect_b;
logic [2:0] vect_op;
logic [4:0] vect_sali;
logic sim_z,sim_n,sim_o,sim_c;

alu test(.a(vect_a),.b(vect_b),.op(vect_op),
.z(sim_z),.n(sim_n),.o(sim_o),.c(sim_c),
.out(vect_sali));

initial
begin

//SALIDA = A

    vect_a=4'b1001;
    vect_b=4'b1011;
    vect_op=3'b000;
    #10;

//SALIDA =A+B

    vect_a=4'b1001;
    vect_b=4'b1011;
    vect_op=3'b001;
    #10;

//SALIDA = B-A

    vect_a=4'b1001;
    vect_b=4'b1011;
    vect_op=3'b011;
    #10;
    
//SALIDA = NOT A

    vect_a=4'b1001;
    vect_b=4'b1011;
    vect_op=3'b100;
    #10;
    
 //SALIDA = A AND B

    vect_a=4'b1001;
    vect_b=4'b1011;
    vect_op=3'b101;
    #10;
    
 //SALIDA = A OR B

    vect_a=4'b1001;
    vect_b=4'b1011;
    vect_op=3'b110;
    #10;
    
 //SALIDA = A XOR B

    vect_a=4'b1001;
    vect_b=4'b1011;
    vect_op=3'b111;
    #10;
    
 
    $stop;
end
endmodule
