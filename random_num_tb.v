module random_num_tb();
  
parameter c_NUM_BITS = 8; // up to 32 bits
    reg r_Clk = 1'b0;
   
  wire [c_NUM_BITS-1:0] w_LFSR_Data;
   
  random_num #(.NUM_BITS(c_NUM_BITS)) rn
         (.clk_i(r_Clk),
          .en_i(1'b1),
          .seed_i(1'b0),
          .seed_data({c_NUM_BITS{1'b0}}),
          .out_o(w_LFSR_Data)
          );
  
  always @(*)
    #10 r_Clk <= ~r_Clk; 
        
endmodule
