`include "pu.vh"
module rega(input logic [`RASB:0] arad, brad, output logic [`WIDTH:0] a, b,
	input we, input logic [`RASB:0] wad, input [`WIDTH:0] wd,
	input clk, rst);
	logic [`WIDTH:0] regar [`RAS:0];
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			regar[0] <= 0;
			regar[1] <= 0;
			regar[2] <= 0;
			regar[3] <= 0;
		end else if(we) regar[wad] <= wd;
	end
	assign a = regar[arad];
	assign b = regar[brad];
endmodule
