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
   reg [22:0] accum_next;
   reg [7:0] rom_data[2**9-1:0];
   
   initial
      begin
         $readmemb("rom.dat", rom_data, 0, 2**9-1);
         accum = 0;
         sign = 0;
      end
   
   always @(posedge clk)
      begin
         accum_old = accum[22:14];
         accum = accum + fcontrol;
         accum_next = accum + fcontrol;
         $display("%d %d %d\n", accum_old, accum[22:14], accum_next[22:14]);
         if (accum_old > accum[22:14])
            sign = ~sign;
         
         if (sign == 1'b0)
            begin
               outp = rom_data[accum[22:14]];
               if (accum[22:14] < accum_next[22:14])
                  begin
                     // accum[22:14] = accum[22:14] + 9'b011111111;
                     outp = rom_data[accum[22:14] + 2'b11];
                  end
            end
         else
            outp = 0-rom_data[accum[22:14]];
      end

endmodule
