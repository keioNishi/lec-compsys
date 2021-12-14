module pc(input halt, output logic [5:0] pc, input clk, rst);
	always_ff @(posedge clk or posedge rst)
		if(rst) pc <= 0;
		else begin
			if(!halt) pc <= pc + 1;
		end
endmodule