`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2021 03:01:40 PM
// Design Name: 
// Module Name: LFSR_tb
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


module LFSR_tb();
    reg clk_i;
    wire out_o;
    
    LFSR lfsr_inst(.clk_i(clk_i), .en_i(1'b1), .nextbit(out_o));
    initial begin
        clk_i = 1'b0;
    end
    
    always@(*) begin
        #10 clk_i <= ~clk_i;
    end

endmodule
