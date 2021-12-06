// Notes to self:
//
// This module draws a character independent of position- position given as inputs
//     Inputs: clock, reset, enable, x position (parameter), y position
//     Outputs: 4-bit red, green, blue signals
//
// Each region of the screen is held by a wire
//     Different inputs will display different colors for each region depending on the input
//     Colors always on, regions always on- location of x/y and i/ps determine graphics displays
//     assign registers to VGA 3rd o/p for each primary color- update regions included to display colors
//     One region per primary color added- add/subtract regions to display different colors
// In always block, change input values to create different color effects
//
// In terms of submodule separation, it might make more sense to have one module handle graphics generation
// and one module handle location/input data (what switch inputs do, how position changes as time continues, etc.)

// Verilog Implementation: Draw Character

module draw_character #(parameter xpos = 100) (
	input wire i_en,
	input wire [9:0] x,
	input wire [8:0] y,
	input wire i_ypos,
	output character);
	
    // define region for character based on i_xpos, i_ypos
    assign character = ( (i_en == 1) & (x > xpos) & (y > i_ypos) & (x < xpos + 40) & (y < i_ypos + 60) ) ? 1 : 0;
	
endmodule