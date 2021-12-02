module line_generate(clk_i, clk_lfsr, en_i, line_o, rand_num);
    input clk_i, en_i, clk_lfsr;
    output [639:0] line_o;
    output [7:0] rand_num;
    reg [639:0] cs, ns;
    reg [6:0] count;
    reg new_bit;

    initial begin
        cs = 0;
        ns = 0;
        count = 0;
        new_bit = 1;
    end
    
    LFSR rn(.clk_i(clk_lfsr), .en_i(en_i), .out_o(rand_num));

    always@(posedge clk_i) begin
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