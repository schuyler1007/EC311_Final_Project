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
    reg clk_i, rst_i;
    wire [639:0] out_o;
    
    gen_line gen_line_0(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .line_o(out_o)
    );
    
    
    
    initial begin
        clk_i = 1'b0;
        rst_i = 1'b0;
        #10 rst_i = 1'b1;
    end
    
    always begin
        #1 clk_i = ~clk_i;
    end
   
endmodule
