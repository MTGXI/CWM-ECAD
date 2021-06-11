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
	reg clk,err,button,sel,rst;
	reg [4:0] temperature;
	reg [1:0] prev_state;
	
	wire heating,cooling;
	wire [1:0] state = {heating,cooling};
	
	wire [23:0] light;
	reg [23:0] lightPrev;
	

	//creating the clock
	initial begin
       	clk = 1'b0;
		forever
        #(CLK_PERIOD/2) clk=~clk;
   	end

	//logic and testing output
	
	//testing the AC
	initial begin
		err=0;

		//for instance, start in idle with initial temp of 15
		temperature = 5'b01111;
	
		prev_state = state;
		//increment temp each time to see state changes
		forever begin
			#(CLK_PERIOD*2);
			if ((temperature<18)&&(heating!=1)) begin
				$display("***TEST FAILED 1***");
				err = 1;
			end
			else if ((temperature>22)&&(cooling!=1)) begin
				$display("***TEST FAILED 2***");
				err = 1;
			end

			if (heating==1 && cooling==1) begin
				$display("***TEST FAILED 3***");
				err = 1;
			end

			//checks if idle whether heating or cooling is turned on as expected
			if ((prev_state == 2'b00)&&(state == 2'b00)) begin
				if (temperature<=18) begin
					$display("***TEST FAILED 4***");
					err = 1;
				end
				else if (temperature>=22) begin
					$display("***TEST FAILED 5***");
					err = 1;
				end
			end
			
			temperature = temperature + 5'd1;
			
			prev_state = state;
		end
		//////////////////////////////////////////////////////////////////////////////
	end


	//testing lighting system
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
	top top (
	.clk (clk),
	.rst (rst_n),
	.temperature (temperature),
	.heating (heating),
	.cooling (cooling),
	.button (button),
	.sel(sel),
	.light(light)
	);

endmodule
endmodule
