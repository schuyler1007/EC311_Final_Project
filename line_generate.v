module line_generate #(parameter seed = 0) (reset_i, clk_i, en_i, line_o);
    input reset_i, clk_i, en_i;
    output [639:0] line_o;
    
    wire  rand_num;
    reg [639:0] cs = {640{1'b1}}, ns = {640{1'b1}};
    reg [6:0] count = 0;
    reg new_bit = 1;
    
    LFSR #(.seed(seed)) rn(.clk_i(clk_i), .en_i(en_i), .nextbit(rand_num));

    always@(posedge clk_i or negedge reset_i) begin
        if (reset_i==0) begin
            cs <= {640{1'b1}};
            ns <= {640{1'b1}};
            count <= 0;
            new_bit <= 1;
        end
        cs <= ns;
        count <= count + 1;
    end // always

    always@(posedge clk_i) begin
        if (count == 80) begin
            new_bit = rand_num;
            count = 0;
        end 
        ns = {cs[638:0], new_bit};
    end // always
    
    assign line_o = cs;
endmodule
