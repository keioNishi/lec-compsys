`include "sw.vh"
module arb(input req0, req1, req2, req3, output logic ack0, ack1, ack2, ack3, input clk, rst);
	logic [1:0] pri;
	logic rreq0, rreq1, rreq2, rreq3;
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			rreq0 <= `NEGATE;
			rreq1 <= `NEGATE;
			rreq2 <= `NEGATE;
			rreq3 <= `NEGATE;
		end else begin
			rreq0 <= req0;
			rreq1 <= req1;
			rreq2 <= req2;
			rreq3 <= req3;
		end
	end
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			pri <= 0;
		end else begin
			if(
				(rreq0 == `ASSERT && req0 == `NEGATE) ||
				(rreq1 == `ASSERT && req1 == `NEGATE) ||
				(rreq2 == `ASSERT && req2 == `NEGATE) ||
				(rreq3 == `ASSERT && req3 == `NEGATE)) begin
				pri <= pri + 1;
			end
		end
	end
	always @(posedge clk) begin
		ack0 = `NEGATE;
		ack1 = `NEGATE;
		ack2 = `NEGATE;
		ack3 = `NEGATE;
		case(pri)
		// synopsys full_case parallel_case
		2'b00: begin
			if(req0 == `ASSERT) ack0 = `ASSERT;
			else if(req1 == `ASSERT) ack1 = `ASSERT;
			else if(req2 == `ASSERT) ack2 = `ASSERT;
			else if(req3 == `ASSERT) ack3 = `ASSERT;
			
		end
		2'b01: begin
			if(req1 == `ASSERT) ack1 = `ASSERT;
			else if(req2 == `ASSERT) ack2 = `ASSERT;
			else if(req3 == `ASSERT) ack3 = `ASSERT;
			else if(req0 == `ASSERT) ack0 = `ASSERT;
			
		end
		2'b10: begin
			if(req2 == `ASSERT) ack2 = `ASSERT;
			else if(req3 == `ASSERT) ack3 = `ASSERT;
			else if(req0 == `ASSERT) ack0 = `ASSERT;
			else if(req1 == `ASSERT) ack1 = `ASSERT;
			
		end
		2'b11: begin
			if(req3 == `ASSERT) ack3 = `ASSERT;
			else if(req0 == `ASSERT) ack0 = `ASSERT;
			else if(req1 == `ASSERT) ack1 = `ASSERT;
			else if(req2 == `ASSERT) ack2 = `ASSERT;
		end
		endcase
	end
endmodule
