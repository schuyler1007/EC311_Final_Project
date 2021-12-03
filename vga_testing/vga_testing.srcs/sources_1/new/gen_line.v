`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2021 10:04:57 PM
// Design Name: 
// Module Name: gen_line
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


module gen_line(
    input clk_i,
    input rst_i,
    output reg [639:0] line_o
    );
    
    always@(posedge clk_i or negedge rst_i) begin
        if (rst_i == 0) begin
            line_o <= 640'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
        end else begin
            if (line_o == 640'h0)
                line_o <= 640'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
            else
                line_o <= line_o >> 1'b1;
        end
    end
endmodule
