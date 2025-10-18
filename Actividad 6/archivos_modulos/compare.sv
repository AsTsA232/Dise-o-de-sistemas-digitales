`timescale 1ns / 1ps

module compare(
    input logic [7:0]x,y,
    output logic eqlflg,ltflg
    );
    
always_comb 
begin
    eqlflg<=1'b0;
    ltflg<=1'b0;
        if(x<y)
            ltflg<=1'b1;
        else if (x==y)
            eqlflg<=1'b1;           
end    
endmodule
