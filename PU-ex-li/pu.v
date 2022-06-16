module pu(
	output we,
	output logic [15:0] wd,
	input clk, rst);
	logic [15:0] a, b, lb;
	logic [7:0] iv;
	logic [1:0] arad, brad, wad;
	logic [2:0] op;
	logic [5:0] pca;
	logic [15:0] o;
	rega rega(arad, brad, a, b, we, wad, wd, clk, rst);
	lidx lidx(b, lb, lh, ll, iv);
	alu alu(a, lb, op, wd);
	pc pc(halt, pca, clk, rst);
	imem imem(pca, o);
	dec dec(o, arad, brad, op, wad, we, halt, ll, lh, iv);
endmodule


