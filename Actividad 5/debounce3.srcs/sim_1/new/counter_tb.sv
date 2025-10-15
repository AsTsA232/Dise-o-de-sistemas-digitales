`timescale 1ns / 1ps

module counter_tb;

  // Parámetros
  localparam N = 7;  // Tamaño del contador (puedes ajustarlo si es necesario)

  // Entradas
  reg clk;
  reg reset;
  reg tick;

  // Salidas
  wire [N-1:0] q;

  // Instanciamos el módulo counter
  counter #(.N(N)) uut (
      .clk(clk),
      .reset(reset),
      .tick(tick),
      .q(q)
  );

  // Generación de señal de reloj
  always begin
    #5 clk = ~clk;  // Reloj de 10ns (período 10ns, frecuencia 100MHz)
  end


  initial begin

    clk = 0;
    reset = 0;
    tick = 0;


    reset = 1;
    #10 reset = 0;


    #10 tick = 1; 
    #10 tick = 0;  
    #10 tick = 1;
    #10 tick = 0;
    
   
    #10 tick = 1;
    #10 tick = 0;
    #10 tick = 1;
    #10 tick = 0;


    #20 $finish;  
  end

endmodule
