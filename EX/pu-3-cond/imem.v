`include "pu.vh"
module imem(input [`PCS:0] pc, output logic [`CMDS:0] o);
	always_comb
		case(pc)
		// synopsys full_case parallel_case
		5'h00: o = 16'b0000_0000_0000_0000; // NOP check
		5'h01: o = 16'b1000_0010_0101_0110; // LIL r0, 01010110
		5'h02: o = 16'b1000_0011_1010_1001; // LIH r0, 10101001
		5'h03: o = 16'b1000_0110_1010_1001; // LIL r1, 10101001
		5'h04: o = 16'b1000_0111_0101_0110; // LIH r1, 01010110
// get r0 <- r0 or r1
		5'h05: o = 16'b0000_1000_0110_0000; // NAD r0=r0,r0
		5'h06: o = 16'b0000_1001_0110_0101; // NAD r1=r1,r1
		5'h07: o = 16'b0000_1000_0110_0001; // NAD r0=r0,r1
// make another all 1
		7'h08: o = 16'b1000_0101_1111_1111; // LI  r1, 11111111
		5'h09: o = 16'b1000_1001_0000_0111; // LI  r2, 7
		5'h0a: o = 16'b0000_1001_0101_0110; // RSL r1=r1,r2
		5'h0b: o = 16'b0010_0101_0111_1111; // ADD r1=r1,01111111
		5'h0c: o = 16'b0000_1100_0001_0001; // CMP r0,r1
		5'h0d: o = 16'b0101_1101_0000_0010; // BR PZ [PC+2]
		5'h0e: o = 16'b0000_0000_0000_0001; // HALT
		5'h0f: o = 16'b0000_1001_0010_0001; // MV r1, r1
		5'h10: o = 16'b0101_1111_0000_0010; // BR PS [PC+2]
		5'h11: o = 16'b0000_0000_0000_0001; // HALT
		5'h12: o = 16'b0010_0100_0000_0001; // ADD r1=r0,1
		5'h13: o = 16'b0101_1101_0000_0010; // BR PC [PC+2]
		5'h14: o = 16'b0000_0000_0000_0001; // HALT
		5'h15: o = 16'b0000_1001_0010_0001; // MV r2, r2
		5'h16: o = 16'b0100_1101_0000_0010; // BR NZ [PC+2]
		5'h17: o = 16'b0101_1100_0000_0010; // BR PC [PC+2]
		5'h18: o = 16'b0000_0000_0000_0001; // HALT
		5'h19: o = 16'b0101_1000_0000_0001; // SM [1]=r0
		5'h1a: o = 16'b1001_1100_0000_0001; // LM r3=[1]
		5'h1b: o = 16'b0000_0000_0000_0001; // HALT
		5'h1c: o = 16'b0000_0000_0000_0000; // NOP
		endcase
endmodule

/*
// F E D C B A 9 8 7 6 5 4 3 2 1 0
// 0 0 0 0 0 0 * * * * * * * * * 0 ; NOP (0) DSTB
// 0 0 0 0 0 0 * * * * * * * * * 1 ; HALT (1)
// 0 0 0 0 0 1 * * * * * * * * * * ; future reserved (PUSH, POP, SET(reg))
// 0 0 0 0 1 0 rw> F op--> a-> b-> ; CAL rw=ra,rb (F=0:NORM/1:DSTB) MV
// 0 0 0 0 1 1 * * * op--> a-> b-> ; EVA CAL ra,rb (F=0)/CMP ra,rb
// 0 0 0 1 0 0 f f p op--> a-> b-> ; JP/BR pf [ra op rb] (ff:NC,Z,C,S)
// 0 0 0 1 0 1 * * * * * * * * * * ; future reserved
// 0 0 0 1 1 0 F * * op--> a-> b-> ; SM [ra]=rb / SM [ra] = [ra op rb] *MM
// 0 0 0 1 1 1 rw> F op--> a-> b-> ; LM rw=[ra op rb] / LM rw=[rb] *MM
// 0 0 1 # rw> a-> im------------> ; CAL rw=ra,im (#=0:ADD/1:SUB only)
// 0 1 0 p 0 * f f im------------> ; JP/BR pf [(s)im]
// 0 1 0 * 1 0 b-> im------------> ; SM [(s)im]=rb *MM
// 0 1 0 p 1 1 f f im------------> ; JP/BR fp [PC + (s)im]
// 0 1 1 p a-> f f im------------> ; JP/BR fp [ra + (s)im]
// 1 0 0 0 rw> 0 0 0 0 0 0 0 S C Z ; LI rw,SM S:sign C:carry Z:zero
// 1 0 0 0 rw> 0 1 im------------> ; LI rw,(s)im (rw=rb) lidx=o[9:8]
// 1 0 0 0 rw> 1 0 im------------> ; LIL rw,im (rw=rb)
// 1 0 0 0 rw> 1 1 im------------> ; LIH rw,im (rw=rb)
// 1 0 0 1 rw> * * im------------> ; LM rw=[im] *MM
// 1 0 1 0 rw> a-> im------------> ; LM rw=[ra + (s)im]
// 1 0 1 1 a-> b-> im------------> ; SM [ra + (s)im]=rb
// 1 1 0 * * * * * * * * * * * * * ; future reserved *MM
// 1 1 1 * * * * * * * * * * * * * ; future reserved *MM (debug)
//
// ALU  000:ADD, 001:SUB, 010:THB, 011:ASR,
//      100:RSL, 101:RSL, 110:NAD, 111:XOR
//
// COND(ff) 00:UC 01:ZE 10:CA 11:SG
// P/N (p)  0:N(!=) 1:P(==)
//
// EX: Positive Zero => PZ
//
// SPECIALS
// F E D C B A 9 8 7 6 5 4 3 2 1 0
// 0 0 0 0 1 0 rw> 0 0 1 0 0 0 b-> ; MV rw=rb
// 1 0 0 0 rw> 0 1 0 0 0 0 0 0 0 0 ; RESET rw (LI rw=0)
// 0 0 1 0 rw> rw> 0 0 0 0 0 0 0 1 ; INC rw
// 0 0 1 1 rw> rw> 0 0 0 0 0 0 0 1 ; DEC rw
// 0 0 1 0 rw> ra> 0 0 0 0 0 0 0 1 ; INC rw=ra (rw = ra+1)
// 0 0 1 1 rw> ra> 0 0 0 0 0 0 0 1 ; DEC rw=ra (rw = ra-1)
// 0 0 0 0 1 1 * * * 0 0 1 a-> b-> ; CMP ra,rb (EVA SUB ra,rb)
*/
