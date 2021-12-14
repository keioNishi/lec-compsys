module test;
	logic [3:0] a, b, s;
	raddr raddr(a, b, s, co);
initial begin
$dumpfile("raddr.vcd");
$dumpvars(0, test);
a = 5;
b = 3;
#10
a = 13;
b = 7;
#10
a = 13;
b = -7;
#10
$finish;
end
endmodule
