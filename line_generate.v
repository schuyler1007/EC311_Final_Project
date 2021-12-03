module line_generate(reset_i, clk_i, en_i, line_o);
    input reset_i, clk_i, en_i;
    output [639:0] line_o;
    wire [7:0] rand_num;
    reg [639:0] cs = {640{1'b1}}, ns = {640{1'b1}};
    reg [6:0] count = 0;
    reg new_bit = 1;
    
    LFSR rn(.clk_i(clk_i), .en_i(en_i), .out_o(rand_num));

    always@(posedge clk_i or negedge reset_i) begin
        if (reset_i==0) begin
            cs = 0;
            cs = cs - 1;
            ns = 0;
            ns = ns - 1;
            count = 0;
            new_bit = 1;
        end
        cs <= ns;
        count = count + 1;
    end // always

    always@(posedge clk_i) begin
        if (count == 80) begin
            new_bit = rand_num[0];
            count = 0;
        end 
        ns = {cs[638:0], new_bit};
    end // always
    
    assign line_o = cs;
endmodule
