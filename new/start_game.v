`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2021 07:40:10 PM
// Design Name: 
// Module Name: start_game
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


module start_game
    #(parameter WaitStart = 1000) (
    input clk_i,
    input rst_i,
    input new_game_i,
    input [3:0] player_en,
    output reg line_type_o,
    output reg [3:0] active_players
    );
    
    reg clk_start; // btn_start;
    reg start_wait;
    reg[31:0] wait_count;
    reg waiting_room;
    
    //TODO: if we do not want game to automatically restart, need to add debouncer and 1-bit counter
    
    always @(posedge clk_i or negedge rst_i) begin
        if (rst_i == 1'b0) begin
            waiting_room = 1'b1;  // reset has been pressed
            line_type_o <= 1'b0;
            wait_count <= 32'b0;
            start_wait <= 1'b0;
            active_players <= player_en;
        end else begin
            // need to add condition where nothing is happening
            // should be able to enable/disable players after reset
            if (waiting_room == 1'b1) begin
                active_players <= player_en;
            end
            if (new_game_i == 1'b1) begin
                waiting_room = 1'b0;  // exit waiting room
                start_wait <= 1'b1;
                line_type_o <= 1'b0;
                active_players <= player_en;
            end else if (start_wait == 1'b1) begin  // countdown period
                wait_count <= wait_count + 1'b1;
                active_players <= player_en;  // can still add/remove players before game start
            end if (wait_count == WaitStart * 100000) begin
                line_type_o <= 1'b1;
                wait_count <= 32'b0;
                start_wait <= 1'b0;
            end
        end
    end // always
endmodule
