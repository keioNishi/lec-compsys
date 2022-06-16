`include "pu.vh"
module alu(
	input [`WIDTH:0] a, b,
	input [`OPS:0] op,
	output [`WIDTH:0] r);
	logic [`WIDTH:0] r;
//	yosys cannot handle enum
//	enum {ADD, SUB, ASL, RSL, RSR, NAD, XOR, THU} OPETYP;
	parameter ADD=0, SUB=1, ASL=2, RSL=3, RSR=4, NAD=5, XOR=6, THU=7;
	always_comb
		case(op)
		// synopsys full_case parallel_case
		ADD: r = a+b; // ADD
		SUB: r = a-b; // SUB
		ASL: r = a>>>b;
		RSL: r = a>>b;
		RSR: r = a<<b;
		NAD: r = ~(a&b);
		XOR: r = a^b;
		THU: r = b; // B Thru
		endcase
endmodule
