module LFSR #(parameter seed = 0) (clk_i, en_i, nextbit);
    input clk_i, en_i;
    output reg nextbit;

    reg [2:0] next_LFSR = seed;

    always@(posedge clk_i) begin
        if (en_i == 1'b1) begin
           next_LFSR <= {next_LFSR[1:0], nextbit}; 
        end
    end // always

    always@(*) begin
        nextbit = next_LFSR[2] ^~ next_LFSR[1];
    end // always


endmodule
