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
	output logic dmwe, dms);
/*

F E D C B A 9 8 7 6 5 4 3 2 1 0
0 0 0 0 0 0 0 0 0 0 0 0 * * * 0 ; NOP (0) DSTB
0 0 0 0 0 0 0 0 0 0 0 0 * * * 1 ; HALT (1)
0 0 0 0 1 0 rw> im------------> ; LI rw,(s)im
0 0 0 1 0 0 b-> im------------> ; SM [(s)im]=rb
0 0 1 0 0 0 rw> op----> a-> b-> ; CAL rw=ra,rb
0 1 0 0 rw> b-> im------------> ; LIL rw,rb,im
0 1 0 1 rw> b-> im------------> ; LIH rw,rb,im
1 0 0 0 0 0 0 0 op----> a-> b-> ; SM [ra]=rb / SM [ra] = [ra op rb]
1 0 0 1 a-> b-> im------------> ; SM [ra + (s)im]=rb
1 1 0 0 rw> 0 0 im------------> ; LM rw=[im]
1 1 0 1 rw> F 0 op----> a-> b-> ; LM rw=[ra op rb]
1 1 1 0 rw> a-> im------------> ; LM rw=[ra + (s)im]
1 1 1 # rw> a-> im------------> ; CAL rw=ra,im (#=0:ADD/1:SUB only)

ADD 4'b0000 SUB 4'b0001 ASR 4'b0010 RSR 4'b0011
RSL 4'b0100 BST 4'b0101 BRT 4'b0110 BTS 4'b0111
AND 4'b1000 OR  4'b1001 NAD 4'b1010 XOR 4'b1011
MUL 4'b1100 EXT 4'b1101 THA 4'b1110 THB 4'b1111

IMS
LIL 2'b00 LIH 2'b01 IMM 2'b10 THU 2'b11
*/

	always_comb begin
		h = `NEGATE;
		ra = 0;
		rb = 0;
		op = `THB;
		we = `NEGATE;
		wad = 0;
		liop = `THU;
		iv = 0;
		dmwe = `NEGATE;
		dms = `NEGATE;
`ifdef DEBUG
$display("*****PC[%h]CODE:%h", test.pu.pc.pc, o);
$display("r0[%h]1[%h]2[%h]3[%h]", test.pu.ra.rega[0], test.pu.ra.rega[1],
	test.pu.ra.rega[2], test.pu.ra.rega[3]);
`endif
		casex(o)
		// synopsys full_case parallel_case
		16'b0000_0000_0000_xxx0: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 0 0 0 0 0 0 0 0 0 * * * 0 ; NOP DSTB
`ifdef DEBUG
	$display("NOP");
`endif
		end
		16'b0000_0000_0000_xxx1: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 0 0 0 0 0 0 0 0 0 * * * 1 ; HALT
			h = `ASSERT;
`ifdef DEBUG
	$display("HALT");
`endif
		end
		16'b0000_10xx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 0 1 0 rw> im------------> ; LI rw,(s)im
			wad = o[9:8];
			we = `ASSERT;
			iv = o[`HALFWIDTH:0];
			liop = `IMM;
`ifdef DEBUG
	$display("LI wr:%h (s)im:%h // liop:%h", wad, iv, liop);
`endif
		end
		16'b0001_00xx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 0 1 0 0 b-> im------------> ; SM [(s)im]=rb
			rb = o[9:8];
			dmwe = `ASSERT;
			iv = o[`HALFWIDTH:0];
			liop = `IMM;
`ifdef DEBUG
	$display("SM [(s)im:%h]=rb:%h", iv, rb);
`endif
		end
		16'b0010_00xx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//0 0 1 0 0 0 rw> op----> a-> b-> ; CAL rw=ra,rb
//
//
//
//
//
//
`ifdef DEBUG
	$display("CAL rw:%h = ra:%h op:%h rb:%h", wad, ra, op, rb);
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
		16'b1000_0000_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//1 0 0 0 0 0 0 0 op----> a-> b-> ; SM [ra]=rb / SM [ra] = [ra op rb]
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
		16'b1100_xxxx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//1 1 0 0 rw> 0 0 im------------> ; LM rw=[im]
			wad = o[11:10];
			we = `ASSERT;
			iv = o[`HALFWIDTH:0];
			liop = `IMM;
			dms = `ASSERT;
`ifdef DEBUG
	$display("LM rw:%h = [liop:%h IM:%h]", wad, liop, iv);
`endif
		end
		16'b1101_xxxx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//1 1 0 1 rw> F 0 op----> a-> b-> ; LM rw=[ra op rb]
//
//
//
//
//
//
`ifdef DEBUG
	$display("LM rw:%d = [ra:%h op:%h rb:%h]", wad, ra, op, rb);
`endif
		end
		16'b1110_xxxx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//1 1 1 0 rw> a-> im------------> ; LM rw=[ra + (s)im]
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
		16'b111x_xxxx_xxxx_xxxx: begin
//F E D C B A 9 8 7 6 5 4 3 2 1 0
//1 1 1 # rw> a-> im------------> ; CAL rw=ra,im (#=0:ADD/1:SUB only)
			wad = o[11:10];
			we = `ASSERT;
			ra = o[9:8];
			op = {3'b00,o[12]};
			iv = o[`HALFWIDTH:0];
			liop = `IMM;
`ifdef DEBUG
	$display("CAL rw:%h = ra:%h, op#:%h IM:%h(#=0:ADD/1:SUB only)", wad, ra, op, iv);
`endif
		end
		endcase
`ifdef DEBUG2
$display("----DEBUG----(%f)", $realtime);
$display("PC[%h]we[%h]CODE:%h", test.pu.pc.pc, pcwe, o);
$display("RA a[%h], b[%h], w[%h](%h)", ra, rb, wad, we);
$display("ALU op[%h]", op);
$display("IMX[%h] IM[%h] PCS[%h]", liop, iv, pcs);
$display("DMEM we[%h] sel[%h]", dmwe, dms);
$display("r0[%h]1[%h]2[%h]3[%h]", test.pu.ra.rega[0], test.pu.ra.rega[1],
	test.pu.ra.rega[2], test.pu.re.rega[3]);
$display("-------------");
`endif
	end
endmodule
