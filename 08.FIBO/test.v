`timescale 1ns/1ps
module test;
	reg clk, rst;
	wire [15:0] wd;
	top top(we, wd, clk, rst);
	always #5 clk =~ clk;
initial begin
$dumpfile("fibo.vcd");
$dumpvars(0, top);
rst = 1;
clk = 0;
#20
rst = 0;
#500
$finish;
end
endmodule
