`include "pu.vh"
`define DEBUG
//`define DEBUG2

`define UC 2'b00
`define ZE 2'b01
`define CA 2'b10
`define SG 2'b11

module dec( // Decoder
	input [`CMDS:0] o,
	output logic h, we,
	output logic [`RASB:0] wad,
	output logic [`ALUOPS:0] op,
	output logic [`RASB:0] rb, ra,
	output logic [`IMXOPS:0] liop,
	output logic [`HALFWIDTH:0] iv,
	output logic pcwe, dmwe, dms,
	output logic [`PCSS:0] pcs,
	output logic dstb,
	input ze, ca, sg,
	output logic swe, ads, ats, spwe);
/*

F E D C B A 9 8 7 6 5 4 3 2 1 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 * 0 ; NOP (0)
0 0 0 0 0 0 0 0 0 0 0 0 0 0 * 1 ; HALT (1)
0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 F ; RET PC (op = 000, ADD)
0 0 0 0 0 0 0 0 0 0 0 0 1 F b-> ; POP rb (op = 000, ADD)
0 0 0 0 0 0 0 0 0 0 0 1 0 F b-> ; CALL rb (op = 100, SUB)
0 0 0 0 0 0 0 0 0 0 0 1 1 F b-> ; PUSH rb (op = 100, SUB)
0 0 0 0 0 0 0 0 0 0 1 0 0 0 b-> ; MV rb, sp
0 0 0 0 0 0 0 0 0 0 1 0 0 1 * * ; future reserved
0 0 0 0 0 0 0 0 0 0 1 0 1 * * * ; future reserved
0 0 0 0 0 0 0 0 0 0 1 1 * * * * ; future reserved
0 0 0 0 0 0 0 0 0 1 * * * * * * ; future reserved
0 0 0 0 0 0 0 1 op----> a-> b-> ; EVA CAL ra,rb (F=0)/CMP ra,rb
0 0 0 0 0 0 1 * * * * * * * * * ; future reserved
0 0 0 0 0 1 rw> im------------> ; LI rw,(s)im
0 0 0 0 1 0 b-> im------------> ; SM [(s)im]=rb
0 0 0 0 1 1 0(p f f)op----> a-> ; JP/BR pf [PC op ra]
0 0 0 0 1 1 1(p f f)op----> a-> ; JP/BR pf [SP op ra]
0 0 0 1 0(p f f)op----> a-> b-> ; JP/BR pf [ra op rb]
0 0 0 1 1(p f f)im------------> ; JP/BR pf [(s)im]
0 0 1 0 0(p f f)im------------> ; JP/BR pf [PC + (s)im]
0 0 1 0 1 F rw> op----> a-> b-> ; CAL rw=ra,rb (F=0:NORM/1:DSTB) MV
0 0 1 1 * * * * * * * * * * * * ; future reserved
0 1 0 0 rw> b-> im------------> ; LIL rw,rb,im
0 1 0 1 rw> b-> im------------> ; LIH rw,rb,im
0 1 1 0 rw> 0 0 F 0 0 0 0 S C Z ; LI rw,SR S:sign C:carry Z:zero
0 1 1 0 rw> 1 0 F 0 0 0 0 S C Z ; MV SR,rb S:sign C:carry Z:zero
0 1 1 0 * * 1 1 F 0 0 0 0 S C Z ; LI SR,im S:sign C:carry Z:zero
0 1 1 0 * * 0 1 * * * * * * * * ; future reserved
0 1 1 0 0 0 1 F op----> a-> b-> ; SM [ra]=rb / SM [ra] = [ra op rb]
0 1 1 0 0 1 1 * * * * * * * * * ; future reserved
0 1 1 0 1 * 1 * * * * * * * * * ; future reserved
0 1 1 1 0 p f f im------------> ; JP/BR pf [PC op im]
0 1 1 1 1 p f f im------------> ; JP/BR pf [SP op im]
1 0 0 0 0 0 rw> im------------> ; LM rw=[im]
1 0 0 0 0 1 * * * * * * * * * * ; future reserved
1 0 0 0 1 * * * * * * * * * * * ; future reserved
1 0 0 1 a-> b-> im------------> ; SM [ra + (s)im]=rb
1 0 1 0 rw> F 0 op----> a-> b-> ; LM rw=[ra op rb]
1 0 1 0 * * * 1 * * * * * * * * ; future reserved
1 0 1 1 rw> a-> im------------> ; LM rw=[ra + (s)im]
1 1 0 # rw> a-> im------------> ; CAL rw=ra,im (#=0:ADD/1:SUB only)
1 1 1 a->(p f f)im------------> ; JP/BR pf [ra + (s)im]


F E D C B A 9 8 7 6 5 4 3 2 1 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ; NOP (0) DSTB
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 ; HALT (1)
0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 F ; RET PC (op = 000, ADD)
0 0 0 0 0 0 0 0 0 0 0 0 1 F b-> ; POP rb (op = 000, ADD)
0 0 0 0 0 0 0 0 0 0 0 1 0 F b-> ; CALL rb (op = 100, SUB)
0 0 0 0 0 0 0 0 0 0 0 1 1 F b-> ; PUSH rb (op = 100, SUB)
0 0 0 0 0 0 0 0 0 0 1 0 0 0 b-> ; MV rb, sp
0 0 0 0 0 0 0 1 op----> a-> b-> ; EVA CAL ra,rb (F=0)/CMP ra,rb
0 0 0 0 0 1 rw> im------------> ; LI rw,(s)im
0 0 0 0 1 0 b-> im------------> ; SM [(s)im]=rb
0 0 0 0 1 1 0(p f f)op----> a-> ; JP/BR pf [PC op ra]
0 0 0 0 1 1 1(p f f)op----> a-> ; JP/BR pf [SP op ra]
0 0 0 1 0(p f f)op----> a-> b-> ; JP/BR pf [ra op rb]
0 0 0 1 1(p f f)im------------> ; JP/BR pf [(s)im]
0 0 1 0 0(p f f)im------------> ; JP/BR pf [PC + (s)im]
0 0 1 0 1 F rw> op----> a-> b-> ; CAL rw=ra,rb (F=0:NORM/1:DSTB) MV
0 1 0 0 rw> b-> im------------> ; LIL rw,rb,im
0 1 0 1 rw> b-> im------------> ; LIH rw,rb,im
0 1 1 0 rw> 0 0 0 0 0 0 0 S C Z ; LI rw,SR S:sign C:carry Z:zero
0 1 1 0 rw> 1 0 0 0 0 0 0 S C Z ; MV SR,rb S:sign C:carry Z:zero
0 1 1 0 * * 1 1 0 0 0 0 0 S C Z ; LI SR,im S:sign C:carry Z:zero
0 1 1 0 0 0 1 F op----> a-> b-> ; SM [ra]=rb / SM [ra] = [ra op rb]
0 1 1 1 0 p f f im------------> ; JP/BR pf [PC op im]
0 1 1 1 1 p f f im------------> ; JP/BR pf [SP op im]
1 0 0 0 0 0 rw> im------------> ; LM rw=[im]
1 0 0 1 a-> b-> im------------> ; SM [ra + (s)im]=rb
1 0 1 0 rw> F 0 op----> a-> b-> ; LM rw=[ra op rb]
1 0 1 1 rw> a-> im------------> ; LM rw=[ra + (s)im]
1 1 0 # rw> a-> im------------> ; CAL rw=ra,im (#=0:ADD/1:SUB only)
1 1 1 a->(p f f)im------------> ; JP/BR pf [ra + (s)im]

F E D C B A 9 8 7 6 5 4 3 2 1 0
0 0 1 0 0 F rw> 1 1 1 1 0 0 b-> ; MV rw=rb
0 0 0 0 1 0 rw> 0 0 0 0 0 0 0 0 ; RESET rw (LI rw=0)
0 0 0 0 0 0 1 0 0 0 0 1 a-> b-> ; CMP ra,rb (EVA SUB ra,rb)
1 1 0 0 rw> rw> 0 0 0 0 0 0 0 1 ; INC rw
1 1 0 1 rw> rw> 0 0 0 0 0 0 0 1 ; DEC rw
1 1 0 0 rw> ra> 0 0 0 0 0 0 0 1 ; INC rw=ra (rw = ra+1)
1 1 0 1 rw> ra> 0 0 0 0 0 0 0 1 ; DEC rw=ra (rw = ra-1)
0 1 1 0 0 0 1 F 1 1 1 1 a-> b-> ; SM [ra]=rb F
1 0 0 1 a-> b-> 0 0 0 0 0 0 0 0 ; SM [ra]=rb
1 0 1 1 rw> a-> 0 0 0 0 0 0 0 0 ; LM rw=[ra]

ADD 4'b0000 SUB 4'b0001 ASR 4'b0010 RSR 4'b0011
RSL 4'b0100 BST 4'b0101 BRT 4'b0110 BTS 4'b0111
AND 4'b1000 OR  4'b1001 NAD 4'b1010 XOR 4'b1011
MUL 4'b1100 EXT 4'b1101 THA 4'b1110 THB 4'b1111

IMS
LIL 2'b00 LIH 2'b01 IMM 2'b10 THU 2'b11

COND(ALU)
UC 2'b00 ZE 2'b01 CA 2'b10 SG 2'b11

pf
P/N (p) 0::N(!=) 1:P(==)
ex) Positive Zero -> PZ

F=0:NORM/1:DSTB

*/

	logic pf;
	always @* begin
		pf = `NEGATE;
		case(o[9:8])
		// synopsys full_case parallel_case
		`UC: begin
			pf = `ASSERT;
		end
		`ZE: begin
			pf = ~ze^o[10];
		end
		`CA: begin
			pf = ~ca^o[10];
		end
		`SG: begin
			pf = ~sg^o[10];
		end
		endcase
	end
	always_comb begin
		h = `NEGATE;
		ra = 0;
		rb = 0;
		op = `THB;
		we = `NEGATE;
		wad = 0;
		liop = `THU;
		iv = 0;
		dstb = `NEGATE;
		pcwe = `NEGATE;
		dmwe = `NEGATE;
		dms = `NEGATE;
		pcs = `SELRA;
		swe = `NEGATE;
		ads = `NEGATE;
		ats = `NEGATE;
		spwe = `NEGATE;
`ifdef DEBUG
$display("*****PC[%h]we[%h]CODE:%h", test.pu.pc.pc, pcwe, o);
$display("r0[%h]1[%h]2[%h]3[%h]", test.pu.ra.rega[0], test.pu.ra.rega[1],
	test.pu.ra.rega[2], test.pu.ra.rega[3]);
`endif
		casex(o)
		// synopsys full_case parallel_case
		16'b0000_0000_0000_00x0: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 0 0 0 0 0 0 0 0 0 0 0 * 0 ; NOP DSTB
			dstb = `ASSERT;
`ifdef DEBUG
	$display("NOP");
`endif
		end
		16'b0000_0000_0000_00x1: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 0 0 0 0 0 0 0 0 0 0 0 * 1 ; HALT
			h = `ASSERT;
`ifdef DEBUG
	$display("HALT");
`endif
		end
		16'b0000_0000_0000_011x: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 F ; RET PC (op = 000, ADD)
//
//
//
//
//
//
`ifdef DEBUG
	$display("RET PC [ra:%h] DSTB:%h", ra, dstb);
`endif
		end
		16'b0000_0000_0000_1xxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 0 0 0 0 0 0 0 0 0 1 F b-> ; POP rb (op = 000, ADD)
//
//
//
//
//
//
`ifdef DEBUG
	$display("POP rb:%h [ra:%h] DSTB:%h", rb, ra, dstb);
`endif
		end
		16'b0000_0000_0001_0xxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 0 0 0 0 0 0 0 0 1 0 F b-> ; CALL rb (op = 100, SUB)
//
//
//
//
//
//
`ifdef DEBUG
	$display("CALL PC [ra:%h] DSTB:%h", ra, dstb);
`endif
		end
		16'b0000_0000_0001_1xxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 0 0 0 0 0 0 0 0 1 1 F b-> ; PUSH rb (op = 100, SUB)
//
//
//
//
//
//
`ifdef DEBUG
	$display("PUSH rb:%h [ra:%h] DSTB:%h", rb, ra, dstb);
`endif
		end
		16'b0000_0000_0010_00xx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 0 0 0 0 0 0 0 1 0 0 0 b-> ; MV rb, sp
			op = `THB;
			rb = o[1:0];
			spwe = `ASSERT;
		end
		16'b0000_0001_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 0 0 0 1 0 op----> a-> b-> ; EVA CAL ra,rb (F=0)/CMP ra,rb
			op = o[7:4];
			ra = o[3:2];
			rb = o[1:0];
`ifdef DEBUG
	$display("EVA CAL op:%h, ra:%h, rb:%h (F=0)/CMP, ra, rb", op, ra, rb);
`endif
		end
		16'b0000_01xx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 0 0 1 rw> im------------> ; LI rw,(s)im
			wad = o[9:8];
			we = `ASSERT;
			iv = o[`HALFWIDTH:0];
			liop = `IMM;
`ifdef DEBUG
	$display("LI wr:%h (s)im:%h // liop:%h", wad, iv, liop);
`endif
		end
		16'b0000_10xx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 0 1 0 b-> im------------> ; SM [(s)im]=rb
//
//
//
//
//
//
`ifdef DEBUG
	$display("SM [(s)im:%h]=rb:%h", iv, rb);
`endif
		end
		16'b0000_110x_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 0 1 1 0(p f f)op----> a-> ; JP/BR pf [PC op ra]
		end
		16'b0000_111x_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 0 1 1 1(p f f)op----> a-> ; JP/BR pf [SP op ra]
		end
		16'b0001_0xxx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 1 0 p f f op----> a-> b-> ; JP/BR pf [ra op rb]
			if(pf == `ASSERT) begin
