SRCS = sw.sv ib.sv ibsm.sv fifo.sv mkreq.sv mkwe.sv arb.sv cb.sv cbsel.sv ackor.sv
TESTSRC = test.sv
ALLSRCS = sw.vh $(SRCS)
TESTSRCS = $(TESTSRC) $(SRCS)
VCDFILE = sw.vcd
YOSYSSCRIPT = sw.ys
OUTFILE = a.out
GATEFILE = gate.v
SYNTHFILE = synth.v
DOTFILE = show.dot
CELLFILE = ../osu018_stdcells.v
all:		$(OUTFILE) $(VCDFILE)
a.out:		$(TESTSRCS)
		iverilog -g2012 $(TESTSRCS)
$(VCDFILE):	$(OUTFILE)
		vvp $(OUTFILE)
view:		wave
show:		wave
wave:		$(VCDFILE)
		gtkwave -a pu.gtkw -4 'fontname_signals Lucida Console 12' -4 'fontname_waves Lucida Console 12' $(VCDFILE)
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
		-rm *.out *.vcd *.dot abc.history $(GATEFILE) $(SYNTHFILE)
sw:
		iverilog -g2012 sw.sv ib.sv ibsm.sv fifo.sv mkreq.sv mkwe.sv arb.sv cb.sv cbsel.sv ackor.sv
fifo:
		iverilog -g2012 fifo.sv
ibsm:
		iverilog -g2012 ibsm.sv
mkreq:
		iverilog -g2012 mkreq.sv
mkwe:
		iverilog -g2012 mkwe.sv
ib:
		iverilog -g2012 ib.sv ibsm.sv fifo.sv mkreq.sv mkwe.sv
arb:
		iverilog -g2012 arb.sv
cbsel:
		iverilog -g2012 cbsel.sv
cb:
		iverilog -g2012 cb.sv cbsel.sv
ackor:
		iverilog -g2012 ackor.sv
