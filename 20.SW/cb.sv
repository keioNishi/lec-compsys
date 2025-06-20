`include "sw.vh"
module cb(input [`PKTW:0] i0, i1, i2, i3, output [`PKTW:0] o0, o1, o2, o3, input [`PORT:0] d0, d1, d2, d3);
	cbsel cbsel0(i0, i1, i2, i3, o0, d0);
	cbsel cbsel1(i0, i1, i2, i3, o1, d1);
	cbsel cbsel2(i0, i1, i2, i3, o2, d2);
	cbsel cbsel3(i0, i1, i2, i3, o3, d3);
endmodule
