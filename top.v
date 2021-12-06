`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2021 04:36:11 PM
// Design Name: 
// Module Name: top
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


module top(clk, reset, start, p1_en, p2_en, p3_en, p4_en, p1_toggle, p2_toggle, p3_toggle, p4_toggle);
    input clk, reset, start;
    input p1_en, p2_en, p3_en, p4_en;                       // switches to enable each player
    input p1_toggle, p2_toggle, p3_toggle, p4_toggle;       // buttons to toggle each player's gravity
    
    wire         p1_play, p2_play, p3_play, p4_play;        // players are in play
    wire         p1_grav, p2_grav, p3_grav, p4_grav;        // debounced  toggling gravity buttons
    wire [8:0]   h_1, h_2, h_3, h_4;                        // heights of players
    wire         gv_1, gv_2, gv_3, gv_4;                    // gravity directions of players
    wire         dead_1, dead_2, dead_3, dead_4;            // if each player is dead/out of game
    wire         enable_board;                              // whether to start changing the lines
    wire         clk_80Hz, clk_1Hz;                         // 80 Hz clock, 1 Hz clock
    wire         p1_lines, p2_lines, p3_lines, p4_lines;    // existence of lines at player x-coordinates
    wire [639:0] ground_bottom, ground_middle, ground_top;  // lines
    
    // debounce gravity toggle inputs
    debouncer                 p1_gravity  (.clk_i(clk), .reset_i(reset), .buttonin_i(p1_toggle), .buttonout_o(p1_grav));
    debouncer                 p2_gravity  (.clk_i(clk), .reset_i(reset), .buttonin_i(p2_toggle), .buttonout_o(p2_grav));
    debouncer                 p3_gravity  (.clk_i(clk), .reset_i(reset), .buttonin_i(p3_toggle), .buttonout_o(p3_grav));
    debouncer                 p4_gravity  (.clk_i(clk), .reset_i(reset), .buttonin_i(p4_toggle), .buttonout_o(p4_grav));
    
    // get slower clock2
    clock_divider #(.CLK_O_SPEED(80)) Hz_80 (.clk_i(clk), .rst_i(reset), .clk_o(clk_80Hz));
    clock_divider #(.CLK_O_SPEED(1)) Hz_80 (.clk_i(clk), .rst_i(reset), .clk_o(clk_1Hz));
    
    start_game                lock_players(.reset(reset), .start(start), .p1_i(p1_en), .p2_i(p2_en), .p3_i(p3_en), .p4_i(p4_en), .p1_o(p1_play), .p2_o(p2_play), .p3_o(p3_play), .p4_o(p4_play), .enable_board(enable_board));
    
    // player 1
    dead                      player1_dead (.reset(reset), .in_game(p1_play), .height(h_1), .is_dead(dead_1));
    gavity_direction          gravity1     (.clk(clk_80Hz), .reset(reset), .is_dead(dead_1), .switch(p1_grav), .lines(p1_lines), .height(h_1), .dir(gv_1));
    move_player               move1        (.clk(clk_80Hz), .reset(reset), .grav_dir(gv_1), .is_dead(dead_1), .lines(p1_lines), .height(h_1));

    // player 2
    dead                      player2_dead (.reset(reset), .in_game(p2_play), .height(h_2), .is_dead(dead_2));
    gavity_direction          gravity2     (.clk(clk_80Hz), .reset(reset), .is_dead(dead_2), .switch(p2_grav), .lines(p2_lines), .height(h_2), .dir(gv_2));
    move_player               move2        (.clk(clk_80Hz), .reset(reset), .grav_dir(gv_2), .is_dead(dead_2), .lines(p2_lines), .height(h_2));

    // player 3
    dead                      player3_dead (.reset(reset), .in_game(p3_play), .height(h_3), .is_dead(dead_3));
    gavity_direction          gravity3     (.clk(clk_80Hz), .reset(reset), .is_dead(dead_3), .switch(p3_grav), .lines(p3_lines), .height(h_3), .dir(gv_3));
    move_player               move3        (.clk(clk_80Hz), .reset(reset), .grav_dir(gv_3), .is_dead(dead_3), .lines(p3_lines), .height(h_3));

    // player 4
    dead                      player4_dead (.reset(reset), .in_game(p4_play), .height(h_4), .is_dead(dead_4));
    gavity_direction          gravity4     (.clk(clk_80Hz), .reset(reset), .is_dead(dead_4), .switch(p4_grav), .lines(p4_lines), .height(h_4), .dir(gv_4));
    move_player               move4        (.clk(clk_80Hz), .reset(reset), .grav_dir(gv_4), .is_dead(dead_4), .lines(p4_lines), .height(h_4));

//    //generate lines (change later)
//    line_generate #(.seed(0)) top         (.clk(clk_80Hz), .reset(reset), .enable_board(enable_board), .line_o(ground_top));
//    line_generate #(.seed(4)) middle      (.clk(clk_80Hz), .reset(reset), .enable_board(enable_board), .line_o(ground_middle));
//    line_generate #(.seed(2)) bottom      (.clk(clk_80Hz), .reset(reset), .enable_board(enable_board), .line_o(ground_bottom));
//    
//    // existance of lines at each player's x coordinate
//    assign p1_lines = {ground_bottom[20], ground_middle[20], ground_top[20]};
//    assign p2_lines = {ground_bottom[70], ground_middle[70], ground_top[70]};
//    assign p3_lines = {ground_bottom[110], ground_middle[110], ground_top[110]};
//    assign p4_lines = {ground_bottom[160], ground_middle[160], ground_top[160]};
endmodule
