module preset_counter(input en, input [2:0] val, output logic [3:0] count, input clk, input rst);
	always @(posedge clk) begin
		if(rst) count <= 0;
		else
			if(en) begin
				if(count != 0) count <= count - 1;
			end else
				count <= val;
	end
endmodule

module test;
	logic en, clk, rst;
	logic [2:0] val;
	logic [3:0] count;
	preset_counter preset_counter(en, val, count, clk, rst);
	always #5 clk = ~clk;
initial begin
$dumpfile("preset_counter.vcd");
$dumpvars(0, test);
clk = 0;
rst = 1;
val = 14;
en = 0;
#20
rst = 0;
#10
en = 1;
#120
en = 0;
#10
en = 1;
#120
$finish();
end
endmodule
