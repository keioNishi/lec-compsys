module state(a, b, floor, clk, rst);
	input a, b;
	output [1:0] floor;
	input clk, rst;
	logic [2:0] s, ns;
	logic [1:0] floor;
	always @(posedge clk)
		if(rst) s <= 3'b001;
		else s <= ns;
	always_comb begin
		case(1)
		// synopsys full_case parallel_case
		s[0]: begin
			floor = 1;
			case({a,b})
			// synopsys full_case parallel_case
			2'b00: ns = 3'b001;
			2'b01: ns = 3'b001;
			2'b10: ns = 3'b010;
			2'b11: ns = 3'b001;
			endcase
		end
		s[1]: begin
			floor = 2;
			case({a,b})
			// synopsys full_case parallel_case
			2'b00: ns = 3'b010;
			2'b01: ns = 3'b001;
			2'b10: ns = 3'b100;
			2'b11: ns = 3'b010;
			endcase
		end
		s[2]: begin
			floor = 3;
			case({a,b})
			// synopsys full_case parallel_case
			2'b00: ns = 3'b100;
			2'b01: ns = 3'b010;
			2'b10: ns = 3'b100;
			2'b11: ns = 3'b100;
			endcase
		end
		endcase
	end
endmodule
