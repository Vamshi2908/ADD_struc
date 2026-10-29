`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2026 10:37:53 PM
// Design Name: 
// Module Name: Reg_Bank
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

module Reg_8bit(out, in, en, ld, reset, clk);

input clk,reset,en,ld;
input [7:0] in;
output [7:0] out;

reg [7:0] q;

always @(posedge clk or negedge reset)
begin
    if(!reset) q <= 0;
    else if(ld) q <= in;
end

assign out = en?q:8'bz;

endmodule


module Reg_Bank(out,in,en,ld,reset,clk);
output [7:0] out;
input [7:0] in;
input [7:1] en,ld;
input reset, clk;

wire signal;

assign signal = ^en;

genvar i;
generate
    for(i=1; i<=7; i=i+1)
    begin:loop
        Reg_8bit R(.out(out), .in(in), .en(en[i]), .ld(ld[i]), .reset(reset), .clk(clk));    
    end     
endgenerate

endmodule
