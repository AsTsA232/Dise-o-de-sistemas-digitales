`timescale 1ns / 1ps

module debouncing_tb;

    // Registros para las señales de entrada
    reg clk;
    reg reset;
    reg sw_inp;

    // Señales para las salidas
    wire debounced_out;

    // Instanciación del módulo debouncing
    debouncing uut (
        .clk(clk),
        .reset(reset),
        .sw_inp(sw_inp),
        .debounced_out(debounced_out)
    );

    // Generación del reloj (100 MHz, periodo de 10ns)
    initial begin
        clk = 0;  // Inicializa el reloj en 0
        forever #5 clk = ~clk;  // Cambia el valor de clk cada 5 ns
    end

    // Inicialización y secuencia de pruebas
    initial begin
        // Inicializar las señales
        reset = 1'b1;
        sw_inp = 1'b0;

        // Aplicar el reset
        #10 reset = 1'b0;
        
        // Prueba 1: Simular un cambio de estado de sw_inp a '1'
        #10 sw_inp = 1'b1;
        #10 sw_inp = 1'b0;
        
        // Prueba 2: Probar con una pulsación prolongada
        #10 sw_inp = 1'b1;
        #50ms sw_inp = 1'b0;

        // Prueba 3: Verificar el comportamiento cuando el switch es presionado nuevamente
        #10 sw_inp = 1'b1;
        //#5 sw_inp = 1'b0;

        // Fin de la simulación después de algunas pruebas
        #100 $finish;
    end

endmodule

