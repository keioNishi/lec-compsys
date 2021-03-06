module imem(input [5:0] pc, output [15:0] o);
	logic [15:0] o;
	always_comb
		case(pc)
		// synopsys full_case parallel_case
		6'h00: o = 16'b0000_00_00_00000000; // NOP
		6'h01: o = 16'b0101_00_00_00000000; // LIH
		6'h02: o = 16'b0100_00_00_00000000; // LIL
		6'h03: o = 16'b0101_01_01_00000000; // LIH
		6'h04: o = 16'b0100_01_01_00000001; // LIL
		6'h05: o = 16'b0001_00_10_0000_01_00; // r2 <- r1 + r0
		6'h06: o = 16'b0001_00_00_1111_01_01; // r0 <- r1
		6'h07: o = 16'b0001_00_01_1111_10_10; // r1 <- r2
		6'h08: o = 16'b0001_00_10_0000_01_00; // r2 <- r1 + r0
		6'h09: o = 16'b0001_00_00_1111_01_01; // r0 <- r1
		6'h0a: o = 16'b0001_00_01_1111_10_10; // r1 <- r2
		6'h0b: o = 16'b0001_00_10_0000_01_00; // r2 <- r1 + r0
		6'h0c: o = 16'b0001_00_00_1111_01_01; // r0 <- r1
		6'h0d: o = 16'b0001_00_01_1111_10_10; // r1 <- r2
		6'h0e: o = 16'b0001_00_10_0000_01_00; // r2 <- r1 + r0
		6'h0f: o = 16'b0001_00_00_1111_01_01; // r0 <- r1
		6'h10: o = 16'b0001_00_01_1111_10_10; // r1 <- r2
		6'h11: o = 16'b0001_00_10_0000_01_00; // r2 <- r1 + r0
		6'h12: o = 16'b0001_00_00_1111_01_01; // r0 <- r1
		6'h13: o = 16'b0001_00_01_1111_10_10; // r1 <- r2
		6'h14: o = 16'b0001_00_10_0000_01_00; // r2 <- r1 + r0
		6'h15: o = 16'b0001_00_00_1111_01_01; // r0 <- r1
		6'h16: o = 16'b0001_00_01_1111_10_10; // r1 <- r2
		6'h17: o = 16'b0001_00_10_0000_01_00; // r2 <- r1 + r0
		6'h18: o = 16'b0001_00_00_1111_01_01; // r0 <- r1
		6'h19: o = 16'b0001_00_01_1111_10_10; // r1 <- r2
		6'h1a: o = 16'b0001_00_10_0000_01_00; // r2 <- r1 + r0
		6'h1b: o = 16'b0001_00_00_1111_01_01; // r0 <- r1
		6'h1c: o = 16'b0001_00_01_1111_10_10; // r1 <- r2
		6'h1d: o = 16'b0001_00_10_0000_01_00; // r2 <- r1 + r0
		6'h1e: o = 16'b0001_00_00_1111_01_01; // r0 <- r1
		6'h1f: o = 16'b0001_00_01_1111_10_10; // r1 <- r2
		6'h20: o = 16'b0001_00_10_0000_01_00; // r2 <- r1 + r0
		6'h21: o = 16'b0001_00_00_1111_01_01; // r0 <- r1
		6'h22: o = 16'b0001_00_01_1111_10_10; // r1 <- r2
		6'h23: o = 16'b0001_00_10_0000_01_00; // r2 <- r1 + r0
		6'h24: o = 16'b0001_00_00_1111_01_01; // r0 <- r1
		6'h25: o = 16'b0001_00_01_1111_10_10; // r1 <- r2
		6'h26: o = 16'b0001_00_10_0000_01_00; // r2 <- r1 + r0
		6'h27: o = 16'b0001_00_00_1111_01_01; // r0 <- r1
		6'h28: o = 16'b0001_00_01_1111_10_10; // r1 <- r2
		6'h29: o = 16'b0000_00_00_00000001; // NOP
		default: o = 16'b0;
		endcase
endmodule

/*
F E D C B A 9 8 7 6 5 4 3 2 1 0
0 0 0 0 * * * * * * * * * * * 0 ; NOP
0 0 0 0 * * * * * * * * * * * 1 ; HALT
0 0 0 1 * * rw> op----> a-> b-> ; CAL rw=ra,rb
0 0 1 0 * * rw> im------------> ; LI rw,(s)im
0 1 0 0 rw> b-> im------------> ; LIL rw,rb,im
0 1 0 1 rw> b-> im------------> ; LIH rw,rb,im
1 0 0 oprw> a-> im------------> ; CAL rw=ra,im (#=0:ADD/1:SUB only)
*/
