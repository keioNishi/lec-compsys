`include "sw.vh"
module fifo(input [`PKTW:0] in, input we, output logic full,
	output [`PKTW:0] out, input re, output logic empty, input clk, rst);
	logic [`FIFOLB:0] head, tail, headi;
	logic [`PKTW:0] mem [`FIFOL:0];
	logic [`PKTW:0] pout, out;

	assign pout = mem[tail];
	always_comb begin
		if(empty) out = 0;
		else out = pout;
	end
	always @(posedge clk) if(we) mem[head] <= in;

	assign headi = head+1;
	always @(posedge clk) begin
		if(rst) begin
			head <= 0;
			tail <= 0;
		end else begin
			if(we) head <= headi;
			if(re) tail <= tail + 1;
		end
	end
	always_comb begin
		if(head == tail) empty = `ASSERT;
		else empty = `NEGATE;
		if(headi == tail) full = `ASSERT;
		else full = `NEGATE;
	end
endmodule
