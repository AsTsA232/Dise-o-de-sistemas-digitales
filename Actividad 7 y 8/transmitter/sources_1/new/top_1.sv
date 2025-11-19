`timescale 1ns / 1ps

module top_1(
    input  logic        clk,
    input  logic        reset,     // activo bajo
    input  logic [7:0]  tx_data,          // switches: sw[7:0]
    input  logic        ready,    // botón físico (activo bajo o alto según tu hw)
    output logic        uart_tx_pin  // pin físico conectado al conversor USB-UART (FPGA Tx)
    );
    
    logic tx_tdre;
     Tx Tx (
        .clk(clk),
        .reset(reset),     // tu Tx original usa reset activo alto
        .ready(ready),    // pulso aceptado por estar tdre==1 y presionar botón
        .tx_data(tx_data),
        .TxD(uart_tx_pin),
        .tdre(tx_tdre)
    );
endmodule
