`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/10 11:09:08
// Design Name: 
// Module Name: Dec27SegDecoder
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


module Dec27SegDecoder(
    input   [3:0]   iDec,
    
    output  [6:0]   oSeg
    );
    
    reg [6:0] rSeg;
    
    always@(*) begin
        case(iDec)
            4'd0 : rSeg = 7'b111_1110;
            4'd1 : rSeg = 7'b011_0000;
            4'd2 : rSeg = 7'b110_1101;
            4'd3 : rSeg = 7'b111_1001;
            4'd4 : rSeg = 7'b011_0011;
            4'd5 : rSeg = 7'b101_1011;
            4'd6 : rSeg = 7'b101_1111;
            4'd7 : rSeg = 7'b111_0010;
            4'd8 : rSeg = 7'b111_1111;
            4'd9 : rSeg = 7'b111_1011;
        endcase
    end
    
    assign oSeg[6:0] = rSeg[6:0];
    
endmodule
