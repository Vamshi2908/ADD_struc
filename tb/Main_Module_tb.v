`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2026 02:14:57 AM
// Design Name: 
// Module Name: Main_Module_tb
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


module Main_Module_tb();

reg [7:0] instr,in;
reg clk,reset;
wire [7:0] out;

Main_Module DUT(.out(out),.in(in),.instr(instr),.reset(reset),.clk(clk));

always #5 clk = ~clk;

initial
begin

    clk=0;
    reset=1'b0;
    instr=0;
    #3 reset=1'b1;
    print_reg();
    #2 instr=8'b00_001_000; in=1; print_reg();
    #10 instr=8'b00_010_000; in=2;print_reg();
    #10 instr=8'b00_011_000; in=3;print_reg();#10 instr=8'b00_100_000; in=4;print_reg();
    #10 instr=8'b00_101_000; in=5;print_reg();#10 instr=8'b00_110_000; in=6;print_reg();
    #10 instr=8'b00_111_000; in=7;print_reg();
    
    #10 instr=8'b00_000_011; //R3 --> Out
    print_reg();
    #10 instr=8'b00_001_111; //R7 --> R1
    print_reg();
    #10 instr=8'b01_010_100; //R7 <-- R2 + R4
    #10;
    print_reg();
    #10 instr=8'b00_000_111; //R7 --> Out
    print_reg();
    #10 instr=8'b01_101_001; //R7 <-- R1 + R5
    #10;
    print_reg();
    #10 instr=8'b00_000_111; //R7 --> Out
    print_reg();
    #10 instr=8'b00_011_101;//R5 --> R3
    print_reg();
    #20 
    $finish;
    
end

task print_reg;
begin
    $monitor($time," : R1=%d R2=%d R3=%d R4=%d R5=%d R6=%d R7=%d Out=%d",
    DUT.RB.loop[1].R.q,
    DUT.RB.loop[2].R.q,
    DUT.RB.loop[3].R.q,
    DUT.RB.loop[4].R.q,
    DUT.RB.loop[5].R.q,
    DUT.RB.loop[6].R.q,
    DUT.RB.loop[7].R.q,
    out);
    $display("\n");
end
endtask

endmodule
