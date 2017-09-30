/***********************
 Victor Sira
 21278163
 September 30 2017
 CPEN 211 L1E
***********************/


// This is the top level module that connects together all the modules.

module lab4_top(SW, KEY, HEX0);
  input [9:0] SW;
  input [3:0] KEY;
  output [6:0] HEX0;

  // Inverse logic of pushbuttons and switches for DE1 board:
  assign SW = ~SW;
  assign KEY = ~KEY;
  assign HEX0 = ~HEX0;

  FSM fsm ( KEY[0], SW[0], KEY[1], HEX0);

endmodule
