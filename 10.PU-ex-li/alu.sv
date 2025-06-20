`include "pu.vh"
module alu( // ALU
	input [`WIDTH:0] a, b,
	input [`ALUOPS:0] op,
	output logic [`WIDTH:0] r);
	always_comb begin
		case(op)
		// synopsys full_case parallel_case
		`ADD: r = a+b;
		`SUB: r = a-b;
		`ASR: r = a>>>b; // Arithmetic Shift Right
		`RSR: r = a>>b; // Rotate Shift Right
		`RSL: r = a<<b; // Rotate Shift Left
		`BST: r = a|(1<<b); // Bit Set
		`BRT: r = a&(~(1<<b)); // Bit Reset
		`BTS: r = {8{a[b]}}; // Bit Test
		`AND: r = a&b;
		`OR:  r = a|b;
		`NAD: r = ~(a&b);
		`XOR: r = a^b;
		`MUL: r = a*b; // no carry
		`EXT: r = 0; // for future reserved
		`THA: r = a;
		`THB: r = b;
		endcase
	end
endmodule
