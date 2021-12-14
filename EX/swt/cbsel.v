`include "sw.vh"
module cbsel(input [`PKTW:0] i0, i1, i2, i3, output logic [`PKTW:0] o, input [`PORT:0] d);
	always_comb begin
		case(1)
		// parallel_case
		d[0]: o = i0;
		d[1]: o = i1;
		d[2]: o = i2;
		d[3]: o = i3;
		default: o = 0;
		endcase
	end
endmodule
