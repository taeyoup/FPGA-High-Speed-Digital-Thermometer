`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: DigilentInc
// Engineer: Arthur Brown
// 
// Create Date: 09/22/2016 09:58:43 AM
// Module Name: ad1_spi
// Project Name: PmodAD1 IP
// Description: SPI Controller, continuously polls the AD1 SPI.
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mySPI (
    clk,
    reset,
    sdin0,
    sdin1,
    cs,
    sclk,
    dout0,
    dout1,
    w_dout_valid
);

    input clk;
    input reset;
    input sdin0;
    input sdin1;
    output cs;
    output sclk;
    output reg [15:0] dout0 = 0;
    output reg [15:0] dout1 = 0;
    
    output w_dout_valid;
    
    localparam state0 = 0; // Reset & Time Delay
    localparam state1 = 1; // Filling Data[15:0]
    localparam state2 = 2; // Data Transfer
    
    reg [1:0] state;
    reg [16:0] cnt0;
    reg [16:0] cnt1;
    reg r_cs;
    reg r_sclk;
    reg [15:0] r_dout0;
    reg [15:0] r_dout1;
    reg dout_valid;
    
    assign cs = r_cs;
    assign sclk = r_sclk;
    assign w_dout_valid = dout_valid;
   
    always@(posedge r_sclk) begin
        if (!r_cs) begin
        r_dout0 <= {r_dout0[14:0] , sdin0}; // Filling Data
        r_dout1 <= {r_dout1[14:0] , sdin1}; // Filling Data
        end
        else begin
        r_dout0 <= r_dout0;
        r_dout1 <= r_dout1;
        end
    end
    
    always@(posedge clk or negedge reset) begin
        if (!reset) begin
            state <= 0;
            dout0 <= 0;
            dout1 <= 0;
            cnt0  <= 0;
            cnt1  <= 0;
            r_cs  <= 1;
        end
        
        else begin
            case (state)
                state0 : if (cnt0 < 300) begin
                            cnt0 <= cnt0 + 1;
                         end
                         
                         else begin // cnt0 == 300, GO state1
                            cnt0  <= 0;
                            cnt1  <= 0;
                            r_cs  <= 0; // cs
                            state <= state1;
                            
                         end
                         
                state1 : if (cnt0 < 20) begin // for Time Delay
                            cnt0 <= cnt0 + 1;
                            r_sclk <= 1;
                         end
                         
                         else begin // cnt0 == 20
                            cnt0 <= 0;
                            if (cnt1 < 16) begin
                                cnt1 <= cnt1 + 1;
                                r_sclk <= 0;
                                
                            end
                            else begin // cnt1 == 16, Go State2
                                dout0 <= r_dout0;
                                dout1 <= r_dout1;
                                r_sclk <= 1;
                                cnt0 <= 0;
                                dout_valid <= 1;
                                state <= state2;
                            end
                         end
                         
                state2 : if (cnt0 < 100) begin 
                            cnt0 <= cnt0 + 1;
                         end
                         
                         else begin // Go state0
                            cnt0 <= 0;
                            r_cs <= 1;
                            dout_valid <= 0;
                            state <= state0;
                         end
                
                default : state <= state0;
            endcase
        end
    end
        
endmodule