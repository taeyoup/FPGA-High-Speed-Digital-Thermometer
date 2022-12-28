`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/09 20:16:07
// Design Name: 
// Module Name: FND
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


module FND(
input           inReset,
input           iCLK,

input   [6:0]   iSegH,
input   [6:0]   iSegL,


output          oSel,
output  [6:0]   oSeg
);

reg [31:0] rTCnt;
reg        rSel;

always@(posedge iCLK) begin
    if(~inReset) begin
        rTCnt <= 32'b0;
        rSel <= 1'b0;
    end
    
    else begin
        if(rTCnt[31:0] < 32'd100_000) begin
           rTCnt[31:0] <= rTCnt[31:0] + 32'b1;
        end
        else begin
            rTCnt[31:0] <= 0;
            rSel <= ~rSel;
        end
    end
end
        


assign oSel = rSel;
assign oSeg[6:0] = (rSel) ? iSegH[6:0] : iSegL[6:0];

endmodule