//
//
//
//
//
//
			end
`ifdef DEBUG
	$display("JP/BR pf:%h(Z%hC%hS%h) [ra:%h op:%h rb:%h]", pf, ze, ca, sg, ra, op, rb);
`endif
		end
		16'b0001_1xxx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 1 1(p f f)im------------> ; JP/BR pf [(s)im]
			if(pf == `ASSERT) begin
//
//
//
//
//
//
			end
`ifdef DEBUG
	$display("JP/BR pf:%h(Z%hC%hS%h) [liop:%h, (s)IM:%h]", pf, ze, ca, sg, liop, iv);
`endif
		end
		16'b0010_0xxx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 1 0 0(p f f)im------------> ; JP/BR pf [PC + (s)im]
			if(pf == `ASSERT) begin
//
//
//
//
//
//
			end
`ifdef DEBUG
	$display("JP/BR pf:%h(Z%hC%hS%h) [PC + liop:%h, (s)IM:%h]", pf, ze, ca, sg, liop, iv);
`endif
		end
		16'b0010_1xxx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 1 0 1 F rw> op----> a-> b-> ; CAL rw=ra,rb (F=0:NORM/1:DSTB) MV
//
//
//
//
//
//
`ifdef DEBUG
	$display("CAL rw:%h = ra:%h op:%h rb:%h (F:%h)", wad, ra, op, rb, dstb);
`endif
		end
		16'b0100_xxxx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 1 0 0 rw> b-> im------------> ; LIL rw,rb,im
