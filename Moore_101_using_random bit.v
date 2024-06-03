`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2024 19:00:41
// Design Name: 
// Module Name: moorey
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

module rand(clk,out);
output reg out;
input clk;
always @(posedge clk)
begin
out=$urandom;
//$display("%b",out);
end
endmodule

module moorey_101(x,clk,rst,out);
input clk,rst,x;
output reg out;
reg [1:0]state=2'b00;

always @(posedge clk,posedge rst)
begin
if(rst)
out=0;
else
case(state)
0:begin
out=0;
if(x==1)
state=1;
end
1:begin
out=0;
if(x==0)
state=2;
end
2:begin
out=0;
if(x==0)
state=0;
else
state=3;
end
3:begin
out=1;
if(x==1)
state=1;
else
state=2;
end
endcase
end
endmodule

module test;
reg clk,rst;
wire bitg;
wire out;
rand r1(clk,bitg);
moorey_101 x1(bitg,clk,rst,out);
initial
begin
clk=0;rst=1; #10
rst=0; #100
rst=1;#10
$stop;
end
initial
#150 $stop;

always #1.5 clk=~clk;
endmodule
