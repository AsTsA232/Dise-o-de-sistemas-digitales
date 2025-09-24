`timescale 1ns / 1ps

module verifi_tb;

   logic[7:0] cod;                
   logic d1, d2, d3, d4,reset,clk;     
   logic bien, mal;        
   localparam T=20;

    verifi uut (
        .cod(cod), 
        .reset(reset), 
        .clk(clk), 
        .d1(d1), 
        .d2(d2), 
        .d3(d3), 
        .d4(d4), 
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
        d1 = 1'b0;
        d2 = 1'b0;
        d3 = 1'b0;
        d4 = 1'b0;
         cod=8'b10010100;
        
        //  reset
        reset = 1'b1;;
        #10 reset = 1'b0;
        
        #10 d1 = 1'b1;  
        #10 d1 = 1'b0;  
  
        #10 d2 = 1'b1;  
        #10 d2 = 1'b0;  
        
        #10 d3 = 1'b1;  
        #10 d3 = 1'b0; 
        
         #10 d4 = 1'b1; 
         #10 d4 = 1'b0; 

        #20;

        $stop;
    end


endmodule
