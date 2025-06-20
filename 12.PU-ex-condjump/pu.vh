`timescale 1ns/10ps
`define ASSERT 1'b1
`define NEGATE 1'b0

`define WIDTH 15 // data width 15:0
`define HALFWIDTH 7 // half data width 7:0

`define RAS 3 // 3:0 r0, r1, r2, r3 register addresses size
`define RASB 1 // 1:0 register address size bit for addressing

`define ALUOPS 3 // 3:0 operator size

`define ADD 4'b0000
`define SUB 4'b0001
`define ASR 4'b0010
`define RSR 4'b0011
`define RSL 4'b0100
`define BST 4'b0101
`define BRT 4'b0110
`define BTS 4'b0111
`define AND 4'b1000
`define OR  4'b1001
`define NAD 4'b1010
`define XOR 4'b1011
`define MUL 4'b1100
`define EXT 4'b1101
`define THA 4'b1110
`define THB 4'b1111

`define PCS 7 // 7:0 program counter size
`define PCPRFXS 1 // 1:0 1:0+5:0=7:0

`define CMDS `WIDTH // see dec.v
`define IMXOPS 1 // see IMXENUM

`define IMXS 1 // 1:0 00,01 do nothing / 10 LIL / 11 LIH

`define LIL 2'b00
`define LIH 2'b01
`define IMM 2'b10
`define THU 2'b11

`define DMS 255  // 255:0 data memory size
`define DMSB 7 // 7:0 data memory addr size
