module test;
	logic d, clk;
	ff ff0(d, q, clk);
	
	always #5 clk = ~clk;
initial begin
$dumpfile("test.vcd");
$dumpvars(0, test);
clk = 0;
d = 1;
#20
d = 0;
#13
d = 1;
#20
$finish();
end
endmodule
