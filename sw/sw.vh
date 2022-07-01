`define HEAD 2'b10 // Flow bit type
`define BODY 2'b01 // Flow bit type
`define TAIL 2'b11 // Flow bit type
`define EMPT 2'b00 // Flow bit type

`define ASSERT 1'b1
`define NEGATE 1'b0

`define PKTW 9
`define FIFOL 15 // 16:0 FIFO Length
`define FIFOLB 3 // 3:0  FIFO Length Bit

`define FLOWBH 9 // Flow Bit High
`define FLOWBL 8 // Flow Bit Low

`define PORT 3 // 3:0 // Number of Ports

/*
HEAD
0---4---89
PP
PP = Onput Port 00, 01, 10, 11
*/
