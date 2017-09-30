// This is the FSM. On the positive edge of the clock the FSM will set the current state equal to the next state.
// The next state is either the state in front or behind depending on which direction dir is set too. 
// There is a reset button, rst, that will automatically set the present state to the first state. To see the list 
// of states see the definitions below. They are listed in the correct forward order. The outputs of each state  are:
// Sa ==> 2
// Sb ==> 1
// Sc ==> 2
// Sd ==> 7
// Se ==> 8
// which correspond to the first five digits of my student number. 

// Define States and other constants:
`define WOS 5 		// Width of State
`define Sa 5'b00001
`define Sb 5'b00010
`define Sc 5'b00100
`define Sd 5'b01000
`define Se 5'b10000
`define F 1'b1

module FSM (input clk, input dir, input rst, output reg [3:0] out);
  
  reg [WOS-1:0] present_state;
  reg [WOS-1:0] next_state;

  always @(posedge clk) begin
	if (rst) begin
	  next_state = 'Sa;
	end
	
  	else begin				// On the posedge of clk check the current state and what the next state should be
	  case (present_state) 
	    `Sa : if (dir == F)
		    next_state = `Sb;
		  else 
		    next_state = `Se;

	    `Sb : if (dir == F) 
		    next_state = `Sc;
		  else
	   	    next_state = `Sa;

	    `Sc : if (dir == F) 
		    next_state = `Sd;
		  else 
		    next_state = `Sb;

	    `Sd : if (dir == F)
		    next_state = `Se;
		  else 
		    next_state = `Sc;

	    `Se : if (dir == F)
		    next_state = `Sa;
		  else 
		    next_state = `Sd;
	  endcase
	

	  present_state = next_state;		// Now we assign the present state based on the cases above. 

	  case (present_state) 			// Assign the outputs. This should connect to other modules in top file to write values of out to DE1
 	    `Sa : out = 4'b0010;
	    `Sb : out = 4'b0001;
	    `Sc : out = 4'b0010;
	    `Sd : out = 4'b0111;
	    `Se : out = 4'b1000;
	  endcase

	end
  end
endmodule	
