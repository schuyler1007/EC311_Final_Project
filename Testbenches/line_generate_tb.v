odule line_generate_tb();
    reg clk_i, reset_i;
    wire [639:0] out_o;
    
    line_generate lg(.clk_i(clk_i),.reset_i(reset_i), .en_i(1'b1), .line_o(out_o));
    
    initial begin
        clk_i = 0;
        #10 reset_i = 0;
        reset_i = 1;
    end
    
    always begin
        #1 clk_i = ~clk_i;
    end
   
endmodule
