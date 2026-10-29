`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2026 10:37:53 PM
// Design Name: 
// Module Name: Main_Module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "Reg_Bank.v"
`include "Decoder.v"
`include "Adder_8bit.v"

module Main_Module(out,in,instr,clk,reset);
input [7:0] instr,in;
input clk,reset;
output [7:0] out;

wire [7:0] bus,bus_out;
wire [7:0] en,ld;
wire [7:0] en_dec, ld_dec;

wire [2:0] S = instr[2:0];
wire [2:0] D = instr[5:3];

wire move = ~(instr[7] |instr[6]);
wire add = ~instr[7] & instr[6];

wire [7:0] temp_out, sum;

reg add_d;

always @(posedge clk or negedge reset)
begin
    if(!reset) add_d <= 0;
    else add_d <= add;
end

wire [2:0] T;
assign T = add_d ? D : S;

assign ld = move?ld_dec:(add_d?8'b10000000:8'b0);
assign en = (move | add | add_d)?en_dec:8'b0;


Decoder D1(.out(ld_dec),.in(D),.en(move)), D2(.out(en_dec),.in(T),.en(move | add));

Reg_Bank RB(.out(bus_out),.in(bus),.en(en[7:1]),.ld(ld[7:1]),.reset(reset),.clk(clk));

Reg_8bit Temp_Reg(.out(temp_out),.in(bus),.en(1'b1),.ld(add & ~add_d),.reset(reset),.clk(clk));

Adder_8bit A1(.sum(sum),.a(temp_out),.b(bus_out));

assign bus = add_d?sum:(en[0]?in:bus_out);
assign out = ld[0]?bus:out;

endmodule
