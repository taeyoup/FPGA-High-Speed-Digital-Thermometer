`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/16 19:10:49
// Design Name: 
// Module Name: Hex2Dec
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


module Hex2Dec(
input [31:0] iHex,

output [3:0] oDec_H,
output [3:0] oDec_L
    );

reg [3:0] rDec_H;
reg [3:0] rDec_L;

always@(*) begin
    rDec_H <= (iHex / 10) % 10;
    rDec_L <= iHex % 10;
end

assign oDec_H = rDec_H;
assign oDec_L = rDec_L;

endmodule
