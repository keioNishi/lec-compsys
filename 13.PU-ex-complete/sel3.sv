`include "pu.vh"
module sel3(
	input [`WIDTH:0] a, b, c,
	input [1:0] s,
	output logic [`WIDTH:0] o);
	always_comb
		case(s)
		// synopsys full_case parallel_case
		2'b00: o = a;
		2'b01: o = b;
		2'b10: o = c;
		endcase
endmodule
