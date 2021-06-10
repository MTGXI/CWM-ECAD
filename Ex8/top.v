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

module top(clk_p,clk_n,rst_n,heating,cooling,temperature_0,temperature_1,temperature_2,temperature_3,temperature_4);
    
    input clk_p,clk_n,rst_n,temperature_0,temperature_1,temperature_2,temperature_3,temperature_4;
	//input [4:0] temperature;
	output heating;
	output cooling;
    
    

   /* clock infrastructure, do not modify */
        wire clk_ibufds;

    IBUFDS IBUFDS_sysclk (
	.I(clk_p),
	.IB(clk_n),
	.O(clk_ibufds)
);

     wire clk; //use this signal as a clock for your design
     
     //generating a temperature wire from all the input ports - RMB is index 0
     wire [4:0] temperature = {temperature_4,temperature_3,temperature_2,temperature_1,temperature_0};
       
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

endmodule
