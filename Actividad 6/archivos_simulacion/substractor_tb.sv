`timescale 1ns / 1ps

module substractor_tb;

    // Entradas
    logic [7:0] g_vec;
    logic [7:0] l_vec;

    // Salidas
    logic [7:0] out_v;

    // Instancia del DUT (Device Under Test)
    substractor uut (
        .g_vec(g_vec),
        .l_vec(l_vec),
        .out_v(out_v)
    );

    initial begin

        g_vec = 8'd10;
        l_vec = 8'd5;
        #10;
        
        g_vec = 8'd25;
        l_vec = 8'd7;
        #10;

    end
endmodule
