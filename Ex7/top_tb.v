//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Lights Selector
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex7 - Lights Selector
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
	);

	//parameters
	parameter CLK_PERIOD = 10;
	
	//registers
	reg clk,err,sel,button,rst;
	//reg [2:0] colour;
	//reg [23:0] rgb;
	wire [23:0] light;
	reg [23:0] lightPrev;

	//creating the clock
	initial begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

	//logic and testing output

	//takes a few clock ticks for sim to update with latest values, use corr. delay
	initial begin
		err=0;
		rst=0;
		button=0;
		//initially, no button so not changing and no reset so colours can grow 
		
		lightPrev=light;

		sel = 0;
		#(CLK_PERIOD)
		if (light != 24'hffffff) begin
			$display("***TEST FAILED 1***");
			err = 1;
		end
		button = 1;
		#(CLK_PERIOD)
		if (light != 24'hffffff) begin
			$display("***TEST FAILED 1***");
			err = 1;
		end
		//at sel==0, white light should  be ouput regardless of what signal propagate through rest of system
		
		sel = 1;
		rst = 1;
		#(CLK_PERIOD)
		//in rst, colour should reset to the start - depends on sequence in memcoe (remebering 0 and 7 are unused)
		if (light!= 24'h0000FF) begin
			$display("***TEST FAILED 3***");
			err = 1;
		end
		
		rst = 0;
		button = 0;//now should be back to being fixed at the value when button was turned off
		#(CLK_PERIOD*5)
		if (lightPrev != light) begin
			$display("***TEST FAILED 4***");
			err = 1;
		end
		
		//now test and validate the rest of system, as per the indivdual exercises.
		//button is on so should be switching colours
		button=1;
		forever begin
			#(CLK_PERIOD*2)
			//should be moving through the sequence
			if(lightPrev==light) begin
				$display("***TEST FAILED 2***");
				err = 1;
			end
			lightPrev=light;
		end
		
	end

	//end sim block
	initial begin
        #150 
        if (err==0)
          $display("***TEST PASSED***");
        $finish;
      end


	//instantiation
	lightSelector top (
		.clk(clk),
		.rst(rst),
		.sel(sel),
		.button(button),
		.light(light)
		);

endmodule
