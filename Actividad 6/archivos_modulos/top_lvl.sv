`timescale 1ns / 1ps

module top_lvl(
    input logic go,clk,clr,
    input logic [7:0] xin,yin,
    output logic [6:0] sal,
    output logic [3:0] an
    );
//Señales
logic [7:0] xr,x1,yr,y1,x,y,gdc;
logic xsel,ysel,xld,yld,gld,eqlflg,ltflg;    
//Multiplexores---------------------------------------------------------------
    mux xmux (.vec0(xr),.vec1(xin),.sel(xsel),.v_out(x1));    
    mux ymux (.vec0(yr),.vec1(yin),.sel(ysel),.v_out(y1));    
//Registros-------------------------------------------------------------------
    regi xreg(.clr(clr),.clk(clk),.ld(xld),.v_in(x1),.v_out(x));
    regi yreg(.clr(clr),.clk(clk),.ld(yld),.v_in(y1),.v_out(y));
    regi greg(.clr(clr),.clk(clk),.ld(gld),.v_in(x),.v_out(gdc));
//Substractores---------------------------------------------------------------
    substractor xsubstractor(.g_vec(x),.l_vec(y),.out_v(xr));
    substractor ysubstractor(.g_vec(y),.l_vec(x),.out_v(yr));
//Comparador------------------------------------------------------------------
    compare comp (.x(x),.y(y),.eqlflg(eqlflg),.ltflg(ltflg));
//Unidad de control-----------------------------------------------------------
    control_u unidad_c (.go(go),.clr(clr),.clk(clk),.eqflg(eqlflg),
    .ltflg(ltflg),.ysel(ysel),.xsel(xsel),.xld(xld),.yld(yld),.gld(gld));
//7 segmentos-----------------------------------------------------------------
    seg disp (.gdc(gdc),.reset(clr),.clk(clk),.sal(sal),.an(an));

endmodule

