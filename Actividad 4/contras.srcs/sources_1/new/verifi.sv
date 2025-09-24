`timescale 1ns / 1ps

module verifi(
    input [7:0] cod,
    input reset, clk, d1, d2, d3, d4,
    output bien, mal
);


logic [3:0] state=3'b000;  
logic biens=1'b0, mals=1'b0, error=3'b000;

// Código 
logic [7:0] btn = 8'b10010100;


always_ff @(posedge clk, posedge reset)
begin
    if (reset)
    begin
        state <= 3'b000; 
        error <= 3'b000;
    end 
        
    else
    begin
        case(state)
        3'b000:
        begin
            if((cod[7:6]==btn[7:6])&&(d1))
            state<=3'b001;
            else
            state<=3'b110;
        end
            
        
        3'b001:
         begin
            if((cod[5:4]==btn[5:4])&&(d2))
            state<=3'b010;
            else
            state<=3'b110;
        end
        
        3'b010:
         begin
            if((cod[3:2]==btn[3:2])&&(d3))
            state<=3'b011;
            else
            state<=3'b110;
        end
            
              
        3'b011:
             if((cod[1:0]==btn[1:0])&&(d4))
            state<=3'b100;
            else
              state<=3'b110; 
              
        3'b100:
        begin
            biens<=1'b1;
            state<=3'b000;
        end
        
        3'b110:
        begin
            mals<=1'b1;
            state<=3'b000;
        end
        endcase

    end
end
assign bien=biens;
assign mal=mals;
endmodule

