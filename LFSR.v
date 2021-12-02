module LFSR (clk_i, en_i, out_o);
    input clk_i, en_i;
    output [7:0] out_o;

    reg [7:0] next_LFSR = 0;
    reg nextbit;

    always@(posedge clk_i) begin
        if (en_i == 1'b1) begin
           next_LFSR <= {next_LFSR[6:0], nextbit}; 
        end
    end // always

    always@(*) begin
        nextbit = next_LFSR[7] ^~ next_LFSR[5] ^~ next_LFSR[4] ^~ next_LFSR[3];
    end // always

    assign out_o = next_LFSR[7:0];

endmodule
