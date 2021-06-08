//////////////////////////////////////////////////////////////////////////////////
// Exercise #4 - Dynamic LED lights
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to design a LED based lighting solution, 
//  following the diagram provided in the exercises documentation. The lights change 
//  as long as a button is pressed, and stay the same when it is released. 
//
//  inputs:
//           clk, rst, button
//
//  outputs:
//           colour [2:0]
//
//  You need to write the whole file.
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module lights (rst,clk,button,colour);

	//adding ports
	input rst,clk,button;
	output reg [2:0] colour;

	//no register required for colour

	always @ (posedge clk) begin
		if(rst) begin
			colour = 3'd0;
		end
		else begin
			if ((colour==3'd0)||(colour==3'd7)) begin
				#1;
				colour = 3'd1;
			end
			else begin
				if (button==1'b1) begin
					#1;
					colour = colour + 3'd1;
				end
				else begin
				end
			end
		end
	end

endmodule
			
