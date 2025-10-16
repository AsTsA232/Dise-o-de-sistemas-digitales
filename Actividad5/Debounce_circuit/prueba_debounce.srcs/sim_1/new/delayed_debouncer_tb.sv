`timescale 1ns / 1ps
module delayed_debouncer_tb;

    reg clk;
    reg reset;
    reg sw;
    wire db;
 
    delayed_debouncer uut (
        .clk(clk),
        .reset(reset),
        .sw(sw),
        .db(db)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        reset = 1;
        sw = 0;

        #100;
        reset = 0;

        repeat (5) begin
            sw = 1; #500; 
            sw = 0; #500;
        end

        
        sw = 1;
        #30000000; 
        sw = 0;
        #30000000;

        sw = 1;
        #30000000;
        sw = 0;
       #30000000;
        
        sw = 1;
        #30000000;
        sw = 0;
        #30000000;

        $stop;
    end

endmodule
