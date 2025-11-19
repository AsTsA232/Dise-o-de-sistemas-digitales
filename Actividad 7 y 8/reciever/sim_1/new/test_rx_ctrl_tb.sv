`timescale 1ns / 1ps

module test_rx_crtl_tb;

    reg clk;
    reg clr;
    reg rdrf;

    wire rdrf_clr;

    test_rx_crtl uut (
        .clk(clk),
        .clr(clr),
        .rdrf(rdrf),
        .rdrf_clr(rdrf_clr)
    );

    always begin
        #5 clk = ~clk; 
    end

    initial begin

        clk = 0;
        clr = 0;
        rdrf = 0;
        
        #10; 
        
        clr = 1;
        #10;
        clr = 0;
        #10;

        rdrf = 1;
        #10;
        #10;

        rdrf = 0;
        #10;
        #10;
        
        $stop;
    end
endmodule

