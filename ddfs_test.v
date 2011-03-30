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
   
   always #50 clk = ~clk;
   
	initial begin
		// Initialize Inputs
		clk = 0;
      
      fcontrol = 23'b01110000111100001111000;
		#20000;
      
      fcontrol = 23'b00000001110000000000000;
		#20000;
        
		// Add stimulus here
      $finish;

	end
      
endmodule

