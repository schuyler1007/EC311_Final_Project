`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2021 03:03:41 PM
// Design Name: 
// Module Name: line_generate_test
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


module line_generate_test();
    reg clk_i, reset_i;
    wire [639:0] out_o;
    
    line_generate lg(.clk_i(clk_i),.reset_i(reset_i), .en_i(1'b1), .line_o(out_o));
    
    initial begin
        clk_i = 0;
        #10 reset_i = 0;
        reset_i = 1;
    end
    
    always begin
        #1 clk_i = ~clk_i;
    end
   
endmodule
