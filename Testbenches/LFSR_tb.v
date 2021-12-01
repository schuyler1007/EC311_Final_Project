module LFSR_tb();
    reg clk_i;
    wire [7:0] out_o;

    LFSR lfsr_inst(.clk_i(clk_i), .en_i(1'b1), .out_o(out_o));

    always@(*) begin
        #10 clk_i <= ~clk_i;
    end

endmodule