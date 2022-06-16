`include "pu.vh"
module pu(
	output we,
	output logic [`WIDTH:0] wd,
	input clk, rst);
	logic [`WIDTH:0] a, b, lb, lm, dmrd;
	logic [`HALFWIDTH:0] iv;
	logic [`RASB:0] arad, brad, wad;
	logic [`OPS:0] op;
	logic [`PCS:0] pca;
	logic [`CMDS:0] o;
	rega rega(arad, brad, a, b, we, wad, wd, clk, rst);
	lidx lidx(b, lb, lh, ll, iv);
	alu alu(a, lb, op, lm);
	pc pc(halt, pca, clk, rst);
	imem imem(pca, o);
	dec dec(o, arad, brad, op, wad, we, halt, ll, lh, iv, dmwe, dms);
	dmem dmem(lm[`DMSB:0], b, dmwe, dmrd, clk);
	sel dmsel(lm, dmrd, dms, wd);
endmodule


