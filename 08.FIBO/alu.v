module alu(input [15:0] a, b, input [2:0] op, output [15:0] result);
	logic [15:0] result;
	always_comb
		case(op)
		// synopsys full_case parallel_case
		3'b000: result = a+b; // ADD
		3'b001: result = a-b; // SUB
		3'b010: result = a&b; // AND
		3'b011: result = a|b; // OR
		// もっとあるけど省略
		3'b111: result = a; // A Thru
		endcase
endmodule