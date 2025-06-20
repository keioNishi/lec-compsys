`include "pu.vh"
module pc( // Program Counter
	input halt,
	output logic [`PCS:0] pc,
	input we,
	input [`PCS:0] jpc,
	input clk, rst);
	always @(posedge clk or posedge rst)
		if(rst) pc <= 0;
		else if(!halt) begin
			if(we == `ASSERT) pc <= jpc;
			else pc <= pc + 1;
		end
endmodule
