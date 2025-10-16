`timescale 1ns / 1ps

module top_tb;

reg btn;
reg clk;
reg reset;
wire [6:0] seven_seg;
wire [3:0] anodo;

top dut (
    .btn(btn),
    .clk(clk),
    .reset(reset),
    .seven_seg(seven_seg),
    .anodo(anodo)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;  
end

initial begin
    reset = 1;
    #50 reset = 0;  
end

initial begin
    btn = 0;  
    #100;     

    #30000000 btn = 1;  
    #30000000 btn = 0;  

    #30000000 btn = 1;  
    #30000000 btn = 0; 

    #30000000 btn = 1;  
    #30000000 btn = 0; 

   #35000000 btn = 1;  
   #30000000 btn = 0;  

    #300 btn = 1;  
    #300 btn = 0; 

    #100000000 $stop;  
end

endmodule

