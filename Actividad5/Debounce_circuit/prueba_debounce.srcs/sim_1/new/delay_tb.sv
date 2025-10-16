`timescale 1ns / 1ps

module delay_tb;

    reg clk;
    reg reset;
    wire m_tick;
    delay uut (
        .clk(clk),
        .reset(reset),
        .m_tick(m_tick)
    );

    always begin
        #5 clk = ~clk;
    end


    initial begin
        clk = 0;
        reset = 1;
        #20;
        reset = 0;
        #500;

        $finish;
    end

endmodule
