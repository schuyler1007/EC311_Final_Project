`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2021 10:42:23 AM
// Design Name: 
// Module Name: dead
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

// 1 means player is dead, 0 means player is not dead;
// dead if top height<10 or >420 
module dead(player_en, height, is_dead);
    input player_en;
    input [8:0] height;
    output reg is_dead;
    
    always @ (*) begin
        if (player_en == 0)  // player disabled takes first priority
            is_dead = 1'b1;
        else
            is_dead = (height<10 | height>420)? 1'b1 : 1'b0;
    end
endmodule
