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


module start_game #(parameter WaitStart = 1000) (
    input clk_i,
    input rst_i,
    input new_game_i,
    output reg line_type_o
    );
    
    reg clk_start; // btn_start;
    reg start_wait;
    reg[31:0] wait_count;
    
    
    //TODO: if we do not want game to automatically restart, need to add debouncer and 1-bit counter
    
    always @(posedge clk_i or negedge rst_i) begin
        if (rst_i == 1'b0) begin
            line_type_o <= 1'b0;
            wait_count <= 32'b0;
            start_wait <= 1'b0;
        end else begin
            if (new_game_i == 1'b1) begin
                start_wait <= 1'b1;
                line_type_o <= 1'b0;
            end else if (start_wait == 1'b1) begin
                wait_count <= wait_count + 1'b1;
            end if (wait_count == WaitStart * 100000) begin
                line_type_o <= 1'b1;
                wait_count <= 32'b0;
                start_wait <= 1'b0;
            end
        end
    end // always
endmodule
