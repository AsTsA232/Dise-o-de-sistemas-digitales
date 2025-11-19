`timescale 1ns / 1ps

module test_trans (
    input logic clk,reset,transmit,   
    input  logic [7:0]  data,       
    output logic TxD,tdre        
);


logic [3:0]  bitcounter;       
logic [9:0]  counter;          
logic [9:0]  rightshiftreg;     
logic        shift, load, clear;

typedef enum logic [1:0] {IDLE = 2'b00, SEND = 2'b01, WT=2'b10} state_t;
state_t state_reg, state_next;


always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        state_reg   <= IDLE;
        counter     <= 0;
        bitcounter  <= 0;
        rightshiftreg <= 10'b0;
    end else begin
        counter <= counter + 1;

        if (counter >= 867) begin
            counter <= 0;
            state_reg <= state_next;

            if (load)
                rightshiftreg <= {1'b1, data, 1'b0}; 
            if (clear)
                bitcounter <= 0;
            if (shift) begin
                rightshiftreg <= rightshiftreg >> 1;
                bitcounter <= bitcounter + 1;
            end
        end
    end
end


always_comb begin
    load  = 0;
    shift = 0;
    clear = 0;
    TxD   = 1;     
    state_next = state_reg;

    case (state_reg)
        IDLE: begin
            if (transmit) begin
                state_next = SEND;
                load  = 1;   
            end else begin
                TxD = 1;
            end
        end

        SEND: begin
            if (bitcounter >= 10) begin
                state_next <= IDLE;
                clear <= 1;  
                tdre<=1;
            end else begin
                state_next <= SEND;
                TxD <= rightshiftreg[0]; 
                shift = 1;
            end
        end
        
        WT: state_next<=WT;
    endcase
end

endmodule


