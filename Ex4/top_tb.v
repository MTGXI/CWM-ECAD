//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Dynamic LED lights
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex4 - Dynamic LED lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
	);

	//parameters
	parameter CLK_PERIOD = 10;

	//registers
	reg clk,rst,err,button;
	reg [2:0] colour_prev;
	wire [2:0] colour;
	

	//creating the clock
	initial begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

	//logic and testing output
	
	initial begin
		err = 0;
		button = 0;
		rst = 0;
		colour_prev = colour;
		
		#(CLK_PERIOD);
		if (colour != 3'd1) begin
			$display("***TEST FAILED 1***");
			err = 1;
		end
		

		rst = 1;
		#(CLK_PERIOD*10);
		if (colour!=3'd0) begin
			$display("***TEST FAILED 2***");
			err = 1;
		end

		#(CLK_PERIOD)
		button = 1;
		rst = 0;
		////??????/////
		
		forever begin
			#CLK_PERIOD
			if(colour_prev == colour) begin
				if (button==1'b1) begin
					$display("***TEST FAILED 3***");
					err = 1;
				end
			end
			colour_prev = colour;
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
	lights top (.clk (clk),.rst (rst),.colour (colour));

endmodule
