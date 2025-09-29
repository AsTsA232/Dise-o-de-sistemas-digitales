`timescale 1ns / 1ps

module cont_tb;
    logic[7:0] dig;        
    logic[3:0] botones;         
    logic reset,clk;     
    logic bien, mal;        
    localparam T=20;

    conts uut (
        .dig(dig), 
        .reset(reset), 
        .clk(clk), 
        .botones(botones), 
        .bien(bien), 
        .mal(mal)
    );

    always 
    begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end

    initial 
    begin
        botones[0] = 1'b0;
        botones[1] = 1'b0;
        botones[2] = 1'b0;
        botones[3] = 1'b0;
         dig=8'b10000110;
        
        //  reset
        reset = 1'b1;;
        #1000 reset = 1'b0;
        
        #1000 botones[0] = 1'b1;
        #1000 botones[0] = 1'b0;
        #1000 botones[1] = 1'b1;
        #1000 botones[1] = 1'b0;
        #1000 botones[2] = 1'b1;
        #1000 botones[2] = 1'b0;
        #1000 botones[3] = 1'b1;
        #1000 botones[3] = 1'b0;
        
         $stop; 
     end
   
endmodule
