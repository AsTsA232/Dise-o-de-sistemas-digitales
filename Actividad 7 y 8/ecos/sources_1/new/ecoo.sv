`timescale 1ns / 1ps

module ecoo(
    input  logic        clk,          // Reloj del FPGA
    input  logic        reset,        // Señal de reset
    input  logic        RxD,          // Señal de entrada RxD
    output logic        TxD,        
    output logic [15:0] out
);

typedef enum {idle,imp1,wt, imp2, stp} state_t;
state_t state_reg, state_next;

    // Señales internas
    logic [7:0] RxData;      // Datos recibidos del módulo rx
    logic data_ready_rx;     // Señal de datos listos desde rx
    logic transmit_tx;       // Señal de transmisión para tx
    logic [15:0] num_c;
    logic [7:0] med_num;
    // Instancia del módulo RX (receptor)
    rx #(
        .clk_freq(100_000_000),
        .baud_rate(115200),
        .div_sample(4)
    ) rx_inst (
        .clk_fpga(clk),
        .reset(reset),
        .RxD(RxD),
        .RxData(RxData),
        .data_ready(data_ready_rx)
    );

    tx tx_inst (
        .clk(clk),
        .reset(reset),
        .transmit(transmit_tx),
        .data(med_num),
        .TxD(TxD)
    );

    regi regt(.clr(reset),.clk(clk),.v_in(RxData),.v_out(num_c));
    
always_ff @(posedge clk, posedge reset)
    if(reset) begin
        state_reg<=idle;
        transmit_tx<=0;
    end
    else 
        state_reg<=state_reg;
    
    
always_comb
    case(state_reg)
    idle: 
        if(RxData==8'h0D)
            state_next<=imp1;
        else   
            state_next<=idle;
    imp1: begin
        med_num<=num_c[15:8];
        transmit_tx<=1'b1;
        state_next<=wt;
    end
    wt: begin
       transmit_tx<=1'b0;
        state_next<=imp2; 
    end
    imp2: begin
        med_num<=num_c[7:0];
        transmit_tx<=1'b1;
        state_next<=stp;
    end
    
    stp:begin
       transmit_tx<=1'b0;
    end
    
    default: state_next<=idle;
    endcase
assign out=num_c;
endmodule

