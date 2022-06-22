`include "pu.vh"
module alu( // ALU
	input [`WIDTH:0] a, b,
	input [`ALUOPS:0] op,
	output [`WIDTH:0] r,
	output logic ze, ca, sg,
	input clk, rst);
	logic [`WIDTH+1:0] rr;
	always_comb begin
		case(op)
		// synopsys full_case parallel_case
		`ADD: rr = a+b;
		`SUB: rr = a-b;
		`ASR: rr = a>>>b; // Arithmetic Shift Right
		`RSR: rr = a>>b; // Rotate Shift Right
		`RSL: rr = a<<b; // Rotate Shift Left
		`BST: rr = a|(1<<b); // Bit Set
		`BRT: rr = a&(~(1<<b)); // Bit Reset
		`BTS: rr = {8{a[b]}}; // Bit Test
		`AND: rr = a&b;
		`OR:  rr = a|b;
		`NAD: rr = ~(a&b);
		`XOR: rr = a^b;
		`MUL: rr = a*b; // no carry
		`EXT: rr = 0; // for future reserved
		`THA: rr = a;
		`THB: rr = b;
		endcase
	end
	assign r = rr[`WIDTH:0];
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			ze <= `NEGATE;
			ca <= `NEGATE;
			sg <= `NEGATE;
		end else begin
			if(r == 0) ze <= `ASSERT;
			else ze <= `NEGATE;
			if(r[`WIDTH] == 1'b1) sg <= `ASSERT;
			else sg <= `NEGATE;
			if(rr[`WIDTH+1] == 1'b1) ca <= `ASSERT;
			else ca <= `NEGATE;
		end
	end
endmodule
