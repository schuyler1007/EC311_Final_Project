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
    # (parameter GapWidth = 80) (
    input clk_i,
    input rst_i,
    output reg [639:0] line_o
    );
    
    reg [8:0] pix_count = 9'b0;
    wire rand_pix;
    
    randbit randbit_0(
        .rst_i(rst_i),
        .clk_i(clk_i),
        .rand_o(rand_pix)
    );
    
    always@(posedge clk_i or negedge rst_i) begin
        if (rst_i == 0) begin
            line_o <= {640{1'b0}};
        end else begin
            pix_count = pix_count + 1'b1;
            if (pix_count == GapWidth) begin
                line_o = {
            end
        end
    end
endmodule
