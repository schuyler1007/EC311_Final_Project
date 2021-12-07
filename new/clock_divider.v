`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2021 06:47:54 PM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider
    #(parameter CLK_I_SPEED = 100000000, // 100mhz default
        parameter CLK_O_SPEED = 100000000) ( 
        // hz (must be less than input clock, 100mhz default)
    input clk_i,
    input rst_i,
    output reg clk_o
    );
    
    localparam CLK_O_PERIOD = (CLK_I_SPEED / 2) / CLK_O_SPEED;
    reg [31:0] clk_count_int;
        
    always @ (posedge clk_i or negedge rst_i) begin
        if (rst_i == 1'b0) begin
            clk_count_int <= 32'h0;
            clk_o <= 1'b0;
        end else begin
        clk_count_int <= clk_count_int + 1'b1;
        
        if (clk_count_int == CLK_O_PERIOD) begin // 100mhz base clock
            clk_o <= ~clk_o;
            clk_count_int <= 32'h0;
            end
        end // else
    end // always
endmodule