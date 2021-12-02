module line_generate_tb();
    reg clk_i, clk_lfsr;
    wire [639:0] out_o;
    wire [7:0] rand_num;
    
    line_generate lg(.clk_i(clk_i), .clk_lfsr(clk_lfsr), .en_i(1'b1), .line_o(out_o), .rand_num(rand_num));
    
    initial begin
        clk_i = 0;
        clk_lfsr = 0;
    end
    
    always begin
        #1 clk_i = ~clk_i;
    end
    
    always begin
        #80 clk_lfsr = ~clk_lfsr;
    end
    
endmodule