`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2021 06:52:42 PM
// Design Name: 
// Module Name: draw_game
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


module draw_game(
    input rst_i,
    input clk_i,
    input NEW_GAME_BTN,
    input [3:0] GRV_BTN,
    input [3:0] PLAYER_EN,
    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,       // vertical sync output
    output wire [3:0] VGA_R,    // 4-bit VGA red output
    output wire [3:0] VGA_G,    // 4-bit VGA green output
    output wire [3:0] VGA_B     // 4-bit VGA blue output
    );
    
    wire clk_line, clk_lfsr, clk_player;
    wire rst_display = ~rst_i; // flip vga reset for display (active low on artix board)
    wire lines_type_int;
    wire [639:0] line0_int, line1_int, line2_int, line3_int;
    wire line0_region, line1_region, line2_region, line3_region;
    wire all_lines_region;
    
    wire player0_region, player1_region, player2_region, player3_region;
    wire [8:0] player0_int, player1_int, player2_int, player3_int;
    
    wire [9:0] display_x; // current pixel x position: 10-bit value: 0-1023
    wire [8:0] display_y; // current pixel y position:  9-bit value: 0-511
    reg [15:0] cnt;
    reg pix_stb;
    
    localparam GAP_WIDTH = 80;
    localparam LINE_SPEED = 180;
    localparam LINE_WIDTH = 18;
    localparam LINE_INC = 148;
    localparam LINE_0_LOC = 18 - 1; // line midpoint location in pixels
    localparam LINE_1_LOC = LINE_0_LOC + LINE_INC; // line midpoint location in pixels
    localparam LINE_2_LOC = LINE_1_LOC + LINE_INC; // line midpoint location in pixels
    localparam LINE_3_LOC = LINE_2_LOC + LINE_INC; // line midpoint location in pixels
    
    localparam PLAYER_HEIGHT = 60;
    localparam PLAYER_WIDTH = 40;
    localparam PLAYER_GAP = 20;
    localparam PLAYER_SPEED = 180;
    localparam PLAYER_0_OFFSET = 16;
    localparam PLAYER_1_OFFSET = PLAYER_0_OFFSET + PLAYER_WIDTH + PLAYER_GAP;
    localparam PLAYER_2_OFFSET = PLAYER_1_OFFSET + PLAYER_WIDTH + PLAYER_GAP;
    localparam PLAYER_3_OFFSET = PLAYER_2_OFFSET + PLAYER_WIDTH + PLAYER_GAP;
    
    start_game #(.WaitStart(3000)) start(
        .rst_i(rst_i),
        .clk_i(clk_i),
        .new_game_i(NEW_GAME_BTN),
        .line_type_o(lines_type_int)
    );
    
    clock_divider #(.CLK_O_SPEED(LINE_SPEED)) clk_div_line(
        .rst_i(rst_i),
        .clk_i(clk_i),
        .clk_o(clk_line)
    );
    
    clock_divider #(.CLK_O_SPEED(PLAYER_SPEED)) clk_div_player(
        .rst_i(rst_i),
        .clk_i(clk_i),
        .clk_o(clk_player)
    );
    
    clock_divider #(.CLK_O_SPEED(LINE_SPEED / GAP_WIDTH)) clk_div_lfsr(
        .rst_i(rst_i),
        .clk_i(clk_i),
        .clk_o(clk_lfsr)
    );
    
    // generate a 25 MHz pixel strobe
    always @(posedge clk_i) begin
        {pix_stb, cnt} <= cnt + 16'h4000; // divide by 4: (2^16)/4 = 0x4000
    end
    
     vga640x480 display(
        .i_clk(clk_i),
        .i_pix_stb(pix_stb),
        .i_rst(rst_display),
        .o_hs(VGA_HS_O), 
        .o_vs(VGA_VS_O), 
        .o_x(display_x), 
        .o_y(display_y)
    );
    
    gen_line #(.Seed(0)) gen_line_0(
         .clk_line(clk_line),
         .clk_lfsr(clk_lfsr),
         .rst_i(rst_i),
         .line_o(line0_int),
         .line_type_i(lines_type_int)
    );
    
    gen_line #(.Seed(1)) gen_line_1(
         .clk_line(clk_line),
         .clk_lfsr(clk_lfsr),
         .rst_i(rst_i),
         .line_o(line1_int),
         .line_type_i(lines_type_int)
    );
    
    gen_line #(.Seed(2)) gen_line_2(
         .clk_line(clk_line),
         .clk_lfsr(clk_lfsr),
         .rst_i(rst_i),
         .line_o(line2_int),
         .line_type_i(lines_type_int)
    );
    
    gen_line  #(.Seed(3)) gen_line_3(
         .clk_line(clk_line),
         .clk_lfsr(clk_lfsr),
         .rst_i(rst_i),
         .line_o(line3_int),
         .line_type_i(lines_type_int)
    );
    
    draw_line #(.LineMidpointLoc(LINE_0_LOC),
                .LineWidth(LINE_WIDTH)) draw_line_0(
        .line_i(line0_int),
        .x_i(display_x),
        .y_i(display_y),
        .region_o(line0_region)
    );
    
    draw_line #(.LineMidpointLoc(LINE_1_LOC),
                .LineWidth(LINE_WIDTH)) draw_line_1(
        .line_i(line1_int),
        .x_i(display_x),
        .y_i(display_y),
        .region_o(line1_region)
    );
    
    draw_line #(.LineMidpointLoc(LINE_2_LOC),
                .LineWidth(LINE_WIDTH)) draw_line_2(
        .line_i(line2_int),
        .x_i(display_x),
        .y_i(display_y),
        .region_o(line2_region)
    );
    
    draw_line #(.LineMidpointLoc(LINE_3_LOC),
                .LineWidth(LINE_WIDTH)) draw_line_3(
        .line_i(line3_int),
        .x_i(display_x),
        .y_i(display_y),
        .region_o(line3_region)
    );
    
    gen_player #(.PlayerHeight(PLAYER_HEIGHT),
                 .PlayerWidth(PLAYER_WIDTH),
                 .PlayerOffset(PLAYER_0_OFFSET),
                 .LineWidth(LINE_WIDTH),
                 .LineLoc0(LINE_0_LOC),
                 .LineLoc1(LINE_1_LOC),
                 .LineLoc2(LINE_2_LOC),
                 .LineLoc3(LINE_3_LOC)) gen_player_0(
         .rst_i(rst_i),
         .clk_i(clk_player),
         .line0_i(line0_int),
         .line1_i(line1_int),
         .line2_i(line2_int),
         .line3_i(line3_int),
         .grv_i(GRV_BTN[0]),
         .player_en_i(PLAYER_EN[0]),
         .luc_loc_o(player0_int)
     );
     
     gen_player #(.PlayerHeight(PLAYER_HEIGHT),
                 .PlayerWidth(PLAYER_WIDTH),
                 .PlayerOffset(PLAYER_1_OFFSET),
                 .LineWidth(LINE_WIDTH),
                 .LineLoc0(LINE_0_LOC),
                 .LineLoc1(LINE_1_LOC),
                 .LineLoc2(LINE_2_LOC),
                 .LineLoc3(LINE_3_LOC)) gen_player_1(
         .rst_i(rst_i),
         .clk_i(clk_player),
         .line0_i(line0_int),
         .line1_i(line1_int),
         .line2_i(line2_int),
         .line3_i(line3_int),
         .grv_i(GRV_BTN[1]),
         .player_en_i(PLAYER_EN[1]),
         .luc_loc_o(player1_int)
     );
    
    draw_player #(.PlayerHeight(PLAYER_HEIGHT),
                  .PlayerWidth(PLAYER_WIDTH),
                  .PlayerOffset(PLAYER_0_OFFSET)) draw_player_0(
      .luc_loc_i(player0_int),
      .x_i(display_x),
      .y_i(display_y),
      .region_o(player0_region)
    );
    
    draw_player #(.PlayerHeight(PLAYER_HEIGHT),
                  .PlayerWidth(PLAYER_WIDTH),
                  .PlayerOffset(PLAYER_1_OFFSET)) draw_player_1(
      .luc_loc_i(player1_int),
      .x_i(display_x),
      .y_i(display_y),
      .region_o(player1_region)
    );

    assign all_lines_region = line0_region | line1_region | line2_region | line3_region;
    assign VGA_R[3] = all_lines_region | player0_region;
    assign VGA_G[3] = all_lines_region;
    assign VGA_B[3] = all_lines_region | player1_region;
endmodule
