module simple_counter(output logic [2:0] count, input clk, input rst);
	always @(posedge clk) begin
		if(rst) count <= 0;
		else count <= count + 1;
	end
endmodule

module test;
	logic clk, rst;
	logic [2:0] count;
	simple_counter simple_counter(count, clk, rst);
	always #5 clk = ~clk;
initial begin
$dumpfile("simple_counter.vcd");
$dumpvars(0, test);
clk = 0;
rst = 1;
#20
rst = 0;
#100
$finish();
end
endmodule
