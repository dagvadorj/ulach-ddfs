`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////
module ddfs(clk,fcontrol,outp);
   parameter width = 8;
   
   input clk;
   input [22:0] fcontrol;
   
   output [7:0] outp;
   
   reg [7:0] outp;
   reg [22:0] accum;
   reg sign;
   reg [7:0] rom_data[2**(width+1)-1:0];
   
   initial
      begin
         $readmemb("rom.dat", rom_data, 0, 2**(width+1)-1);
         accum <= 0;
      end
   
   always @(posedge clk)
      begin
         $display(sign);
         accum <= accum + fcontrol;
         if (accum[21] == 1'b1 && sign == 1'b0)
            sign <= 1'b1;
         else if (accum[21] == 1'b0 && sign == 1'b1)
            sign <= 1'b0; 
         
         if (sign == 1'b0)
            outp <= rom_data[accum[22:14]];
         else
            outp <= 0-rom_data[accum[22:14]];
      end

endmodule
