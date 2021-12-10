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


module gen_line
    # (parameter GapWidth = 80, parameter Seed = 0, parameter prob = 64) (
    input clk_line,
    input clk_lfsr,
    input rst_i,
    input line_type_i,
    output reg [639:0] line_o
    );
    
    wire rand_pix;
    
    lfsr #(.Seed(Seed), .prob(prob)) lfsr_o(
        .rst_i(rst_i),
        .clk_i(clk_lfsr),
        .en_i(1'b1),
        .rand_o(rand_pix)
    );
    
    always@(posedge clk_line or negedge rst_i) begin
        if (rst_i == 0) begin
            line_o <= {640{1'b1}};
        end else begin
            if (line_type_i == 1'b0) begin
                line_o <= {640{1'b1}};
            end else begin
                line_o <= {rand_pix, line_o[639:1]};
            end
        end
    end // always
endmodule
