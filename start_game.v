`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2021 04:17:50 PM
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


module start_game(reset, start, p1_i, p2_i, p3_i, p4_i, p1_o, p2_o, p3_o, p4_o, enable_board);
    input      start, reset;
    input      p1_i, p2_i, p3_i, p4_i;
    output reg p1_o, p2_o, p3_o, p4_o, enable_board;
    
    reg        lock;
    
    always @ (*) begin
        if (reset==0) begin
            lock = 0;
            enable_board = 0;
        end
        else if (start==1) begin
            lock = 1;
            enable_board = 1;
        end
        
        if (lock==0) begin
            p1_o = p1_i;
            p2_o = p2_i;
            p3_o = p3_i;
            p4_o = p4_i;
        end   
    end
endmodule
