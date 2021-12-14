all:
	iverilog -g2012 sw.v ib.v ibsm.v fifo.v mkreq.v mkwe.v arb.v cb.v cbsel.v ackor.v swtest.v
	vvp a.out
show:
	gtkwave sw.vcd
sw:
	iverilog -g2012 sw.v ib.v ibsm.v fifo.v mkreq.v mkwe.v arb.v cb.v cbsel.v ackor.v
fifo:
	iverilog -g2012 fifo.v
ibsm:
	iverilog -g2012 ibsm.v
mkreq:
	iverilog -g2012 mkreq.v
mkwe:
	iverilog -g2012 mkwe.v
ib:
	iverilog -g2012 ib.v ibsm.v fifo.v mkreq.v mkwe.v
arb:
	iverilog -g2012 arb.v
cbsel:
	iverilog -g2012 cbsel.v
cb:
	iverilog -g2012 cb.v cbsel.v
ackor:
	iverilog -g2012 ackor.v
syn:
	yosys sw.ys
