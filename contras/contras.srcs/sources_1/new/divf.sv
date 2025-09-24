`timescale 1ns / 10ps

module divf
#(parameter bt=19)
(
    input reset, clk,
    output q
    );
    
    logic [bt-1:0]state_reg;
    
    always_ff @(posedge clk, posedge reset)
    begin
    if(reset)
        state_reg<=0;
     else
        state_reg<=state_reg+1'b1;    
    end
    assign q=state_reg[bt-1];
endmodule
