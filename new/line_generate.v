`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2021 06:51:20 PM
// Design Name: 
// Module Name: line_generate
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


module line_generate #(parameter seed = 0) (reset_i, clk_i, clk_lfsr, en_i, line_o, rand_num);
    input clk_i, reset_i, en_i, clk_lfsr;
    output reg [639:0] line_o;
    output wire rand_num;
    
    LFSR #(.seed(seed)) rn(.clk_i(clk_lfsr), .en_i(en_i), .nextbit(rand_num));
    
    always@(posedge clk_i or negedge reset_i) begin
        if (reset_i == 0) begin
            line_o <= {640{1'b1}};
        end else begin
            if (line_o == {640{1'b0}})
                line_o <= {640{1'b1}};
            else begin
                line_o <= {rand_num, line_o[639:1]};
            end
        end
    end
endmodule