//
//
//
//
//
//
`ifdef DEBUG
	$display("LIL wr:%h liop:%h, IM:%h (rb:%h)", wad, liop, iv, rb);
`endif
		end
		16'b0101_xxxx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 1 0 1 rw> b-> im------------> ; LIH rw,rb,im
//
//
//
//
//
//
`ifdef DEBUG
	$display("LIH wr:%h liop:%h, IM:%h (rb:%h)", wad, liop, iv, rb);
`endif
		end
		16'b0110_xx00_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 1 1 0 rw> 0 0 F 0 0 0 0 S C Z ; LI rw,SR S:sign C:carry Z:zero
			wad = o[11:10];
			we = `ASSERT;
			iv = {5'h00, sg, ca, ze};
			liop = `IMM;
			dstb = o[7];
`ifdef DEBUG
	$display("LI rw:%h, SR(S%hC%hZ%h) DSTB:%h", wad, sg, ca, ze, dstb);
`endif
		end
		16'b0110_xx10_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 1 1 0 rb> 0 1 F 0 0 0 0 S C Z ; MV SR,rb S:sign C:carry Z:zero
			rb = o[11:10];
			swe = `ASSERT;
			liop = `THU;
			dstb = o[7];
`ifdef DEBUG
	$display("LI SR(S%hC%hZ%h), rb:%h DSTB:%h", sg, ca, ze, rb, dstb);
`endif
		end
		16'b0110_xx11_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 1 1 0 * * 1 1 F 0 0 0 0 S C Z ; LI SR,im S:sign C:carry Z:zero
			swe = `ASSERT;
			liop = `IMM;
			dstb = o[7];
