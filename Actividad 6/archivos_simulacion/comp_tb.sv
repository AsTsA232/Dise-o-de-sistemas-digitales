`timescale 1ns / 1ps

module comp_tb;

    logic [7:0] x, y;
    logic eqlflg, ltflg;

    compare uut (
        .x(x),
        .y(y),
        .eqlflg(eqlflg),
        .ltflg(ltflg)
    );

    initial begin
        x = 8'b00000001; 
        y = 8'b00000010; 
        #10; 

        x = 8'b00000011; 
        y = 8'b00000011; 
        #10;

        x = 8'b00000100; 
        y = 8'b00000011; 
        #10; 
        
        $stop;
    end

endmodule

