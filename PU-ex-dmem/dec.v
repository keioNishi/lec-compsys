module dec(
	input [`CMDS:0] o,
	output logic [`RASB:0] aradr, bradr,
	output logic [`OPS:0] op,
	output logic [`RASB:0] wadr,
	output we, halt, ll, lh,
	output logic [`HALFWIDTH:0] iv,
	output logic dmwe, dms);
	logic we, halt;
	logic ll, lh;
	always_comb begin
		aradr = 0;
		bradr = 0;
		op = 0;
		wadr = 0;
		we = 0;
		halt = 0;
		ll = 0;
		lh = 0;
		iv = 0;
		dmwe = 0;
		dms = 0;
		case(o[15:13])
		3'b000: begin
			if(o[2]) begin
//0 0 0 * rw> a-> * op -> * 1 b-> ; CAL rw=ra,rb
				aradr = o[9:8];
				bradr = o[1:0];
				op = o[6:4];
				wadr = o[11:10];
				we = 1'b1;
			end else begin
//0 0 0 * * * * * * * * * * 0 * 1 ; HALT
				if(o[0]) halt = 1'b1;
			end
		end
		3'b001: begin
//0 0 1 o rw> a-> im------------> ; CAL rw=ra,im
		end
		3'b010: begin // load immediate
			if(o[12]) begin
//0 1 0 1 rw> b-> im------------> ; LIH rw=rb,im
			end else begin
//0 1 0 0 rw> b-> im------------> ; LIL rw=rb,im
			end
		end
		3'b100: begin
//1 0 0 o rw> a-> im------------> ; LM rw=[ra o im] o=0:ADD/1:SUB
		end
		3'b101: begin
//1 0 1 o b-> a-> im------------> ; SM [ra o im]=rb
		end
		endcase
	end
endmodule

/*
F E D C B A 9 8 7 6 5 4 3 2 1 0
0 0 0 * * * * * * * * * * 0 * 0 ; NOP
0 0 0 * * * * * * * * * * 0 * 1 ; HALT
0 0 0 * rw> a-> * op -> * 1 b-> ; CAL rw=ra,rb
0 0 1 o rw> a-> im------------> ; CAL rw=ra,im
0 1 0 0 rw> b-> im------------> ; LIL rw=rb,im
0 1 0 1 rw> b-> im------------> ; LIH rw=rb,im
1 0 0 o rw> a-> im------------> ; LM rw=[ra o im] o=0:ADD/1:SUB
1 0 1 o b-> a-> im------------> ; SM [ra o im]=rb
*/
