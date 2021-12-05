//draft of top using backend testbench as template
module top();
    reg clk, reset, enter_game, switch, start_game;
    wire in_game, enable_board, is_dead, dir;
    wire p1_i, p2_i, p3_i, p4_i, p1_o, p2_o, p3_o, p4_o;
    reg [2:0] lines;
    wire [8:0] height;
    wire [639:0] ground_top, ground_middle, ground_bottom;
    
    start_game                lock_player (reset, start_game, enter_game, p2_i, p3_i, p4_i, in_game, p2_o, p3_o, p4_o, enable_board);
    dead                      player_dead (reset, in_game, height, is_dead);
    gavity_direction          gravity     (clk, reset, is_dead, switch, lines, height, dir);
    move_player               move        (reset, clk, dir, is_dead, lines,  height);
    
    line_generate #(.seed(0)) top         (reset, clk, enable_board, ground_top);
    line_generate #(.seed(4)) middle      (reset, clk, enable_board, ground_middle);
    line_generate #(.seed(2)) bottom      (reset, clk, enable_board, ground_bottom);
    
    initial begin
        clk=0;
        enter_game=0;
        start_game=0;
        switch=0;
        reset=0; 
        #1 reset=1;
    end
    
    always @(*) begin
        lines = {ground_bottom[20], ground_middle[20], ground_top[20]};
    end
  
endmodule
