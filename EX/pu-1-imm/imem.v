`include "pu.vh"
module imem(input [`PCS:0] pc, output logic [`CMDS:0] o);
	always_comb
		case(pc)
		// synopsys full_case parallel_case
		5'h00: o = 16'b0100_0000_1010_1001; // LIL r0, r0, 8'b10101001
		5'h01: o = 16'b0101_0000_0000_0100; // LIH r0, r0, 8'b00000100
		5'h02: o = 16'b0100_0101_0101_0110; // LIL r1, r1, 8'b01010110
		5'h03: o = 16'b0101_0101_0000_0100; // LIL r1, r1, 8'b00000100
		5'h04: o = 16'b0000_1000_0000_0101; // add r2=r0,r1
		5'h05: o = 16'b0000_0000_0000_0000; // NOP
		5'h06: o = 16'b0000_0000_0000_0001; // HALT
		endcase
endmodule

/*
F E D C B A 9 8 7 6 5 4 3 2 1 0
0 0 0 * * * * * * * * * * 0 * 0 ; NOP
0 0 0 * * * * * * * * * * 0 * 1 ; HALT
0 0 0 * rw> a-> * op -> * 1 b-> ; CAL rw=ra,rb
0 0 1 o rw> a-> im------------> ; CAL rw=ra,im
0 1 0 0 rw> a-> im------------> ; LIL rb,im
0 1 0 1 rw> a-> im------------> ; LIH rb,im
*/
