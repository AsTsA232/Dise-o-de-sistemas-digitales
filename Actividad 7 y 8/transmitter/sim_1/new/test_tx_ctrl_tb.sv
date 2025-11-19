`timescale 1ns / 1ps

module test_tx_ctrl_tb;

    reg go, clr, tdre, cclk;

    wire ready;
    
    test_tx_ctrl dut (
        .go(go),
        .clr(clr),
        .tdre(tdre),
        .cclk(cclk),
        .ready(ready)
    );
    
    always begin
        #5 cclk = ~cclk;  
    end
    
   
    initial begin
        cclk = 0;
        clr = 0;
        go = 0;
        tdre = 0;
        
       
        clr = 1; 
        #10;
        clr = 0;  

        #20;
        
       
        go = 1;
        #20;
        

        tdre = 1;
        #20;
        

        go = 0;
        #20;
        

        go = 1;
        #20;


        clr = 1;  
        #10;
        clr = 0;
        go = 0;
        tdre = 0;
        #20;
        
        $stop;
    end

    
endmodule

