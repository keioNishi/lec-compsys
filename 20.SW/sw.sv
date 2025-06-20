`include "sw.vh"
module sw(input [`PKTW:0] i0, i1, i2, i3, output [`PKTW:0] o0, o1, o2, o3, input clk, rst);
	logic [`PKTW:0] co0, co1, co2, co3;
	logic [`PORT:0] req0, req1, req2, req3;
	ib ib0(i0, co0, req0, ack0, full0, clk, rst);
	ib ib1(i1, co1, req1, ack1, full1, clk, rst);
	ib ib2(i2, co2, req2, ack2, full2, clk, rst);
	ib ib3(i3, co3, req3, ack3, full3, clk, rst);
	ackor ackor0(ack00, ack10, ack20, ack30, ack0);
	ackor ackor1(ack01, ack11, ack21, ack31, ack1);
	ackor ackor2(ack02, ack12, ack22, ack32, ack2);
	ackor ackor3(ack03, ack13, ack23, ack33, ack3);
	arb arb0(req0[0], req1[0], req2[0], req3[0], ack00, ack01, ack02, ack03, clk, rst);
	arb arb1(req0[1], req1[1], req2[1], req3[1], ack10, ack11, ack12, ack13, clk, rst);
	arb arb2(req0[2], req1[2], req2[2], req3[2], ack20, ack21, ack22, ack23, clk, rst);
	arb arb3(req0[3], req1[3], req2[3], req3[3], ack30, ack31, ack32, ack33, clk, rst);
	cb cb(co0, co1, co2, co3, o0, o1, o2, o3,
		{ack03, ack02, ack01, ack00}, {ack13, ack12, ack11, ack10},
		{ack23, ack22, ack21, ack20}, {ack33, ack32, ack31, ack30});
endmodule

