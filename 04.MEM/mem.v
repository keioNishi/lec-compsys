module mem(ra, wa, wd, rd, we, clk);
	input [1:0] ra, wa;
	input [7:0] wd;
	output [7:0] rd;
	input we;
	input clk;
	logic [7:0] mem [3:0];
	assign rd = mem[ra];
	always@(posedge clk) begin
		if(we) mem[wa] <= wd;
	end
endmodule
module test;
	logic [1:0] ra, wa;
	logic [7:0] rd, wd;
	logic we, clk;
	always #10 clk = ~clk;	
	mem mem(ra, wa, wd, rd, we, clk);
initial begin
$dumpfile("mem.vcd");
$dumpvars(0, test);
clk = 0;
ra = 0;
we = 0;
wa = 0;
wd = 111;
#50
we = 1;
#20
$finish;
end
endmodule
