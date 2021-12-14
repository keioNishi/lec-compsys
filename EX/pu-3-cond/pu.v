`include "pu.vh"
module pu(output we, output logic [`WIDTH:0] rwd, input clk, rst);
	logic [`WIDTH:0] a, b, ao, bo, lp, mrd;
	logic [`HALFWIDTH:0] iv;
	logic [`RASB:0] arad, brad, wad;
	logic [`OPS:0] op;
	logic [`PCS:0] pca;
	logic [`CMDS:0] o;
	logic [`LICMDS:0] liop;
	rega rega(arad, brad, a, b, we, wad, rwd, clk, rst);
	sel asel(a, {{(`WIDTH-`PCS){1'b0}},pca}, pcs, ao);
	lidx lidx(b, iv, liop, bo);
	alu alu(ao, bo, op, lp, dstb, ze, ca, sg, clk, rst);
	pc pc(h, pca, pcwe, rwd[`PCS:0], clk, rst);
	imem imem(pca, o);
	dec dec(o, h, we, wad, op, brad, arad, liop, iv,
		pcwe, dmwe, dms, pcs, dstb, ze, ca, sg);
	dmem dmem(lp[`DMSB:0], b, dmwe, mrd, clk);
	sel dsel(lp, mrd, dms, rwd);
endmodule

