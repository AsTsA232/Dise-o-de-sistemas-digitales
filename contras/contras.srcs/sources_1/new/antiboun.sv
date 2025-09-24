`timescale 1ns / 1ps

module antiboun(
input i1,i2,i3,i4, reset, clk,
output btn1,btn2,btn3,btn4,qn
    );
 logic s1,s2,s3;
 
 logic s4,s5,s6;
 
 logic s7,s8,s9;
 
 logic s10,s11,s12;
 
 filpflopd u1(.d(i1),.reset(reset),.clk(clk),.q(s1)); 
 filpflopd u2(.d(s1),.reset(reset),.clk(clk),.q(s2)); 
 filpflopd u3(.d(s2),.reset(reset),.clk(clk),.q(s3));  
 assign btn1=(s1 && s2 && s3);  
 
  filpflopd u4(.d(i2),.reset(reset),.clk(clk),.q(s4)); 
 filpflopd u5(.d(s4),.reset(reset),.clk(clk),.q(s5)); 
 filpflopd u6(.d(s5),.reset(reset),.clk(clk),.q(s6));  
 assign btn2=(s4 && s5 && s6); 
 
 filpflopd u7(.d(i3),.reset(reset),.clk(clk),.q(s7)); 
 filpflopd u8(.d(s7),.reset(reset),.clk(clk),.q(s8)); 
 filpflopd u9(.d(s8),.reset(reset),.clk(clk),.q(s9));  
 assign btn3=(s7 && s8 && s9);
 
 filpflopd u10(.d(i4),.reset(reset),.clk(clk),.q(s10)); 
 filpflopd u11(.d(s10),.reset(reset),.clk(clk),.q(s11)); 
 filpflopd u12(.d(s11),.reset(reset),.clk(clk),.q(s12));  
 assign btn4=(s10 && s11 && s12);
 
 assign qn=!(s3 && s6 && s9 && s12);
 
endmodule
