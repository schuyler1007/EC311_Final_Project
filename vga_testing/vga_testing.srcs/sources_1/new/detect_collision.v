`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2021 01:16:57 AM
// Design Name: 
// Module Name: detect_collision
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


module detect_collision
    #(parameter PlayerHeight = 60,
      parameter PlayerWidth = 40,
      parameter PlayerOffset = 0,
      parameter LineWidth = 18,
      parameter LineLoc0 = 35,
      parameter LineLoc1 = 177,
      parameter LineLoc2 = 319,
      parameter LineLoc3 = 461) (
    input [8:0] y_i,
    input grv_i,
    input [639:0] line0_i,
    input [639:0] line1_i,
    input [639:0] line2_i,
    input [639:0] line3_i,
    output reg collision_o
    );
    
    localparam Line1Top = LineLoc1 - LineWidth/2;
    localparam Line2Top = LineLoc2 - LineWidth/2;
    localparam Line3Top = LineLoc3 - LineWidth/2;
    localparam Line0Bottom = LineLoc0 + LineWidth/2;
    localparam Line1Bottom = LineLoc1 + LineWidth/2;
    localparam Line2Bottom = LineLoc2 + LineWidth/2;
    
    localparam X_left = PlayerOffset;
    localparam X_right = PlayerOffset + PlayerWidth;
    
    always @(*) begin
        collision_o = 1'b0;
        
        if (grv_i == 1'b1) begin
            if (y_i + PlayerHeight == Line1Top && (line1_i[X_left] || line1_i[X_right])||
                y_i + PlayerHeight == Line2Top && (line2_i[X_left] || line2_i[X_right])||
                y_i + PlayerHeight == Line3Top && (line3_i[X_left] || line3_i[X_right])) begin
                collision_o = 1'b1;
            end
        end
        else if (grv_i == 1'b0) begin
            if (y_i == Line0Bottom && (line0_i[X_left] || line0_i[X_right])||
                y_i == Line1Bottom && (line1_i[X_left] || line1_i[X_right])||
                y_i == Line2Bottom && (line2_i[X_left] || line2_i[X_right])) begin
                collision_o = 1'b1;
            end
        end
    end
    
endmodule
