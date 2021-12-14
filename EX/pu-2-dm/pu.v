`include "pu.vh"
module pu(output we, output logic [`WIDTH:0] wd, input clk, rst);
	logic [`WIDTH:0] a, b, bo, lp, dmrd;
	logic [`HALFWIDTH:0] iv;
	logic [`RASB:0] arad, brad, wad;
	logic [`OPS:0] op;
	logic [`PCS:0] pca;
	logic [`CMDS:0] o;
	logic [`LICMDS:0] liop;
	rega rega(arad, brad, a, b, we, wad, wd, clk, rst);
	lidx lidx(b, iv, liop, bo);
	alu alu(a, bo, op, lp);
	pc pc(h, pca, clk, rst);
	imem imem(pca, o);
	dec dec(o, h, we, wad, op, brad, arad, liop, iv, dmwe, dms);
	dmem dmem(lp[`DMSB:0], bo, dmwe, dmrd, clk);
	sel dmsel (lp, dmrd, dms, wd);
endmodule