`ifdef DEBUG
	$display("LI SR(S%hC%hZ%h), IM:%h DSTB:%h", sg, ca, ze, iv, dstb);
`endif
		end
		16'b0110_001x_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 1 1 0 0 0 1 F op----> a-> b-> ; SM [ra]=rb / SM [ra] = [ra op rb] *MM
//
//
//
//
//
//
`ifdef DEBUG
	$display("SM [ra:%h]= ra:%h op rb:%h F:%h", ra, ra, op, rb);
`endif
		end
		16'b0111_0xxx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 1 1 1 0 p f f im------------> ; JP/BR pf [PC op im]
//
//
//
//
//
//
		end
		16'b0111_1xxx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 1 1 1 1 p f f im------------> ; JP/BR pf [SP op im]
//
//
//
//
//
//
		end
		16'b1000_00xx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//1 0 0 0 0 0 rw> im------------> ; LM rw=[im]
//
//
//
//
//
//
`ifdef DEBUG
	$display("LM rw:%h = [liop:%h IM:%h]", wad, liop, iv);
`endif
		end
		16'b1001_xxxx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//1 0 0 1 a-> b-> im------------> ; SM [ra + (s)im]=rb
//
//
//
//
//
//
`ifdef DEBUG
	$display("SM [ra:%h + liop:%h (s)IM:%h] = rb:%h", ra, liop, iv, rb);
`endif
		end
		16'b1010_xxxx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//1 0 1 0 rw> F 0 op----> a-> b-> ; LM rw=[ra op rb]
