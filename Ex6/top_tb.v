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
		
		#CLK_PERIOD //gives simgui time to switch states
		enable = 1; //tells to look up a colour
		forever begin
			#(CLK_PERIOD*2)
			$display("colour=%d, rgb=%d", colour,rgb);
			if ((colour[0]!=(&rgb[7:0]))||(colour[1]!=(&rgb[15:8]))||(colour[2]!=(&rgb[23:16]))) begin	//do bitwise and on each to ensure correct coversion
				$display("***TEST FAILED*** - RGB and colour values don't match");
				err = 1;
				//$finish;
			end
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
