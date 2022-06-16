module rega(
	input logic [1:0] arad, brad,
	output logic[15:0] outa, outb,
	input we,
	input logic [1:0] wad,
	input logic [15:0] wd,
	input clk, rst);
	logic [15:0] regar[3:0];
	always_ff @(posedge clk)
		if(we) regar[wad] <= wd;
	assign outa = regar[arad];
	assign outb = regar[brad];
endmodule
