//modified version of Ex2 - more bits in I/O now

`timescale 1ns / 100ps

module multiplexer(
    input [23:0] a,
	input [23:0] b,
	input sel,
	output [23:0] out
    );
    
    //define wire
	wire [23:0] out;

	assign #5 out = (sel==1'b0)?a : b;                
      
endmodule
