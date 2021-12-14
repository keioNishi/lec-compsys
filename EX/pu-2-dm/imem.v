`include "pu.vh"
module imem(input [`PCS:0] pc, output logic [`CMDS:0] o);
	always_comb
		case(pc)
		// synopsys full_case parallel_case
		5'h00: o = 16'b0100_0000_1010_1001; // LIL r0, r0, 8'b10101001
		5'h01: o = 16'b0101_0000_0000_0100; // LIH r0, r0, 8'b00000100
		5'h02: o = 16'b0100_0101_0101_0110; // LIL r1, r1, 8'b01010110
		5'h03: o = 16'b0101_0101_0000_0100; // LIH r1, r1, 8'b00000100
		5'h04: o = 16'b0000_1000_0000_0101; // add r2=r0,r1
		5'h05: o = 16'b0100_1111_0000_0001; // LIL r3, r3, 8'b00000001
		5'h06: o = 16'b0101_1111_0000_0000; // LIH r3, r3, 8'b00000000
		5'h07: o = 16'b1010_0011_0000_0001; // SM [r3 + 00000001]=r0
		5'h08: o = 16'b0100_1111_0000_0000; // LIL r3, r3, 8'b00000000
		5'h09: o = 16'b0101_1111_0000_0000; // LIH r3, r3, 8'b00000000
		5'h0a: o = 16'b1000_0111_0000_0010; // LM r1=[r3 + 00000010]
		5'h0b: o = 16'b0000_0000_0000_0001; // HALT
		endcase
endmodule

/*
F E D C B A 9 8 7 6 5 4 3 2 1 0
0 0 0 0 * * * * * * * * * 0 * 0 ; NOP
0 0 0 0 * * * * * * * * * 0 * 1 ; HALT
0 0 0 0 rw> a-> * op -> * 1 b-> ; CAL rw=ra,rb
0 0 0 1 rw> a-> * op -> * 1 b-> ; LM rw=[ra op rb]
0 0 1 o rw> a-> im------------> ; CAL rw=ra,im
0 1 0 0 rw> a-> im------------> ; LIL rw=ra,im
0 1 0 1 rw> a-> im------------> ; LIH rw=ra,im
1 0 0 o rw> a-> im------------> ; LM rw=[ra o im] o=0:ADD/1:SUB
1 0 1 o b-> a-> im------------> ; SM [ra o im]=rb
*/
