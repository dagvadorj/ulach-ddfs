`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////
module ddfs(clk,fcontrol,outp);
   input clk;
   input [22:0] fcontrol;
   
   output [7:0] outp;
   
   reg [7:0] outp;
   reg [22:0] accum;
   reg sign;
   reg [8:0] accum_old;
   reg [7:0] rom_data[2**9-1:0];
   
   initial
      begin
         $readmemb("rom.dat", rom_data, 0, 2**9-1);
         accum <= 0;
         sign <= 0;
      end
   
   always @(posedge clk)
      begin
         accum_old <= accum[22:14];
         accum <= accum + fcontrol;
         $display("%d %d\n", accum_old, accum[22:14]);
         if (accum_old > accum[22:14])
            sign = ~sign;
         
         if (sign == 1'b0)
            outp <= rom_data[accum[22:14]];
         else
            outp <= 0-rom_data[accum[22:14]];
      end

endmodule
