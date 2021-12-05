module LFSR_tb();
    reg clk_i;
    wire out1, out2, out3;

    LFSR #(.seed(0)) lfsr_inst1(.clk_i(clk_i), .en_i(1'b1), .nextbit(out1));
    LFSR #(.seed(4)) lfsr_inst2(.clk_i(clk_i), .en_i(1'b1), .nextbit(out2));
    LFSR #(.seed(2)) lfsr_inst3(.clk_i(clk_i), .en_i(1'b1), .nextbit(out3));
   
    
    initial begin
        clk_i = 1'b0;
    end
    
    always@(*) begin
        #1 clk_i <= ~clk_i;
    end

endmodule
