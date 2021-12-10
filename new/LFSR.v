`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2021 04:57:39 PM
// Design Name: 
// Module Name: lfsr
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

module lfsr 
    # (parameter Seed = 0, parameter prob = 127) (
    input clk_i,
    input rst_i,
    input en_i,
    output reg rand_o
    );
    
    reg next_bit;
    reg [7:0] next_lfsr;
    
    always @(posedge clk_i or negedge rst_i) begin
        if (rst_i == 1'b0) begin
            next_lfsr <= Seed;
        end else if (en_i == 1'b1) begin
            next_lfsr <= {next_lfsr[6:0], next_bit};
        end
    end
    
    always@(*) begin
        next_bit = next_lfsr[7] ^~ next_lfsr[5] ^~ next_lfsr[4] ^~ next_lfsr[3];
        if (next_lfsr >= prob) begin
            rand_o = 1;
        end else begin
            rand_o = 0;
        end
    end
endmodule
