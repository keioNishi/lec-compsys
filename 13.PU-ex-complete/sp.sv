`include "pu.vh"
module sp(
	output [`WIDTH:0] spo,
	input we,
	input [`WIDTH:0] spi,
	input clk, rst);
	logic [`WIDTH:0] regsp;
	always @(posedge clk or posedge rst)
		if(rst) begin
			regsp <= 0;
		end else begin
			if(we) regsp <= spi;
		end
	assign spo = regsp;
endmodule
