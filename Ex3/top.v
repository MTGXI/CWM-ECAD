//////////////////////////////////////////////////////////////////////////////////
// Exercise #3 - Active IoT Devices Monitor
// Student Name: Josh Metge
// Date: 07/06 
//
//  Description: In this exercise, you need to design a counter of active IoT devices, where 
//  if the rst=1, the counter should be set to zero. If event=0, the value
//  should stay constant. If on-off=1, the counter should count up every
//  clock cycle, otherwise it should count down.
//  Wrap-around values are allowed.
//
//  inputs:
//           clk, rst, change, on_off
//
//  outputs:
//           counter_out[7:0]
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module monitor (rst,clk,change,on_off,counter_out);
    
	//add ports 
	input rst,change,on_off,clk;
	output [7:0] counter_out;
                    
    //Register
	reg [7:0] c;//coutner register

	assign counter_out = c;
    //Up-down counter logic
	always @(posedge clk or posedge rst) begin
		if(rst)
			c <= 0;
		else
			if(change==0)
				c <= c;
			else
				if(on_off==1)
					c = c+1;
				else if (on_off==0)
      				c = c-1;
	end

endmodule
