`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2021 07:05:34 PM
// Design Name: 
// Module Name: LFSR_10bit
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
    # (parameter Seed = 0) (
    input clk_i,
    input rst_i,
    input en_i,
    output reg rand_o
    );
    
    reg next_bit1, next_bit2;
    reg [7:0] next_lfsr;
    
    always @(posedge clk_i or negedge rst_i) begin
        if (rst_i == 1'b0) begin
            next_lfsr <= Seed;
        end else if (en_i == 1'b1) begin
            next_lfsr <= {next_lfsr[5:0], next_bit1, next_bit2};
        end
    end
    
    always@(*) begin
        next_bit1 = next_lfsr[7] ^~ next_lfsr[5] ^~ next_lfsr[4] ^~ next_lfsr[3];
        next_bit2 = next_lfsr[6] ^~ next_lfsr[4] ^~ next_lfsr[3] ^~ next_lfsr[2];
        if ({next_bit1, next_bit2} == 2'b00) begin
            rand_o = 0;
        end else begin
            rand_o = 1;
        end
    end
endmodule
