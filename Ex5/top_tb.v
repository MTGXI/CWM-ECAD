//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Air Conditioning
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex5 - Air Conditioning
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
	);

	//parameters
	parameter CLK_PERIOD = 10;
	


	//reg countDir = 1'b0;
	//registers
	reg clk,err;
	reg [4:0] temperature;
	reg [1:0] prev_state;
	wire [1:0] state = {heating,cooling};
	wire heating,cooling;
	

	//creating the clock
	initial begin
       	clk = 1'b0;
		forever
        #(CLK_PERIOD/2) clk=~clk;
   	end

	//logic and testing output
	
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

	end


	//end sim block
	initial begin
        #150
        if (err==0)
          $display("***TEST PASSED***");
        $finish;
      end


	//instantiation
	AC top (
	.clk (clk),
	.temperature (temperature),
	.heating (heating),
	.cooling (cooling)
	);

endmodule
