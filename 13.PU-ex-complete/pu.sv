`include "pu.vh"
module pu( // Processing Unit
	output we,
	output [`WIDTH:0] rwd,
	input clk, rst);
	logic [`WIDTH:0] a2sel, b2alu, a2alu, b2imx, loop, dmrd, dmad, dmdt, spo;
	logic [`HALFWIDTH:0] iv;
	logic [`RASB:0] arad, brad, wad;
	logic [`ALUOPS:0] op;
	logic [`PCS:0] pca;
	logic [`CMDS:0] o;
	logic [`IMXOPS:0] liop;
	logic [`PCSS:0] pcs;
	ra ra(arad, brad, a2sel, b2imx, we, wad, rwd, clk, rst);
	sp sp(spo, spwe, loop, clk, rst);
	sel3 pcx(a2sel, {{(`WIDTH-`PCS){1'b0}},pca}, spo, pcs, a2alu);
	imx imx(b2imx, iv, liop, b2alu);
	alu alu(a2alu, b2alu, op, loop, dstb,
		ze, ca, sg, b2alu[0], b2alu[1], b2alu[2], swe, clk, rst);
	pc pc(h, pca, pcwe, rwd[`PCS:0], clk, rst);
	imem imem(pca, o);
	dec dec(o, h, we, wad, op, brad, arad, liop, iv,
		pcwe, dmwe, dms, pcs, dstb, ze, ca, sg, swe, ads, ats, spwe);
	sel adx(loop, a2alu, ads, dmad);
	sel atx(b2imx, {{(`WIDTH-`PCS){1'b0}},pca}, ats, dmdt);
	dmem dmem(dmad[`DMSB:0], dmdt, dmwe, dmrd, clk);
	sel dsel(loop, dmrd, dms, rwd);
endmodule

