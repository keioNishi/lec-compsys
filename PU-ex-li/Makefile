all:		a.out fibo.vcd
a.out:		test.v pu.v alu.v pc.v imem.v rega.v dec.v lidx.v
		iverilog -g2012 test.v pu.v alu.v pc.v imem.v rega.v dec.v lidx.v
fibo.vcd:	a.out
		vvp a.out
sim:		wave
wave:		fibo.vcd
		gtkwave fibo.vcd
gate.v:		test.v pu.v alu.v pc.v imem.v rega.v dec.v lidx.v
		yosys pu.ys
yosys:		test.v pu.v alu.v pc.v imem.v rega.v dec.v lidx.v
		yosys pu.ys
show:		show.dot
		gvedit show.dot
typsim:		gate.v
		iverilog -gspecify -T typ test.v gate.v ../osu018_stdcells.v
minsim:		gate.v
		iverilog -gspecify -T typ test.v gate.v ../osu018_stdcells.v
maxsim:		gate.v
		iverilog -gspecify -T typ test.v gate.v ../osu018_stdcells.v
pu:
		iverilog -g2012 pu.v alu.v pc.v imem.v rega.v dec.v lidx.v
alu:
		iverilog -g2012 alu.v
pc:
		iverilog -g2012 pc.v
imem:
		iverilog -g2012 imem.v
rega:
		iverilog -g2012 rega.v
dec:
		iverilog -g2012 dec.v
lidx:
		iverilog -g2012 lidx.v
clean:
		rm *.out *.vcd
