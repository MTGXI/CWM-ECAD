//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 - Air Conditioning
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to an air conditioning control system
//  According to the state diagram provided in the exercise.
//
//  inputs:
//           clk, temperature [4:0]
//
//  outputs:
//           heating, cooling
//				both cannot be on at same time
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module AC (clk,temperature,heating,cooling);

	//adding ports
	input clk;
	input [4:0] temperature;
	output heating,cooling;

	reg [1:0] state;
	//wire heating,cooling;

	//let left bit be heating, let no bits be idle, let right be cooling - 11 is not possible
	assign heating = (state==2'b10);
	assign cooling = (state==2'b01);
	//heating = state[1];
	//cooling = state[0];

	always @(posedge clk) begin
		case(state)
			2'b10: state <= temperature<20 ? 2'b10 : 2'b00;//for heating state - if temp<20 state = 10 otherwise goes to idle
			2'b00: state <= temperature<=18 ? 2'b10 : temperature>=22 ? 2'b01 : 2'b00;
			//for idle state - if temp <= 18 state goes to 10 etc, stays at idle if neit
			2'b01: state <= temperature>20 ? 2'b01 : 2'b00; 
			default: state <= 2'b00;//default state is idle
		endcase
	end
endmodule
