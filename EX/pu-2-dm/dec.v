`include "pu.vh"

module dec(input [`CMDS:0] o, output logic h, we, output logic [`RASB:0] wad,
	output logic [`OPS:0] op, output logic [`RASB:0] brad, arad,
	output logic [`LICMDS:0] liop, output logic [`HALFWIDTH:0] iv,
	output logic dmwe, dms);
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
//	`LIDXENUM
	always @* begin
		h = `NEGATE;
		arad = 0;
		brad = 0;
		op = 0;
		we = `NEGATE;
		wad = 0;
		liop = THU;
		iv = 0;
		dmwe = `NEGATE;
		dms = `NEGATE;
		case(o[15:13])
		// synopsys full_case parallel_case
		3'b000: begin
			case(o[2])
			// synopsys full_case parallel_case
			`NEGATE: begin
				if(o[0] == `NEGATE) begin
// F E D C B A 9 8 7 6 5 4 3 2 1 0
// 0 0 0 * * * * * * * * * * 0 * 0 ; NOP
				end else begin
// F E D C B A 9 8 7 6 5 4 3 2 1 0
// 0 0 0 * * * * * * * * * * 0 * 1 ; HALT
					h = `ASSERT;
				end

			end
			`ASSERT: begin
				case(o[12])
				// synopsys full_case parallel_case
				`NEGATE: begin
// F E D C B A 9 8 7 6 5 4 3 2 1 0
// 0 0 0 0 rw> a-> * op -> * 1 b-> ; CAL rw=ra,rb
					wad = o[11:10];
					we = `ASSERT;
					arad = o[9:8];
					op = o[6:4];
					brad = o[1:0];
				end
				`ASSERT: begin
// F E D C B A 9 8 7 6 5 4 3 2 1 0
// 0 0 0 1 rw> a-> * op -> * 1 b-> ; LM rw=[ra op rb]
					wad = o[11:10];
					we = `ASSERT;
					arad = o[9:8];
					op = o[6:4];
					brad = o[1:0];
					dms = `ASSERT;
				end
				endcase
			end
			endcase
		end
		3'b001: begin
// F E D C B A 9 8 7 6 5 4 3 2 1 0
// 0 0 1 o rw> a-> im------------> ; CAL rw=ra,im
			wad = o[11:10];
			we = `ASSERT;
			op = {2'b00,o[12]};
			arad = o[9:8];
			liop = IMM;
		end
		3'b010: begin
			case(o[12])
			// synopsys full_case parallel_case
			`NEGATE: begin
// F E D C B A 9 8 7 6 5 4 3 2 1 0
// 0 1 0 0 rw> a-> im------------> ; LIL rw=ra,im
				wad = o[11:10];
				we = `ASSERT;
				brad = o[9:8];
				op = 3'b010; // TRU
				liop = LIL;
				iv = o[`HALFWIDTH:0];
			end
			`ASSERT: begin
// F E D C B A 9 8 7 6 5 4 3 2 1 0
// 0 1 0 1 rw> a-> im------------> ; LIH rw=ra,im
				wad = o[11:10];
				we = `ASSERT;
				brad = o[9:8];
				op = 3'b010; // TRU
				liop = LIH;
				iv = o[`HALFWIDTH:0];
			end
			endcase	
		end
		3'b100: begin
// F E D C B A 9 8 7 6 5 4 3 2 1 0
// 1 0 0 o rw> a-> im------------> ; LM rw=[ra o im]
			wad = o[11:10];
			we = `ASSERT;
			arad = o[9:8];
			op = {2'b00,o[12]}; // ADD/SUB
			liop = IMM;
			iv = o[`HALFWIDTH:0];
		end
		3'b101: begin
// F E D C B A 9 8 7 6 5 4 3 2 1 0
// 1 0 1 o b-> a-> im------------> ; SM [ra o im]=rb
			brad = o[11:10];
			we = `ASSERT;
			arad = o[9:8];
			op = {2'b00,o[12]}; // ADD/SUB
			liop = IMM;
			iv = o[`HALFWIDTH:0];
			dmwe = `ASSERT;
		end
		endcase
	end
endmodule
