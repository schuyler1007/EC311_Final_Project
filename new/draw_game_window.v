`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2021 10:51:59 AM
// Design Name: 
// Module Name: draw_game_window
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


module draw_game_window 
    #(parameter WindowHeight = 480, 
      parameter WindowWidth = 640) (
    input [9:0] x_i,
    input [8:0] y_i,
    output region_o
    );
    
    assign region_o = ((x_i > 0) & (x_i < WindowWidth) & (y_i > 0) & (y_i < WindowHeight)) ? 1 : 0;
endmodule
