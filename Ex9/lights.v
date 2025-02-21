`timescale 1ns / 100ps

module selLights (rst,clk,button,colour);

	//adding ports
	input rst,clk,button;
	output reg [2:0] colour;

	//no register required for colour

	always @ (posedge clk) begin
		if(rst) begin
			colour = 3'd0;
		end
		else begin
			if (button==1'b0) begin
				if ((colour==3'd0)||(colour==3'd7)) begin
					#1
					colour = 3'd1;
				end
			end
			else begin
				if (colour < 3'd6) begin
					#1
					colour = colour + 3'd1;
				end
				else begin
					#1
					colour = 3'd1;
				end
			end
		end
	end

endmodule
