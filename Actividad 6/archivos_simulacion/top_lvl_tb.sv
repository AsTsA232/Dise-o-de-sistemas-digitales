`timescale 1ns / 1ps

module top_lvl_tb;
    reg go,clk,clr;
    reg [7:0] xin, yin;
    wire [7:0] gdc;
    
top_lvl u1(.go(go),.clk(clk),.clr(clr),.xin(xin),.yin(yin),.gdc(gdc));

always #5 clk = ~clk;

initial begin
        clk <= 0;
        clr <= 0;
        go <= 0;
        xin <= 8'b00000000;
        yin <= 8'b00000000;

    #20 clr<=1'b1;
    #20 clr<=1'b0;
//x>y--------------------------------------
    xin<=8'b11100100; //228
    yin<=8'b00110100; //52
    #20 go<=1'b1;
    //R=4
    #550;
    
    #20 clr<=1'b1;
    #20 clr<=1'b0;
//x=y--------------------------------------    
    xin<=8'b00110100; //52
    yin<=8'b00110100; //52
    #20 go<=1'b1;
    //R=52
    #250;
     
    #20 clr<=1'b1;
    #20 clr<=1'b0; 
//x<y--------------------------------------
    xin<=8'b00101101; //45
    yin<=8'b10001011; //139
    #20 go<=1'b1;
    //1
    #550;
end

endmodule
