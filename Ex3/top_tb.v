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
	reg [7:0] counter_prev;
	wire [7:0] counter_out;

	//Clock generation
	 initial
		begin
		   clk = 1'b0;
		   forever
		     #(CLK_PERIOD/2) clk=~clk;//every half clock period
		 end

	//logic and output tests
	initial begin
		err = 0;
		rst = 1;
		
		
		
		change = 0;
		on_off = 1;

		#(CLK_PERIOD*3);
		//ensure counter has reset to 0 	
		if (counter_out != 0) begin
			$display("TEST FAILED");
			err = 1;
		end

		rst = 0;
		//check counter value stays constant for change = 0 no reset
		#(CLK_PERIOD*3);
		if (counter_out != counter_prev) begin
			$display("TEST FAILED");
			err = 1;
		end
		
		counter_prev = counter_out;


		change = 1;
		
		forever begin
			#CLK_PERIOD 
			if ((on_off ==1) && (counter_out < counter_prev)) begin//checking that counter inc/dec correctly
				$display("TEST FAILED");
				err = 1;
			end
			else if ((on_off == 0) && (counter_out > counter_prev)) begin
				$display("TEST FAILED");
				err = 1;
			end
			else begin
			end
			
			//check counter reset
			if ((rst==1) && (counter_out != 0)) begin
				$display("TEST FAILED");
				err = 1;
			end
			counter_prev = counter_out;

			//on_off testing to check coutning correctly
			if (counter_out == 10) begin
				on_off =~ on_off;
			end
			if (counter_out == 0) begin
				on_off =~ on_off;
			end 
		end
	end

	//Finish test, check for success
	initial begin
        #250 //wait # clocks before checking if any fails have been flagged
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
		.counter_out (counter_out)
		);
 
endmodule 
