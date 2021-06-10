//////////////////////////////////////////////////////////////////////////////////
// Exercise #7 - Lights Selector
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to implement a selector between RGB 
// lights and a white light, coded in RGB. If sel is 0, white light is used. If
//  the sel=1, the coded RGB colour is the output.
//
//  inputs:
//           clk, sel, rst, button
//
//  outputs:
//           light [23:0]
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module lightSelector(clk,sel,rst,button,light);

	//ports
	input clk,sel,rst,button;
	output [23:0] light; 

	//define white
	reg [23:0] white = 24'hffffff;
	
	//wires between ports of module instances
	wire [2:0] colour;
	wire [23:0] rgb;
	
	//instantiate all instances of lower level files here
	lights lights(
	.clk(clk),
	.rst(rst),
	.button(button),
	.colour(colour)
	);
	
	converter converter(
	.clk(clk),
	.enable(1),//want enable always = 1, always want look up to take place
	.colour(colour),
	.rgb(rgb)
	);
	
	multiplexer mulitplexer(
	.a(white),
	.b(rgb),
	.sel(sel),
	.out(light)
	);

endmodule
