`include "pu.vh"
module imem(
	input [`PCS:0] pc,
	output logic [`CMDS:0] o);
	always_comb
		case(pc)
		// synopsys full_case parallel_case
		8'h00: o = 16'b0000_00_00_0_000_00_00; // NOP
		8'h01: o = 16'b0100_00_00_1010_1001; // LIL r0, r0, 8'b10101001
		8'h02: o = 16'b0101_00_00_0000_0100; // LIH r0, r0, 8'b00000100
		8'h03: o = 16'b0100_01_01_0101_0110; // LIL r1, r1, 8'b01010110
		8'h04: o = 16'b0101_01_01_0000_0100; // LIH r1, r1, 8'b00000100
		8'h05: o = 16'b0010_00_10_0000_00_01; // ADD r2 := r0, r1 -> 08FF
		8'h06: o = 16'b0100_11_11_0000_0001; // LIL r3, r3, 8'b00000001
		8'h07: o = 16'b0101_11_11_0000_0000; // LIH r3, r3, 8'b00000000
		8'h08: o = 16'b1001_11_10_0000_0001; // SM [r3 + 00000001]=r2 write 8ff
		8'h09: o = 16'b0100_11_11_0000_0000; // LIL r3, r3, 8'b00000000
		8'h0a: o = 16'b0101_11_11_0000_0000; // LIH r3, r3, 8'b00000000
		8'h0b: o = 16'b1011_01_11_0000_0010; // LM r1=[r3 + 00000010] read 8ff
		8'h0c: o = 16'b0000_00_00_0000_0001; // HALT
		default: o = 16'b0;
		endcase
endmodule

/*
F E D C B A 9 8 7 6 5 4 3 2 1 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ; NOP (0) DSTB
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 ; HALT (1)
0 0 0 0 0 1 rw> im------------> ; LI rw,(s)im
0 0 0 0 1 0 b-> im------------> ; SM [(s)im]=rb
0 0 1 0 0 0 rw> op----> a-> b-> ; CAL rw=ra,rb
0 1 0 0 rw> b-> im------------> ; LIL rw,rb,im
0 1 0 1 rw> b-> im------------> ; LIH rw,rb,im
0 1 1 0 0 0 1 0 op----> a-> b-> ; SM [ra]=rb / SM [ra] = [ra op rb]
1 0 0 0 0 0 rw> im------------> ; LM rw=[im]
1 0 0 1 a-> b-> im------------> ; SM [ra + (s)im]=rb
1 0 1 0 rw> F 0 op----> a-> b-> ; LM rw=[ra op rb]
1 0 1 1 rw> a-> im------------> ; LM rw=[ra + (s)im]
1 1 0 # rw> a-> im------------> ; CAL rw=ra,im (#=0:ADD/1:SUB only)

ADD 4'b0000 SUB 4'b0001 ASR 4'b0010 RSR 4'b0011
RSL 4'b0100 BST 4'b0101 BRT 4'b0110 BTS 4'b0111
AND 4'b1000 OR  4'b1001 NAD 4'b1010 XOR 4'b1011
MUL 4'b1100 EXT 4'b1101 THA 4'b1110 THB 4'b1111

IMS
LIL 2'b00 LIH 2'b01 IMM 2'b10 THU 2'b11
*/
