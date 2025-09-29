`timescale 1ns / 1ps

module contador_tb;

    logic reset;
    logic clk;
    logic [6:0] sal;  
    logic [3:0] an; 
    
    contador_hexa uut (
        .reset(reset),
        .clk(clk),
        .sal(sal),
        .an(an)
    );

    always begin
        clk = 0; 
        #10; 
        clk = 1; 
        #10;  
    end

    initial begin
        reset = 1;  
        #10;
        reset = 0;  
        #100000;       

        $stop;
    end


endmodule
