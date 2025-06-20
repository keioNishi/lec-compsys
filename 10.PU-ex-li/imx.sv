`include "pu.vh"
module imx( // Immediate Value Mixer
	input [`WIDTH:0] i,
	input [`HALFWIDTH:0] iv,
	input [`IMXS:0] op,
	output logic [`WIDTH:0] o);
	always_comb
		casex(op)
		// synopsys full_case parallel_case
		`LIL:
			o = {i[`WIDTH:`HALFWIDTH+1],iv};
		`LIH:
			o = {iv,i[`HALFWIDTH:0]};
		`IMM:
			o = {{8{iv[`HALFWIDTH]}},iv[`HALFWIDTH:0]};
		`THU:
			o = i;
		endcase
endmodule
