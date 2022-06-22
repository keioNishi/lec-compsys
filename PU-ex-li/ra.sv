`include "pu.vh"
module ra(
	input logic [`RASB:0] arad, brad,
	output [`WIDTH:0] a, b,
	input we,
	input logic [`RASB:0] wad,
	input [`WIDTH:0] wd,
	input clk, rst);
	logic [`WIDTH:0] rega [`RAS:0];
	always @(posedge clk)
		if(we) rega[wad] <= wd;
	assign a = rega[arad];
	assign b = rega[brad];
endmodule
