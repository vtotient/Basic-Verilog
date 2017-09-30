// This is a testbench for FSM. Simulates pressing clk and switching the direction. 
// Also compares the expected values with actual values. The signal err will go high
// when the simulation detects an error.


// Some constants used and the states:
`define LOW 1'b0
`define HI 1'b1
`define WOS 5           // Width of State
`define Sa 5'b00001
`define Sb 5'b00010
`define Sc 5'b00100
`define Sd 5'b01000
`define Se 5'b10000
`define F 1'b1
`define R 1'b0


module lab4_tb_FSM;

	reg clk, dir, rst, err;
	wire [3:0] out;

	FSM dut (clk, dir, rst, out);

	initial begin
		
		// First check the intial states and if out is not set to Sa err sig.
		#100 clk = `LOW; dir = `F; rst = `LOW;

		if (out != `Sa)  err = `HI;

		// Check a full cycle through the states with dir == F

		#100 clk = 'HI;

		if (out != `Sb) err = `HI;


		#100 clk = 'LOW; #100 clk = `HI;

		if (out != `Sc) err = `HI;

		
		#100 clk = `LOW; #100 clk = `HI;

		if (out != `Sd) err = `HI;

		
		#100 clk = `LOW; #100 clk = `HI;

		if (out != `Se) err = `HI;

		
		#100 clk = `LOW; #100 clk = `HI;

		if (out != `Sa) err = `HI;


		// Check a full cycle through the states with dir == R
		#100 clk = `LOW; dir = `R; rst = `LOW;

                if (out != `Se)  err = `HI;

                // Check a full cycle through the states with dir == F

                #100 clk = 'HI;

                if (out != `Sd) err = `HI;


                #100 clk = 'LOW; #100 clk = `HI;
 
                if (out != `Sc) err = `HI;
                 
                 
                #100 clk = `LOW; #100 clk = `HI;
                 
                if (out != `Sb) err = `HI;
                 
                 
                #100 clk = `LOW; #100 clk = `HI;
                 
                if (out != `Sa) err = `HI;


                #100 clk = `LOW; rst = `HI; #100 clk = `HI;

                if (out != `Sa) err = `HI;

		
		repeat (4) begin
			
			clk = `HI;
			#100
			clk = `LOW;
		end 

		#100 dir = `F;

		repeat (4) begin

                        clk = `HI;
                        #100 
                        clk = `LOW;
                end 


	end

	$stop
endmodule
