`include "pu.vh"

module alu(input [`WIDTH:0] a, b, input [`OPS:0] op, output logic [`WIDTH:0] r,
		input dstb, output logic ze, ca, sg, input clk, rst);
	enum {ADD, SUB, THB, ASR, RSR, RSL, NAD, XOR} OPETYP;
	logic [`WIDTH+1:0] rr;
	always @* begin
		case(op)
		// synopsys full_case parallel_case
		ADD: rr = a+b;
		SUB: rr = a-b;
		THB: rr = b;
		ASR: rr = a>>>b;
		RSR: rr = a>>b;
		RSL: rr = a<<b;
		NAD: rr = ~(a&b);
		XOR: rr = a^b;
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
