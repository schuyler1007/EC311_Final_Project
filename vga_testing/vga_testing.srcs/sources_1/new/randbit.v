`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2021 03:49:03 PM
// Design Name: 
// Module Name: randbit
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


module randbit 
    # (parameter Seed = 8'b0) (
    input clk_i,
    input rst_i,
    output reg rand_o
    );
    
    reg [7:0] next_lfsr = 8'b0;
    
    always @(posedge clk_i or negedge rst_i) begin
        if (rst_i == 0) begin
            next_lfsr <= Seed;
        end else begin
            next_lfsr <= {next_lfsr[6:0], rand_o};
            rand_o = next_lfsr[7] ^~ next_lfsr[5] ^~ next_lfsr[4] ^~ next_lfsr[3];
        end
    end
endmodule
