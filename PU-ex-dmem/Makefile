SRCS = pu.vh pu.v alu.v pc.v imem.v rega.v dec.v lidx.v sel.v dmem.v
TESTSRC = test.v
ALLSRCS = pu.vh $(SRCS)
TESTSRCS = $(TESTSRC) $(SRCS)
VCDFILE = pu.vcd
YOSYSSCRIPT = pu.ys
OUTFILE = a.out
GATEFILE = gate.v
SYNTHFILE = synth.v
DOTFILE = show.dot
CELLFILE = ../osu018_stdcells.v
ABCHISFILE = abc.history
all:		$(OUTFILE) $(VCDFILE)
a.out:		$(TESTSRCS)
		iverilog -g2012 $(TESTSRCS)
$(VCDFILE):	$(OUTFILE)
		vvp $(OUTFILE)
sim:		wave
wave:		$(VCDFILE)
		gtkwave $(VCDFILE)
gate.v:		$(TESTSRCS)
		yosys $(YOSYSSCRIPT)
synth:		yosys
yosys:		$(TESTSRCS)
		yosys $(YOSYSSCRIPT)
show:		$(DOTFILE)
		gvedit $(DOTFILE)
typsim:		$(GATEFILE)
		iverilog -gspecify -T typ $(TESTSRC) $(GATEFILE) $(CELLFILE)
minsim:		$(GATEFILE)
		iverilog -gspecify -T typ $(TESTSRC) $(GATEFILE) $(CELLFILE)
maxsim:		$(GATEFILE)
		iverilog -gspecify -T typ $(TESTSRC) $(GATEFILE) $(CELLFILE)
clean:
		-rm *.out *.vcd *.dot $(ABCHISFILE) $(GATEFILE) $(SYNTHFILE)
pu:
		iverilog -g2012 $(SRCS)
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
dmem:
		iverilog -g2012 dmem.v
