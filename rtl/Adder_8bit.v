`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2026 08:07:09 PM
// Design Name: 
// Module Name: Adder_8bit
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

module full_adder(c_out,sum,c_in,a,b);

output c_out,sum;
input c_in,a,b;

assign sum = a ^ b ^ c_in;
assign c_out = ((a ^ b)&c_in) | (a&b);
    
    
endmodule

module Adder_8bit #(parameter N=8) (sum,a,b);

output [N:0] sum;
input [N-1:0] a,b;

wire [N-2:0] t;

genvar i;
generate
for (i=0; i<N; i=i+1)
begin: loop
    if (i==0) full_adder F0(t[0],sum[0],1'b0,a[0],b[0]);
    else if(i==N-1) full_adder F_last(sum[N],sum[i],t[i-1],a[i],b[i]);
    else full_adder F(t[i],sum[i],t[i-1],a[i],b[i]);
end
endgenerate

endmodule