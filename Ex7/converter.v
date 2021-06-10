`timescale 1ns / 100ps

module converter(clk,enable,colour,rgb);

	//ports
	input clk,enable;
	input [2:0] colour;
	output [23:0] rgb;

	
	mybram rgb_mem (
	  .clka(clk),    // input wire clka
	  .ena(enable),      // input wire ena
	  .wea(1'b0),      // input wire [0 : 0] wea
	  .addra(colour),  // input wire [2 : 0] addra
	  .dina(24'b0),    // input wire [23 : 0] dina
	  .douta(rgb)  // output wire [23 : 0] douta
	);

endmodule
