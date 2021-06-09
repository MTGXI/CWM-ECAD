//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - RGB Colour Converter
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex6 - RGB Colour Converter
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
	);

	//parameters
	parameter CLK_PERIOD = 10;

	//registers
	reg clk,err,enable;
	reg [2:0] colour;
	wire [23:0] rgb;
	

	//creating the clock
	initial begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

	//logic and testing output
	
	initial begin
		err = 0;
		enable = 0;
		colour = 3'b0;
		
		enable = 1; //tells to look up a colour
		forever begin
			#CLK_PERIOD
			$display("colour=%d, rgb=%d", colour,rgb);
			
			colour = colour + 3'd1;
		end

		
	end

	//end sim block
	initial begin
        #500 
        if (err==0)
          $display("***TEST PASSED***");
        $finish;
      end


	//instantiation
	RGB top (
		.clk(clk),
		.enable (enable),
		.colour (colour),
		.rgb (rgb)
		);

endmodule
