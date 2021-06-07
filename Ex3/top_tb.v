//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Active IoT Devices Monitor
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex3 - Active IoT Devices Monitor
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Parameters
	parameter CLK_PERIOD = 10;

//Regitsers and wires
	reg clk,rst,change,on_off,err;
	reg [7:0] counter_out;

//Clock generation
	 initial
		begin
		   clk = 1'b0;
		   forever
		     #(CLK_PERIOD/2) clk=~clk;//every half clock period
		 end

//logic and output tests
    initial begin
	
	end
//Finish test, check for success
	initial begin
        #50 
        if (err==0)
          $display("TEST PASSED");
        $finish;
      end

//Instantiate counter module
monitor top (
	.clk (clk),
	.rst (rst),
	.change (change),
	.on_off (on_off),
	.counter_out (counter_out[7:0])
	);
 
endmodule 
