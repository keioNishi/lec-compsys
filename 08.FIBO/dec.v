module dec(input [10:0] o, output logic [1:0] aradr, bradr, output logic [2:0] op, output logic [1:0] wadr, output we, halt);
	assign aradr = o[3:2];
	assign bradr = o[1:0];
	assign op = o[6:4];
	assign wadr = o[8:7];
	assign we = o[9];
	assign halt = o[10];
endmodule
