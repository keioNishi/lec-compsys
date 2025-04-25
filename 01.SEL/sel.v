module sel(ia, ib, sel, out);
	input ia, ib, sel;
	output out;
	logic out;
	always_comb
		if(sel == 1'b1) out = ia;
		else out = ib;
endmodule
