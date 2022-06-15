module dec(
	input [15:0] o,
	output logic [1:0] aradr, bradr,
	output logic [2:0] op,
	output logic [1:0] wadr,
	output we, halt, ll, lh,
	output logic [7:0] ib);
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
		ib = 0;
		case(o[15:13])
		3'b000: begin
			if(o[2]) begin
				bradr = o[9:8];
				aradr = o[1:0];
				op = o[6:4];
				wadr = o[11:10];
				we = 1'b1;
			end else begin
				if(o[0]) halt = 1'b1;
			end
		end
		3'b001: begin
			// calc with immediage value
		end
		3'b010: begin
			// load immediate
		end
		endcase
	end
endmodule
