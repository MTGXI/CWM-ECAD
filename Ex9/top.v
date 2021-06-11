//////////////////////////////////////////////////////////////////////////////////
// Exercise #8  - Simple End-to-End Design
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to design an air conditioning systems
//
//  inputs:
//           rst_n, clk_n, clk_p, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top(clk_p,clk_n,rst_n,heating,cooling,temperature_0,temperature_1,temperature_2,temperature_3,temperature_4,clk,sel,button,light,selShutdown);
    
    input clk_p,clk_n;
    input rst_n,temperature_0,temperature_1,temperature_2,temperature_3,temperature_4,clk,sel,button,selShutdown;
	//input [4:0] temperature;
	output heating;
	output cooling;
	wire [23:0] light;
	output [23:0] lightSysOut;
    
	//define white
	reg [23:0] white = 24'hffffff;
	
	//wires between ports of module instances
	wire [2:0] colour;
	wire [23:0] rgb;
    
    wire clk; //use this signal as a clock for your design
     
    //generating a temperature wire from all the input ports - RMB is index 0
    wire [4:0] temperature = {temperature_4,temperature_3,temperature_2,temperature_1,temperature_0};
    
    wire stateOut = {heating,cooling};
    output [1:0] acSysOut;

   /* clock infrastructure, do not modify*/
    wire clk_ibufds;

    IBUFDS IBUFDS_sysclk (
	.I(clk_p),
	.IB(clk_n),
	.O(clk_ibufds)
	);
 
     BUFG bufg_clk (
	.I  (clk_ibufds),
	.O  (clk)
      );

	//Add logic here
	
	AC airconditioning(
	.clk(clk),
	.temperature(temperature),
	.heating(heating),
	.cooling(cooling)
	);

	lightSelector lightModule(
	.clk(clk),
	.rst(rst_n),
	.button(button),
	.sel(sel),
	.light(light)
	);
	
	mplx lightOut(
		.a(0),
		.b(light),
		.sel(selShutdown),
		.out(lightSysOut)
	);
	
	mplx acOut(
		.a(0),
		.b(stateOut),
		.sel(selShutdown),
		.out(acSysOut)
	);
endmodule
