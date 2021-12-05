module draw_game(
    input rst_i,
    input clk_i,
    input rst_cpu,
    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,       // vertical sync output
    output wire [3:0] VGA_R,    // 4-bit VGA red output
    output wire [3:0] VGA_G,    // 4-bit VGA green output
    output wire [3:0] VGA_B     // 4-bit VGA blue output
    );
    
    wire clk_line;
    wire clk_lfsr;
    wire rst_display = ~rst_cpu; // flip vga reset for display (active low on artix board)
    wire [639:0] line0_int, line1_int, line2_int, line3_int;
    wire line0_region, line1_region, line2_region, line3_region;
    reg all_lines_region;
        
    wire [9:0] display_x; // current pixel x position: 10-bit value: 0-1023
    wire [8:0] display_y; // current pixel y position:  9-bit value: 0-511
    reg [15:0] cnt;
    reg pix_stb;
    
    localparam LINE_WIDTH = 18;
    localparam LINE_INC = 142;
    localparam LINE_0_LOC = LINE_WIDTH/2 - 1; // line midpoint location in pixels
    localparam LINE_1_LOC = LINE_0_LOC + LINE_INC; // line midpoint location in pixels
    localparam LINE_2_LOC = LINE_1_LOC + LINE_INC; // line midpoint location in pixels
    localparam LINE_3_LOC = LINE_2_LOC + LINE_INC; // line midpoint location in pixels

        
    // set line speed of 240 pix/s
    clock_divider #(.CLK_O_SPEED(240)) clk_240hz(
        .rst_i(rst_i),
        .clk_i(clk_i),
        .clk_o(clk_line)
    );
    
    clock_divider #(.CLK_O_SPEED(3)) clk_rand(
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
    
    line_generate #(.seed(0)) gen_line_0(
         .clk_i(clk_line),
         .clk_lfsr(clk_lfsr),
         .en_i(1'b1),
         .reset_i(rst_i),
         .line_o(line0_int)
    );
    
    line_generate #(.seed(1)) gen_line_1(
         .clk_i(clk_line),
         .clk_lfsr(clk_lfsr),
         .en_i(1'b1),
         .reset_i(rst_i),
         .line_o(line1_int)
    );
    
    line_generate #(.seed(2)) gen_line_2(
         .clk_i(clk_line),
         .clk_lfsr(clk_lfsr),
         .en_i(1'b1),
         .reset_i(rst_i),
         .line_o(line2_int)
    );
    
    line_generate  #(.seed(3)) gen_line_3(
         .clk_i(clk_line),
         .clk_lfsr(clk_lfsr),
         .en_i(1'b1),
         .reset_i(rst_i),
         .line_o(line3_int)
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
              
    always @(*) begin
        all_lines_region = line0_region | line1_region | line2_region | line3_region; // add all lines here
    end // always
    
    // assign VGA outputs
    assign VGA_R[3] = all_lines_region;
endmodule
