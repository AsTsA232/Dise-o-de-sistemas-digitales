`timescale 1ns / 1ps

module seg_tb;

parameter N = 18; 

reg [7:0] gdc;
reg reset;
reg clk;
wire [6:0] sal;
wire [3:0] an;

seg #(.N(N)) uut (
    .gdc(gdc),
    .reset(reset),
    .clk(clk),
    .sal(sal),
    .an(an)
);

always begin
    #5 clk = ~clk;  
end

initial begin

    clk = 0;
    reset = 0;
    gdc = 8'b00000000;  

    reset = 1;
    #10 reset = 0;

    gdc = 8'b11110000;  //240 F0
    
    #500000000;  
 

    $stop;
end

endmodule

