`include "pu.vh"
module alu(input [`WIDTH:0] a, b, input [`OPS:0] op, output logic [`WIDTH:0] r);
//	enum {ADD, SUB, THU, ASL, RSL, RSR, NAD, XOR} OPETYP;
	parameter ADD=0, SUB=1, THU=2, ASL=3, RSL=4, RSR=5, NAD=6, XOR=7;
	always @*
		case(op)
		// synopsys full_case parallel_case
		ADD: r = a+b;	
		SUB: r = a-b;
		THU: r = b;
		ASL: r = a>>>b;
		RSL: r = a>>b;
		RSR: r = a<<b;
		NAD: r = ~(a&b);
		XOR: r = a^b;
		endcase
endmodule
