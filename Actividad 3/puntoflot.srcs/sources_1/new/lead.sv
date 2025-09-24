`timescale 1ns / 1ps

module lead(
    input logic [7:0] num,
    output logic [2:0] l
);

    always_comb
    begin
        if(num[7])
            begin
                l = 3'o0;
            end
        else if (num[6])
            begin
                l = 3'o1;
            end
        else if (num[5])
            begin
                l = 3'o2;
            end
        else if (num[4])
            begin
                l = 3'o3;
            end
        else if (num[3])
            begin
                l = 3'o4;
            end
        else if (num[2])
            begin
                l = 3'o5;
            end
        else if (num[1])
            begin
                l = 3'o6;
            end
        else
            begin
                l = 3'o7;
            end
    end
endmodule