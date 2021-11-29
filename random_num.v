module random_num #(parameter NUM_BITS)
  (
   input clk_i,
   input en_i,
 
   // Optional Seed Value
   input seed_i,
   input [NUM_BITS-1:0] seed_data,
 
   output [NUM_BITS-1:0] out_o
   );
 
  reg [NUM_BITS:1] next_LFSR = 0;
  reg nextbit;
  
  always @(posedge clk_i)
    begin
      if (en_i == 1'b1)
        begin
          if (seed_i == 1'b1)
            next_LFSR <= seed_data;
          else
            next_LFSR <= {next_LFSR[NUM_BITS-1:1], nextbit};
        end
    end
 
  always @(*)
    begin
      case (NUM_BITS)
        3: begin
          nextbit = next_LFSR[3] ^~ next_LFSR[2];
        end
        4: begin
          nextbit = next_LFSR[4] ^~ next_LFSR[3];
        end
        5: begin
          nextbit = next_LFSR[5] ^~ next_LFSR[3];
        end
        6: begin
          nextbit = next_LFSR[6] ^~ next_LFSR[5];
        end
        7: begin
          nextbit = next_LFSR[7] ^~ next_LFSR[6];
        end
        8: begin
          nextbit = next_LFSR[8] ^~ next_LFSR[6] ^~ next_LFSR[5] ^~ next_LFSR[4];
        end
        9: begin
          nextbit = next_LFSR[9] ^~ next_LFSR[5];
        end
        10: begin
          nextbit = next_LFSR[10] ^~ next_LFSR[7];
        end
        
        11: begin
          nextbit = next_LFSR[11] ^~ next_LFSR[9];
        end
        12: begin
          nextbit = next_LFSR[12] ^~ next_LFSR[6] ^~ next_LFSR[4] ^~ next_LFSR[1];
        end
        13: begin
          nextbit = next_LFSR[13] ^~ next_LFSR[4] ^~ next_LFSR[3] ^~ next_LFSR[1];
        end
        14: begin
          nextbit = next_LFSR[14] ^~ next_LFSR[5] ^~ next_LFSR[3] ^~ next_LFSR[1];
        end
        15: begin
          nextbit = next_LFSR[15] ^~ next_LFSR[14];
        end
        16: begin
          nextbit = next_LFSR[16] ^~ next_LFSR[15] ^~ next_LFSR[13] ^~ next_LFSR[4];
          end
        17: begin
          nextbit = next_LFSR[17] ^~ next_LFSR[14];
        end
        18: begin
          nextbit = next_LFSR[18] ^~ next_LFSR[11];
        end
        19: begin
          nextbit = next_LFSR[19] ^~ next_LFSR[6] ^~ next_LFSR[2] ^~ next_LFSR[1];
        end
        20: begin
          nextbit = next_LFSR[20] ^~ next_LFSR[17];
        end
        21: begin
          nextbit = next_LFSR[21] ^~ next_LFSR[19];
        end
        22: begin
          nextbit = next_LFSR[22] ^~ next_LFSR[21];
        end
        23: begin
          nextbit = next_LFSR[23] ^~ next_LFSR[18];
        end
        24: begin
          nextbit = next_LFSR[24] ^~ next_LFSR[23] ^~ next_LFSR[22] ^~ next_LFSR[17];
        end
        25: begin
          nextbit = next_LFSR[25] ^~ next_LFSR[22];
        end
        26: begin
          nextbit = next_LFSR[26] ^~ next_LFSR[6] ^~ next_LFSR[2] ^~ next_LFSR[1];
        end
        27: begin
          nextbit = next_LFSR[27] ^~ next_LFSR[5] ^~ next_LFSR[2] ^~ next_LFSR[1];
        end
        28: begin
          nextbit = next_LFSR[28] ^~ next_LFSR[25];
        end
        29: begin
          nextbit = next_LFSR[29] ^~ next_LFSR[27];
        end
        30: begin
          nextbit = next_LFSR[30] ^~ next_LFSR[6] ^~ next_LFSR[4] ^~ next_LFSR[1];
        end
        31: begin
          nextbit = next_LFSR[31] ^~ next_LFSR[28];
        end
        32: begin
          nextbit = next_LFSR[32] ^~ next_LFSR[22] ^~ next_LFSR[2] ^~ next_LFSR[1];
        end
 
      endcase
    end // always
 
 
  assign out_o = next_LFSR[NUM_BITS:1];
 
endmodule
