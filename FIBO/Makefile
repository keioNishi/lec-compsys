all:		a.out fibo.vcd
a.out:		test.v top.v alu.v pc.v imem.v rega.v dec.v
		iverilog -g2012 test.v top.v alu.v pc.v imem.v rega.v dec.v
fibo.vcd:	a.out
		vvp a.out
wave:		fibo.vcd
		gtkwave fibo.vcd
show:		show.dot
		gvedit show.dot
gate.v:		test.v top.v alu.v pc.v imem.v rega.v dec.v
		yosys top.ys
syn:		yosys
yosys:		test.v top.v alu.v pc.v imem.v rega.v dec.v
		yosys top.ys
typsim:		gate.v a.out
		iverilog -gspecify -T typ test.v gate.v ../osu018_stdcells.v
		vvp a.out
minsim:		gate.v a.out
		iverilog -gspecify -T typ test.v gate.v ../osu018_stdcells.v
		vvp a.out
maxsim:		gate.v a.out
		iverilog -gspecify -T typ test.v gate.v ../osu018_stdcells.v
		vvp a.out
top:
		iverilog -g2012 top.v alu.v pc.v imem.v rega.v dec.v
clean:
		rm gate.v fibo.vcd a.out
