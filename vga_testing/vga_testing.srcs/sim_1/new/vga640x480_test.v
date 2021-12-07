`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2021 06:17:33 PM
// Design Name: 
// Module Name: vga640x480_test
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


module vga640x480_test(
    );
    reg clk_i;
    wire [9:0] display_x;
    wire [8:0] display_y;
    wire VGA_HS_O, VGA_VS_O;
    reg pix_stb;
    reg [15:0] cnt;
    reg rst_display;
    
     vga640x480 display(
        .i_clk(clk_i),
        .i_pix_stb(pix_stb),
        .i_rst(rst_display),
        .o_hs(VGA_HS_O), 
        .o_vs(VGA_VS_O), 
        .o_x(display_x), 
        .o_y(display_y)
    );
    initial begin
        clk_i = 1'b0;
        cnt = 0;
        rst_display = 1'b1;
        #10 rst_display = 1'b0;
    end
    
    always @(posedge clk_i) begin
        {pix_stb, cnt} <= cnt + 16'h4000; // divide by 4: (2^16)/4 = 0x4000
    end
    
    always begin
        #1 clk_i = ~clk_i;
    end
endmodule
