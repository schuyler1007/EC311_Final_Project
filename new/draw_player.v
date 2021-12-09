`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2021 10:37:11 PM
// Design Name: 
// Module Name: draw_player
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


module draw_player 
    #(parameter PlayerHeight = 60,
      parameter PlayerWidth = 40,
      parameter PlayerOffset = 0) (
    input [8:0] luc_loc_i, // just y-coordinate
    input [9:0] x_i,
    input [8:0] y_i,
    input       player_en_i,
    output region_o
    );
    
    
    assign region_o = ((x_i >= PlayerOffset) &
                       (x_i < PlayerOffset + PlayerWidth) &
                       (y_i >= luc_loc_i) &
                       (y_i < luc_loc_i + PlayerHeight)) ? player_en_i : 0;
endmodule
