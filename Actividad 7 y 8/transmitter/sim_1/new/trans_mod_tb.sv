`timescale 1ns / 1ps

module trans_mod_tb;

// Inputs
logic clk;
logic clr;
logic ready;
logic [7:0] tx_data;

// Outputs
logic txd;
logic tdre;

// Instanciar el módulo a probar (UUT)
trans_mod uut (
    .clk(clk),
    .clr(clr),
    .ready(ready),
    .tx_data(tx_data),
    .txd(txd),
    .tdre(tdre)
);

// Generador de reloj
always begin
    #5 clk = ~clk; // Periodo de 10ns para el reloj
end

// Inicialización y estímulos
initial begin
    // Inicialización de señales
    clk = 0;
    clr = 0;
    ready = 0;
    tx_data = 8'b10101010;  // Data arbitraria para transmitir
    

    clr = 1;
    #10 clr = 0; // Aplicar reset y esperar 10 ns
    
    // Estímulos
    // Prueba 1: Enviar datos cuando 'ready' es 1
    ready = 1;
    #10; // Espera
    ready = 0;
   
    #100000;
    
    
    tx_data = 8'b11001100;  // Data arbitraria para transmitir
    

    clr = 1;
    #10 clr = 0; // Aplicar reset y esperar 10 ns
    
    // Estímulos
    // Prueba 1: Enviar datos cuando 'ready' es 1
    ready = 1;
    #10; // Espera
    ready = 0;
   
    #100000;
    $stop;
end

endmodule
