`include "pu.vh"
module lidx(
	input [`WIDTH:0] b,
	output [`WIDTH:0] lb,
	input lh, ll,
	input [`HALFWIDTH:0] iv);
	logic [`WIDTH:0] lb;
	always_comb begin
		case({lh,ll})
		// synopsys full_case parallel_case
		2'b00: lb = b;
		2'b10: lb = {iv, b[7:0]};
		2'b01: lb = {b[15:8], iv};
		2'b11: lb = {8'b00000000, iv};
		endcase
	end
endmodule
