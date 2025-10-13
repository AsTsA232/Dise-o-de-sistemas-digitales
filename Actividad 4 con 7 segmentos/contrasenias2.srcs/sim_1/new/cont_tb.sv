`timescale 1ns / 10ps

module cont_tb;  
  logic [7:0] dig;      
  logic [3:0] botones;   
  logic reset, clk,bien,mal;  
  logic [6:0] sal;
  logic [3:0] an;
  localparam T=10;

  conts #(.N(18)) uut (
    .dig(dig),
    .botones(botones),
    .reset(reset),
    .clk(clk),
    .bien(bien),
    .mal(mal),
    .sal(sal),
    .an(an)
  );

  // Generador de reloj
    always 
        begin
            clk=1'b1;
            #(T/2);
            clk=1'b0;
            #(T/2);
        end 


  initial begin
    reset = 1;
    dig = 8'b00000000;   
    botones = 4'b0000;    
    #10000000; reset = 0;       
    
     #10000000;


//Digitos bien y secuencia bien
    dig = 8'b10000110; 
        
    botones = 4'b0001;    
    #10000000; 
    //#20000;  
    botones = 4'b0010;     
    //repeat(1000000) @(negedge clk);
    #10000000;
    botones = 4'b0100;   
    #10000000;
    botones = 4'b1000;    
    #10000000;
    botones = 4'b0000;
    #20000000;

       reset = 1;
    dig = 8'b00000000;   
    botones = 4'b0000;    
    #10000000; reset = 0;  

//digitos bien secuencia mal

    dig = 8'b10000110; 
        
    botones = 4'b1000;    
    #10000000; 
    //#20000;  
    botones = 4'b0100;     
    //repeat(1000000) @(negedge clk);
    #10000000;
    botones = 4'b0001;   
    #10000000;
    botones = 4'b1000;    
    #10000000;
    botones = 4'b0000;
    #20000000;

       reset = 1;
    dig = 8'b00000000;   
    botones = 4'b0000;    
    #10000000; reset = 0; 
     
//digitos mal secuencia bien

    dig = 8'b10000010; 
        
    botones = 4'b0001;    
    #10000000; 
    //#20000;  
    botones = 4'b0010;     
    //repeat(1000000) @(negedge clk);
    #10000000;
    botones = 4'b0100;   
    #10000000;
    botones = 4'b1000;    
    #10000000;
    botones = 4'b0000;
    #20000000;

       reset = 1;
    dig = 8'b00000000;   
    botones = 4'b0000;    
    #10000000; reset = 0;  

//digitos mal secuencia mal
    dig = 8'b10000100; 
        
    botones = 4'b1000;    
    #10000000; 
    //#20000;  
    botones = 4'b0010;     
    //repeat(1000000) @(negedge clk);
    #10000000;
    botones = 4'b0100;   
    #10000000;
    botones = 4'b0001;    
    #10000000;
    botones = 4'b0000;
    #20000000;

       reset = 1;
    dig = 8'b00000000;   
    botones = 4'b0000;    
    #10000000; reset = 0;  
    
    
    $stop;
  end
endmodule

