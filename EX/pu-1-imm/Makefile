SOURCES = pu.v alu.v pc.v imem.v rega.v lidx.v dec.v
TESTMDL = test.v
all:	a.out pu.vcd
sim:	a.out pu.vcd
synth:	gate.v
clean:
	rm pu.vcd a.out gate.v synth.v
a.out:	$(TESTMDL) $(SOURCES)
	iverilog -g2012 $(TESTMDL) $(SOURCES)
pu.vcd:
	vvp a.out
show:
	gtkwave pu.vcd
gate.v:	$(SOURCES)
	yosys pu.ys
typsim:	gate.v pu.vcd
	iverilog -gspecify -T typ $(TESTMDL) gate.v ../osu018_stdcells.v
	vvp a.out
minsim:	gate.v pu.vcd
	iverilog -gspecify -T typ $(TESTMDL) gate.v ../osu018_stdcells.v
	vvp a.out
maxsim:	gate.v pu.vcd
	iverilog -gspecify -T typ $(TESTMDL) gate.v ../osu018_stdcells.v
	vvp a.out
pu:
	iverilog -g2012 $(SOURCES)
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
sel:
	iverilog -g2012 sel.v
