`timescale 1ns / 1ps

module Tx #(
    parameter integer CLOCK_FREQ = 100_000_000, // Hz
    parameter integer BAUD_RATE  = 115200
) (
    input  logic        clk,
    input  logic        reset,
    input  logic        ready,      // pulse o señal que indica dato disponible (debe ser gestionada por el controlador)
    input  logic [7:0]  tx_data,
    output logic        TxD,        // línea serial (idle = 1)
    output logic        tdre        // 1 = ready / transmit data register empty
);

    // ciclos de reloj por bit (truncado)
    localparam integer CYCLES_PER_BIT = CLOCK_FREQ / BAUD_RATE;
    localparam integer BAUD_MAX = (CYCLES_PER_BIT == 0) ? 0 : (CYCLES_PER_BIT - 1);

    typedef enum logic [1:0] {
        S_MARK,
        S_START,
        S_DATA,
        S_STOP
    } state_t;

    state_t state, next_state;

    logic [7:0] txbuff;
    logic [2:0] bit_count; // 0..7
    localparam integer BAUD_CNT_WIDTH = $clog2(BAUD_MAX + 1 <= 1 ? 2 : (BAUD_MAX + 1));
    logic [BAUD_CNT_WIDTH-1:0] baud_count;

    // FSM register
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= S_MARK;
        else
            state <= next_state;
    end

    // next state logic
    always_comb begin
        next_state = state;
        case (state)
            S_MARK:  if (ready)               next_state = S_START;
            S_START: if (baud_count == BAUD_MAX) next_state = S_DATA;
            S_DATA:  if ((baud_count == BAUD_MAX) && (bit_count == 3'd7)) next_state = S_STOP;
            S_STOP:  if (baud_count == BAUD_MAX) next_state = S_MARK;
            default: next_state = S_MARK;
        endcase
    end

    // sequential: outputs, counters, shift, tdre
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            TxD        <= 1'b1;
            tdre       <= 1'b1;
            baud_count <= '0;
            bit_count  <= 3'd0;
            txbuff     <= 8'd0;
        end else begin
            case (state)
                S_MARK: begin
                    TxD <= 1'b1;
                    baud_count <= '0;
                    bit_count <= 3'd0;
                    // register empty by default in MARK
                    tdre <= 1'b1;
                    if (ready) begin
                        txbuff <= tx_data; // sample dato
                        tdre <= 1'b0;      // ahora ocupado
                    end
                end

                S_START: begin
                    TxD <= 1'b0; // start bit
                    if (baud_count < BAUD_MAX)
                        baud_count <= baud_count + 1;
                    else
                        baud_count <= '0;
                end

                S_DATA: begin
                    TxD <= txbuff[0]; // LSB-first
                    if (baud_count < BAUD_MAX)
                        baud_count <= baud_count + 1;
                    else begin
                        baud_count <= '0;
                        txbuff <= txbuff >> 1; // desplaza siguiente bit a LSB
                        bit_count <= bit_count + 1;
                    end
                end

                S_STOP: begin
                    TxD <= 1'b1; // stop bit / idle
                    if (baud_count < BAUD_MAX)
                        baud_count <= baud_count + 1;
                    else begin
                        baud_count <= '0;
                        tdre <= 1'b1; // transmisión completa -> registro vacío
                    end
                end

                default: begin
                    TxD <= 1'b1;
                    tdre <= 1'b1;
                    baud_count <= '0;
                    bit_count <= 3'd0;
                end
            endcase
        end
    end

endmodule
