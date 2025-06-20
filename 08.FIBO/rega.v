module rega(input logic [1:0] arad, brad, output logic[15:0] outa, outb, input en, input logic [1:0] wad, input logic [15:0] in, input clk, rst);
	logic [15:0] regar[3:0];
	always_ff @(posedge clk)
		if(rst) begin
			regar[0] <= 0;
			regar[1] <= 1;
		end else
			if(en) regar[wad] <= in;
	assign outa = regar[arad];
	assign outb = regar[brad];
endmodule