//
//
//
//
//
//
`ifdef DEBUG
	$display("LM rw:%d = [ra:%h op:%h rb:%h] F:%h", wad, ra, op, rb, dstb);
`endif
		end
		16'b1011_xxxx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//1 0 1 1 rw> a-> im------------> ; LM rw=[ra + (s)im]
//
//
//
//
//
//
`ifdef DEBUG
	$display("LM rw:%h = [ra:%h + liop:%h IM:%h]", wad, ra, liop, iv);
`endif
		end
		16'b110x_xxxx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//1 1 0 # rw> a-> im------------> ; CAL rw=ra,im (#=0:ADD/1:SUB only)
//
//
//
			op = {3'b00,o[12]};
//
//
//
`ifdef DEBUG
	$display("CAL rw:%h = ra:%h, op#:%h IM:%h(#=0:ADD/1:SUB only)", wad, ra, op, iv);
`endif
		end
		16'b111x_xxxx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//1 1 1 a->(p f f)im------------> ; JP/BR pf [ra + (s)im]
			if(pf == `ASSERT) begin
//
//
//
//
//
//
			end
`ifdef DEBUG
	$display("JP/BR pf:%h(Z%hC%hS%h) [ra:%h + liop:%h (s)IM:%h]", pf, ze, ca, sg, ra, liop, iv);
`endif
		end
		endcase
`ifdef DEBUG2
$display("----DEBUG----(%f)", $realtime);
$display("PC[%h]we[%h]CODE:%h", test.pu.pc.pc, pcwe, o);
$display("RA a[%h], b[%h], w[%h](%h)", ra, rb, wad, we);
$display("ALU op[%h], dstb[%h], status Z[%h] C[%h] S[%h]", op, dstb, ze, ca, sg);
$display("IMX[%h] IM[%h] PCS[%h]", liop, iv, pcs);
$display("DMEM we[%h] sel[%h]", dmwe, dms);
$display("r0[%h]1[%h]2[%h]3[%h]", test.pu.ra.rega[0], test.pu.ra.rega[1],
	test.pu.ra.rega[2], test.pu.re.rega[3]);
$display("-------------");
`endif
	end
endmodule
