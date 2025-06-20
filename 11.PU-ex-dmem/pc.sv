`include "pu.vh"
module pc( // Program Counter
	input halt,
	output logic [`PCS:0] pc,
	input clk, rst);
	always @(posedge clk or posedge rst)
		if(rst) pc <= 0;
		else if(!halt) begin
			pc <= pc + 1;
		end
endmodule
