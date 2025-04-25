module test;
	logic ia, ib, sel, out;
	sel sel1(ia, ib, sel, out);
initial begin
$dumpfile("sel.vcd");
$dumpvars(0, sel1);
ia = 1;
ib = 0;
sel = 0;
#10
ia = 0;
ib = 1;
sel = 0;
#10
ia = 1;
ib = 0;
sel = 1;
#10
ia = 0;
ib = 1;
sel = 1;
#10
$finish;
end
endmodule
