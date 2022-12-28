`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/16 19:23:08
// Design Name: 
// Module Name: tb_Hex2Dec
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


module tb_Hex2Dec;
reg [31:0] iHex; // limit 0x63

wire [3:0] oDec_H;
wire [3:0] oDec_L;

Hex2Dec Dut(
.iHex(iHex),
.oDec_H(oDec_H),
.oDec_L(oDec_L)
);


initial begin
#100 iHex = 32'b0000_0000_0000_0000_0000_0000_0001_0011; // 0x13 = 0d19
end

endmodule
