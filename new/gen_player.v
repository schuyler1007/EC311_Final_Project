`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2021 11:08:10 PM
// Design Name: 
// Module Name: gen_player
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


module gen_player
    #(parameter PlayerHeight = 60,
      parameter PlayerWidth = 40,
      parameter PlayerOffset = 0,
      parameter LineWidth = 18,
      parameter LineLoc0 = 35,
      parameter LineLoc1 = 177,
      parameter LineLoc2 = 319,
      parameter LineLoc3 = 461) (
    input rst_i,
    input restart_game,
    input clk_i,
    input player_en_i,
    input grv_i,
    input [639:0] line0_i,
    input [639:0] line1_i,
    input [639:0] line2_i,
    input [639:0] line3_i,
    output reg [8:0] luc_loc_o
    );
    wire collision_int;
    reg grv_player;

    detect_collision #(.PlayerHeight(PlayerHeight),
                   .PlayerWidth(PlayerWidth),
                   .PlayerOffset(PlayerOffset),
                   .LineWidth(LineWidth),
                   .LineLoc0(LineLoc0),
                   .LineLoc1(LineLoc1),
                   .LineLoc2(LineLoc2),
                   .LineLoc3(LineLoc3)) collision(            
            .y_i(luc_loc_o),
            .grv_i(grv_player),
            .line0_i(line0_i),
            .line1_i(line1_i),
            .line2_i(line2_i),
            .line3_i(line3_i),
            .collision_o(collision_int)
        );
    
    always @(posedge clk_i or negedge rst_i) begin
        if (rst_i == 1'b0 || restart_game == 1'b1) begin
            luc_loc_o = LineLoc2 - (LineWidth / 2) - PlayerHeight;
            grv_player = 1'b1; // down
        end else begin 
            if (luc_loc_o<480) begin
                if (collision_int == 1'b0) begin
                    if (grv_player == 1'b0) begin
                        luc_loc_o = luc_loc_o - 1'b1;
                    end if (grv_player == 1'b1) begin
                        luc_loc_o = luc_loc_o + 1'b1;
                    end
                end if (collision_int == 1'b1 && grv_i == 1'b1) begin
                grv_player = ~grv_player;
                end
            end
        end
    end   
endmodule
