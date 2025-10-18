`timescale 1ns / 1ps

module control_u_tb;

    logic go, clr, clk, eqflg, ltflg;
    logic ysel, xsel, xld, yld, gld;
    
    control_u uut (
        .go(go),
        .clr(clr),
        .clk(clk),
        .eqflg(eqflg),
        .ltflg(ltflg),
        .ysel(ysel),
        .xsel(xsel),
        .xld(xld),
        .yld(yld),
        .gld(gld)
    );
    
    always #5 clk = ~clk;  
    
    initial begin
        clk = 0;
        clr = 0;
        go = 0;
        eqflg = 0;
        ltflg = 0;

        clr = 1; 
        #20;
        clr = 0; 

        go = 1;  
        #20;     
        go = 0;
//valores iguales----------------
        eqflg = 1;  
        #20; 
        eqflg = 0;
//reinicio-----------------------
        clr = 1; 
        #20;
        clr = 0; 
        go = 1;  
        #20;     
        go = 0;  
//x<y------------------------------            
        ltflg = 1;  
        #20;        
        ltflg = 0;  
        #40;        
     
        $stop;
    end

endmodule

