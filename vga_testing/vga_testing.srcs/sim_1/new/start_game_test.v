`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2021 09:44:38 PM
// Design Name: 
// Module Name: start_game_test
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


module start_game_test(

    );
    reg clk_i;
    reg rst_i;
    reg NEW_GAME_BTN;
    wire lines_type_int;
    
    start_game #(.WaitStart(100)) start(
        .rst_i(rst_i),
        .clk_i(clk_i),
        .new_game_i(NEW_GAME_BTN),
        .line_type_o(lines_type_int)
    );
    
    initial begin
        rst_i = 1'b0;
        clk_i = 1'b0;
        NEW_GAME_BTN = 1'b0;
        #10 rst_i = 1'b1;
    end
    
    always begin
        #1 clk_i = ~clk_i;
    end
    
    always begin
        #1000 NEW_GAME_BTN = ~NEW_GAME_BTN;
    end
    
endmodule
