`include "sw.vh"
module mkreq(input [`PKTW:0] pkti, output logic [`PORT:0] req, input clk, rst);
	logic [`PORT:0] reqp;
	always @* begin
		reqp = 0;
		reqp[pkti[1:0]] = `ASSERT;
	end
	always @(posedge clk or posedge rst) begin
		if(rst) req <= 0;
		else begin
			if(pkti[`FLOWBH:`FLOWBL] == `HEAD) begin
				req <= reqp;
			end
		end
	end
endmodule
