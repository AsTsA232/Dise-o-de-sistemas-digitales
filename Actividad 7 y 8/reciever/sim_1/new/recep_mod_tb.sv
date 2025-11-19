`timescale 1ns / 1ps

module recep_mod_tb;

    // Declaración de señales
    reg clk, clr, rxd, rdrf_clr;
    wire rdrf, fe;
    wire [7:0] rx_data;

    // Instanciación del módulo DUT (Device Under Test)
    recep_mod uut (
        .clk(clk),
        .clr(clr),
        .rxd(rxd),
        .rdrf_clr(rdrf_clr),
        .rdrf(rdrf),
        .fe(fe),
        .rx_data(rx_data)
    );

    // Generación del reloj (clk)
    always begin
        #5 clk = ~clk;  // Generar reloj de 100 MHz (5 ns de periodo)
    end

    // Inicialización de señales
    initial begin
        // Inicializamos las señales
        clk = 0;
        clr = 0;
        rxd = 1;  // Asumimos que inicialmente no hay transmisión
        rdrf_clr = 0;

        // Reset del DUT
        clr = 1;
        #10;
        clr = 0;

        #20; 
 
        rxd = 0; // Start bit
        #5700; // esperar un poco antes de cambiar el bit
        rxd = 1; // bit 0
        #5700;
        rxd = 0; // bit 1
        #5700;
        rxd = 1; // bit 2
        #5700;
        rxd = 0; // bit 3
        #5700;
        rxd = 1; // bit 4
        #5700;
        rxd = 0; // bit 5
        #5700;
        rxd = 1; // bit 6
        #5700;
        rxd = 0; // bit 7
        #5700;
        rdrf_clr = 1; // Stop bit

        // Esperamos unos ciclos más para asegurar que la recepción se haya procesado
        
        rxd = 1; 
        #50000;
        // Fin de la simulación
        $stop;
    end


endmodule

