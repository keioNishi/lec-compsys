module top(output we, output logic [15:0] wd, input clk, rst);
	logic [15:0] a, b;
	logic [1:0] arad, brad, wad;
	logic [2:0] op;
	logic [5:0] pca;
	logic [10:0] o;
	rega rega(arad, brad, a, b, we, wad, wd, clk, rst);
	alu alu(a, b, op, wd);
	pc pc(halt, pca, clk, rst);
	imem imem(pca, o);
	dec dec(o, arad, brad, op, wad, we, halt);
endmodule


