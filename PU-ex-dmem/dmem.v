`include "pu.vh"
module dmem(
	input [`DMSB:0] ad,
	input [`WIDTH:0] wd,
	input we,
	output [`WIDTH:0] rd,
	input clk);
	logic [`WIDTH:0] dm [`DMS:0];
	assign rd = dm[ad];
	always @(posedge clk)
		if(we) dm[ad] <= wd;
endmodule
