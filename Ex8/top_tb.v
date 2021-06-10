//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #8  - Simple End-to-End Design
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex8
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
	);

	//parameters
	parameter CLK_PERIOD = 10;

	//registers
	reg clk
	

	//creating the clock
	initial begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

	//logic and testing output
	
	initial begin
		err = 0;
		
	end

	//end sim block
	initial begin
        #100 
        if (err==0)
          $display("***TEST PASSED***");
        $finish;
      end


	//instantiation
	RGB top (
		.clk(clk),
		.
		);

endmodule
