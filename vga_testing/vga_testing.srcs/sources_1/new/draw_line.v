`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2021 11:49:10 AM
// Design Name: 
// Module Name: draw_line
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


module draw_line 
    # (parameter LineMidpointLoc = 0, 
       parameter LineWidth = 1) (
    input [639:0] line_i,
    input [9:0] x_i,
    input [8:0] y_i,
    output region_o    
    );
   assign region_o = ((line_i[x_i] == 1) &
                      (y_i >= LineMidpointLoc - LineWidth/2) &
                      (y_i < LineMidpointLoc + LineWidth/2)) ? 1 : 0;
endmodule
