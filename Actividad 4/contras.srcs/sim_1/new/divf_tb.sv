`timescale 1ns / 1ps

module divf_tb;

    localparam T=10; //clock period
    logic reset,clk;
    logic q;
    //instantiation
    divf #(.bt(19)) uut(.reset(reset), .clk(clk), .q(q));
    //clock
    always
    begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end
    //reset for fisrt half cycle
    initial
    begin
        reset = 1'b1;
        #(T/2);
        reset = 1'b0; 
    end
    //stimulus
    initial
    begin
    #20000000;
     $stop;   
    end
    
endmodule
