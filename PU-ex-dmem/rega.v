`include "pu.vh"
module rega(
	input logic [`RASB:0] arad, brad,
	output logic[`WIDTH:0] outa, outb,
	input we,
	input logic [`RASB:0] wad,
	input logic [`WIDTH:0] wd,
	input clk, rst);
	logic [`WIDTH:0] regar[`RAS:0];
	always_ff @(posedge clk)
		if(we) regar[wad] <= wd;
	assign outa = regar[arad];
	assign outb = regar[brad];
endmodule
