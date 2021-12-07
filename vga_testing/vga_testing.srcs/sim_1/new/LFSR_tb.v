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
    reg rst_i;
    reg en_i;
    wire out_o;
    
    lfsr lfsr_inst(
        .clk_i(clk_i), 
        .en_i(en_i),
        .rst_i(rst_i),
        .rand_o(out_o)
    );
    initial begin
        clk_i = 1'b0;
        rst_i = 1'b0;
        en_i = 1'b1;
        # 10 rst_i = 1'b1;
    end
    
//    always begin
//        #100 en_i = ~en_i;
//    end
    
    always begin
        #10 clk_i <= ~clk_i;
    end

endmodule
