module test;
	logic a, b;
	logic [1:0] floor;
	logic clk, rst;
	state state(a, b, floor, clk, rst);
	always #5 clk = ~clk;
initial begin
	$dumpfile("state.vcd");
	$dumpvars(0, test);
clk = 0;
rst = 1;
a= 0;
b= 0;
#20
rst = 0;
#10
a= 1;
#50
b= 1;
#50
$finish;
end
endmodule
