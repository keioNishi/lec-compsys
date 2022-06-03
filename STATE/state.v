module state(a, b, floor, clk, rst);
	input a, b;
	output [1:0] floor;
	input clk, rst;
	logic [1:0] s, ns;
	logic [1:0] floor;
	always @(posedge clk)
		if(rst) s <= 0;
		else s <= ns;
	always_comb begin
		ns = s;
		if(({a, b} == 2'b00) || ({a, b} == 2'b11))
			ns = s;
		else
			case(s)
			// synopsys full_case parallel_case
			2'b00:begin
				if(a) ns = 2'b01;
				floor = 1;
			end
			2'b01:begin
				if(a) ns = 2'b11;
				if(b) ns = 2'b00;
				floor = 2;
			end
			2'b11:begin
				if(b) ns = 2'b01;
				floor = 3;
			end
			endcase
	end
endmodule
