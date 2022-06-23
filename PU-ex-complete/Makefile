SRCS = pu.vh pu.sv alu.sv pc.sv imem.sv ra.sv dec.sv imx.sv sel.sv dmem.sv sp.sv sel3.sv
TESTSRC = test.sv
ALLSRCS = pu.vh $(SRCS)
TESTSRCS = $(TESTSRC) $(SRCS)
VCDFILE = pu.vcd
YOSYSSCRIPT = pu.ys
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
#pu:
#		iverilog -g2012 $(SRCS)
alu:
		iverilog -g2012 alu.sv
pc:
		iverilog -g2012 pc.sv
imem:
		iverilog -g2012 imem.sv
ra:
		iverilog -g2012 ra.sv
dec:
		iverilog -g2012 dec.sv
imx:
		iverilog -g2012 imx.sv
sel:
		iverilog -g2012 sel.sv
dmem:
		iverilog -g2012 dmem.sv
sp:
		iverilog -g2012 sp.sv
sel3:
		iverilog -g2012 sel3.sv
