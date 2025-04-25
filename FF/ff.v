module ff(d, q, clk);
	input d;
	output q;
	input clk;
	logic q;
	always_ff @(posedge clk) begin
		q <= d;
	end
endmodule
