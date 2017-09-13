/*
Name: Victor Sira, 21278163
LAB1

This is the code including the inferred latch bug

*/

module lab1_top ( 
	input not_LEFT_pushbutton,
	input not_RIGHT_pushbutton,
	input [3:0] A,
	input [3:0] B,
	output reg [3:0] result );

	//Internal Logic:
	
	//Create Wires:	
	wire [3:0] ANDed_result;	//The 4-bit wire is a "bus"
	wire [3:0] ADDed_result;
	wire LEFT_pushbutton;
	wire RIGHT_pushbutton;

	//Create AND and ADD operation blocks:
	assign ANDed_result = A & B;
	assign ADDed_result = A + B;

	//Use negative logic on pushbuttons:
	assign LEFT_pushbutton = ~ not_LEFT_pushbutton;
	assign RIGHT_pushbutton = ~ not_RIGHT_pushbutton;

	//Use an always block to simulate MUX
	always @* begin 
		case( {LEFT_pushbutton, RIGHT_pushbutton} ) 	
			2'b01: result = ADDed_result;
			2'b10: result = ANDed_result;
			2'b11: result = ADDed_result; 	//Right pushbutton takes precedence
			//INSERT THIS CODE TO FIX THE LATCH
			//default: result = '4'b0;
		endcase
	end
	
endmodule 
