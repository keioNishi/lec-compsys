`timescale 1ns/10ps
`define ASSERT 1'b1
`define NEGATE 1'b0

`define WIDTH 15 // data width 15:0
`define HALFWIDTH 7 // half data width 7:0

`define RAS 3 // 3:0 r0, r1, r2, r3 register addresses size
`define RASB 1 // 1:0 register address size bit for addressing

`define OPS 2 // 2:0 operator size

`define PCS 5 // 5:0 program counter size

//`define CMDS 9 // 9:0 command size  HALT + RASB+1 + OPS+1 + RASB+1 + RASB+1
`define CMDS `WIDTH // see dec.v
`define LICMDS 1 // 1:0 00,01 do nothing 10 load low 11 load high

`define LIDXS 1 // 1:0 00,01 do nothing / 10 LIL / 11 LIH

`define LIDXENUM typedef enum {THU, IMM, LIL, LIH} LIDEXNUM;

`define DMS 255  // 255:0 data memory size
`define DMSB 7 // 7:0 data memory addr size
