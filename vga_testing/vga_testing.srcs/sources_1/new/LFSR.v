`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2021 06:56:46 PM
// Design Name: 
// Module Name: LFSR
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


module LFSR (clk_i, en_i, nextbit);
    input clk_i, en_i;
    output reg nextbit;
    
    reg [7:0] next_LFSR = 8'b0;
//    reg nextbit;

    always@(posedge clk_i) begin
        if (en_i == 1'b1) begin
           next_LFSR <= {next_LFSR[6:0], nextbit}; 
        end
    end // always

    always@(*) begin
        nextbit = next_LFSR[7] ^~ next_LFSR[5] ^~ next_LFSR[4] ^~ next_LFSR[3];
    end // always

//    assign random_num = next_LFSR[7:0];

endmodule
