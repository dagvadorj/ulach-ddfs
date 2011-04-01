`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// 
////////////////////////////////////////////////////////////////////////////////

module ddfs_test;

   // Inputs
   reg clk;
   reg [22:0] fcontrol;

   // Outputs
   wire [7:0] outp;

   // Instantiate the Unit Under Test (UUT)
   ddfs uut (
      .clk(clk), 
      .fcontrol(fcontrol),
      .outp(outp)
   );
   
   // 1MHz
   always #50 clk = ~clk;

   initial begin
      clk = 0;
      
      fcontrol = 23'b00000110000000000000000;
      #200000;
      
      fcontrol = 23'b00000000110000000000000;
      #200000;
      
      fcontrol = 23'b00000001110000000000000;
      #200000;
  
      $finish;

   end
      
endmodule

