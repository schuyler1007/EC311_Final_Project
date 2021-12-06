GravityGuy is a four-player game where players run within several platforms, switching the direction of their gravity to remain alive. The game ends when only one player is left alive.

The generate modules determine the mechanics of the game elements (player, lines). This includes creation parameters (length/width, position) and behavior (on/off, movement). 

The draw modules define the region over which the elements are displayed (corresponding to logic "1" in the code).

draw_game.v includes the pixel strobe which synchronizes all the graphics and assigns RGB reg outputs to the regions specified by the draw modules.
