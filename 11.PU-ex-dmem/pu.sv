`include "pu.vh"
module pu( // Processing Unit
	output we,
	output [`WIDTH:0] rwd,
	input clk, rst);
	logic [`WIDTH:0] a2alu, b2alu, b2imx, loop, dmrd;
	logic [`HALFWIDTH:0] iv;
	logic [`RASB:0] arad, brad, wad;
	logic [`ALUOPS:0] op;
	logic [`PCS:0] pca;
	logic [`CMDS:0] o;
	logic [`IMXOPS:0] liop;
	ra ra(arad, brad, a2alu, b2imx, we, wad, rwd, clk, rst);
	imx imx(b2imx, iv, liop, b2alu);
	alu alu(a2alu, b2alu, op, loop);
	pc pc(h, pca, clk, rst);
	imem imem(pca, o);
	dec dec(o, h, we, wad, op, brad, arad, liop, iv, dmwe, dms);
	dmem dmem(loop[`DMSB:0], b2imx, dmwe, dmrd, clk);
	sel dsel(loop, dmrd, dms, rwd);
endmodule

