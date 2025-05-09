module fifotest;
	logic [7:0] in, out;
	logic we, re;
	logic clk, rst;
	fifo fifo(in, we, full, out, re, empty, clk, rst);
	always #5 clk = ~clk;
initial begin
$dumpfile("fifo.vcd");
$dumpvars(0, fifotest);
rst = 1;
clk = 0;
we = 0;
re = 0;
in = 5;
#30;
rst = 0;
we = 1;
#10;
in = 6;
#10;
in = 7;
#10
we = 0;
#10
re = 1;
#10
re = 0;
we = 1;
in = 8;
#10
in = 9;
#10
in = 10;
#10
in = 11;
#10
in = 12;
#10
in = 13;
#10
in = 14;
#10
in = 15;
#10
in = 16;
#50
$finish;
end
endmodule
