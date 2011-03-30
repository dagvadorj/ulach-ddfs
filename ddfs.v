`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////
module ddfs(clk,fcontrol,outp);
   parameter width = 8;
   
   input clk;
   input[22:0] fcontrol;
   
   output[7:0] outp;
   
   reg[7:0] outp;
   reg[22:0] accum;
   reg signed [7:0] rom_data[(2**width-1):0];
   
   initial
      begin
         $readmemb("rom.dat", rom_data, 0, 2**width-1);
         accum <= 0;
      end
   
   always @(posedge clk)
      begin
         accum <= accum + fcontrol;
         outp <= rom_data[accum[22:15]];
      end

endmodule
