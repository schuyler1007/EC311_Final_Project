`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2021 06:51:20 PM
// Design Name: 
// Module Name: line_generate
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


module line_generate(reset_i, clk_i, en_i, line_o);
    input reset_i, clk_i, en_i;
    output [639:0] line_o;
    wire rand_num;
    reg [639:0] cs = {640{1'b1}}, ns = {640{1'b1}};
    reg [6:0] count = 0;
    reg new_bit = 1;
    
    LFSR rn(.clk_i(clk_i), .en_i(en_i), .nextbit(rand_num));

    always@(posedge clk_i or negedge reset_i) begin
        if (reset_i==0) begin
            cs <= 0;
            ns <= 0;
            count <= 0;
            new_bit <= 0;
        end else begin
            cs <= ns;
            count <= count + 1;
             if (count == 80) begin
                new_bit <= rand_num;
                count <= 0;
            end else begin
              ns <= {new_bit, cs[638:0]};  
            end
        end
    end // always

//    always@(*) begin
//        if (count == 80) begin
//            new_bit <= rand_num;
//            count <= 0;
//        end else
//            ns <= {new_bit, cs[638:0]};
//    end // always
    
       assign line_o = cs;
endmodule