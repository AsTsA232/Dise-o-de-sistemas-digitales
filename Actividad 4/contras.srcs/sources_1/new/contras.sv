`timescale 1ns / 1ps

module contras(
    input [7:0] sw,
    input clk,
    input reset,
    input btn0,
    input btn1,
    input btn2,
    input btn3,
    output bien,
    output mal
    );
    
    logic clkrebajado, antibounce;
    logic i1,i2,i3,i4;
    
    divf u1(.reset(reset),.clk(clk),.q(clkrebajado));
    antiboun u2(.i1(btn0),.i2(btn1),.i3(btn2),.i4(btn3), .reset(reset), .clk(clk), .btn1(i1),.btn2(i2),.btn3(i3),.btn4(i4),.qn(antibounce));
    verifi u3(.cod(sw),.reset(reset), .clk(antibounce), .d1(i1), .d2(i2), .d3(i3), .d4(i4),.bien(bien), .mal(mal));
    
endmodule
