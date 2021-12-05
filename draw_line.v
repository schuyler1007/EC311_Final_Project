module draw_line 
    # (parameter LineMidpointLoc = 0, 
       parameter LineWidth = 1) (
    input [639:0] line_i,
    input [9:0] x_i,
    input [8:0] y_i,
    output region_o    
    );
   assign region_o = ((line_i[x_i] == 1) &
                      (y_i >= LineMidpointLoc - LineWidth/2) &
                      (y_i < LineMidpointLoc + LineWidth/2)) ? 1 : 0;
endmodule
