`include "pu.vh"
module pu(output we, output logic [`WIDTH:0] wd, input clk, rst);
	logic [`WIDTH:0] a, b, bo;
	logic [`HALFWIDTH:0] iv;
	logic [`RASB:0] arad, brad, wad;
	logic [`OPS:0] op;
	logic [`PCS:0] pca;
	logic [`CMDS:0] o;
	logic [`LICMDS:0] liop;
	rega rega(arad, brad, a, b, we, wad, wd, clk, rst);
	lidx lidx(b, iv, liop, bo);
	alu alu(a, bo, op, wd);
	pc pc(h, pca, clk, rst);
	imem imem(pca, o);
	dec dec(o, h, we, wad, op, brad, arad, liop, iv);
endmodule
