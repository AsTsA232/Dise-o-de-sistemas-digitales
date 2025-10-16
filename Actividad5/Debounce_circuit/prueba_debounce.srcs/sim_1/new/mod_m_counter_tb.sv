`timescale 1ns / 1ps

module mod_m_counter_tb;

 // Parámetros
    parameter M = 10;  // Definimos el valor de M como 10 para la prueba
    
    // Señales
    reg clk;                  // Entrada del reloj
    reg reset;                // Entrada de reset
    wire [3:0] q;             // Salida q (suponiendo que M = 10, N = 4 bits)
    wire max_tick;            // Salida max_tick

    // Instanciación del contador mod_m_counter
    mod_m_counter #(.M(M)) uut (
        .clk(clk),
        .reset(reset),
        .q(q),
        .max_tick(max_tick)
    );

    // Generación del reloj (frecuencia de 100 MHz)
    always begin
        #5 clk = ~clk;  // Periodo de 10ns -> frecuencia de 100 MHz
    end

    // Secuencia de estímulos
    initial begin
        // Inicialización de las señales
        clk = 0;
        reset = 0;
        
        // Aplicar reset inicial
        $display("Aplicando reset...");
        reset = 1;  // Activar reset
        #10 reset = 0;  // Desactivar reset después de 10 ns

        // Observamos la salida después del reset
        #20;

        // Simular el conteo
        $display("Contando...");
        #50;  // Esperar 50 ns (5 ciclos de reloj)
        $display("q = %d, max_tick = %b", q, max_tick);
        
        // Continuar la simulación durante varios ciclos para ver el comportamiento
        #100;
        $display("q = %d, max_tick = %b", q, max_tick);
        
        // Verificar si el contador se reinicia correctamente después de llegar a M-1
        #100;
        $display("q = %d, max_tick = %b", q, max_tick);
        
        // Finalizar simulación
        $finish;
    end

    // Monitor para ver las señales relevantes
    initial begin
        $monitor("Tiempo: %t | q: %d | max_tick: %b", $time, q, max_tick);
    end

endmodule
