`include "pu.vh"
module alu(input [`WIDTH:0] a, b, input [`OPS:0] op, output logic [`WIDTH:0] r);
	enum {ADD, SUB, THU, ASL, RSL, RSR, NAD, XOR} OPETYP;
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
