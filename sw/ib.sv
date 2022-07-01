`include "sw.vh"
module ib(input [`PKTW:0] pkti, output [`PKTW:0] pkto, output [`PORT:0] req, input ack,
	output full, input clk, rst);
	logic [`PORT:0] reqi;
	mkwe mkwe(pkti, we);
	fifo fifo(pkti, we, full, pkto, re, empty, clk, rst);
	isbm isbm(pkto[`FLOWBH:`FLOWBL], re, empty, reqi, req, ack, clk, rst);
	mkreq mkreq(pkto, reqi, clk, rst);
endmodule

