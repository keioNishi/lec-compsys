`include "sw.vh"
module mkwe(input [`PKTW:0] pkti, output logic we);
	always @* begin
		if(pkti[`FLOWBH:`FLOWBL] == `EMPT) we = `NEGATE;
		else we = `ASSERT;
	end
endmodule
