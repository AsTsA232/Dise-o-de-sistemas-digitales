`timescale 1ns / 1ps

module receiver_svl(
    input  logic        clk_fpga,   
    input  logic        reset,     
    input  logic        RxD,       
    output logic [7:0]  RxData,    
    output logic        data_ready  
);

    parameter int clk_freq    = 100_000_000;
    parameter int baud_rate   = 115200;
    parameter int div_sample  = 4;
    parameter int div_counter = clk_freq / (baud_rate * div_sample);
    parameter int mid_sample  = div_sample / 2;
    parameter int div_bit     = 10; 

    typedef enum logic {IDLE=0, RECEIVING=1} state_t;

    state_t          state, nextstate;
    logic [3:0]      bit_counter;
    logic [1:0]      sample_counter;
    logic [13:0]     baudrate_counter;
    logic [9:0]      rxshift_reg;
    logic [7:0]      data_buffer[0:255];
    logic [7:0]      data_index;        

    logic shift;
    logic clear_bitcounter, inc_bitcounter;
    logic clear_samplecounter, inc_samplecounter;

    assign RxData = rxshift_reg[8:1];
    assign data_ready = (rxshift_reg[8:1] == 8'h0D);  

    always_ff @(posedge clk_fpga or posedge reset) begin
        if (reset) begin
            state           <= IDLE;
            bit_counter     <= 0;
            sample_counter  <= 0;
            baudrate_counter<= 0;
            data_index      <= 0;
        end else begin

            baudrate_counter <= baudrate_counter + 1;

            if (baudrate_counter >= div_counter - 1) begin
                baudrate_counter <= 0;
                state            <= nextstate;


                if (shift)
                    rxshift_reg <= {RxD, rxshift_reg[9:1]};

                if (clear_samplecounter)
                    sample_counter <= 0;
                else if (inc_samplecounter)
                    sample_counter <= sample_counter + 1;

                if (clear_bitcounter)
                    bit_counter <= 0;
                else if (inc_bitcounter)
                    bit_counter <= bit_counter + 1;
            end
        end
    end


    always_comb begin
        shift <= 0;
        clear_samplecounter<= 0;
        inc_samplecounter<= 0;
        clear_bitcounter<= 0;
        inc_bitcounter<= 0;
        nextstate<= IDLE;

        case (state)
            IDLE: begin
                if (~RxD) begin 
                    nextstate <= RECEIVING;
                    clear_bitcounter <= 1;
                    clear_samplecounter <= 1;
                end else begin
                    nextstate <= IDLE;
                end
            end

            RECEIVING: begin
                nextstate <= RECEIVING;

                if (sample_counter == mid_sample - 1)
                    shift <= 1;

                if (sample_counter == div_sample - 1) begin
                    if (bit_counter == div_bit - 1) begin
                        
                        data_buffer[data_index] <= rxshift_reg[8:1];
                        data_index = data_index + 1;
                        if (rxshift_reg[8:1] == 8'h0D) 
                            nextstate = IDLE; 
                    end
                    inc_bitcounter<=1;
                    clear_samplecounter<=1;
                end else begin
                    inc_samplecounter<=1;
                end
            end

            default: nextstate<=IDLE;
        endcase
    end

endmodule
