/* 
Name: Victor Sira 
Lab1 
Testbench
*/

//No inputs or outputs-testbench
module lab1_top_tb ();

	reg sim_LEFT_button;
	reg sim_RIGHT_button;
	reg [3:0] sim_A;
	reg [3:0] sim_B;

	wire [3:0] sim_result;
	
	//Instantiate lab1_top:
	lab1_top DUT ( 
		.not_LEFT_pushbutton(~sim_LEFT_button), 
		.not_RIGHT_pushbutton(~sim_RIGHT_button),
		.A(sim_A),
		.B(sim_B),
		.result(sim_result)
	);

	//Initial test block:
	initial begin
		//Start by setting our buttons to not pushed
		sim_RIGHT_button = 1'b0;
		sim_LEFT_button = 1'b0;

		//Start with inputs at 0:
		sim_A = 4'b0;
		sim_B = 4'b0;

		//Wait five simultation timesteps:
		#5;

		//First test: ANDing:
		sim_LEFT_button = 1'b1;
		sim_A = 4'b1100;
		sim_B = 4'b1010;

		//Wait:
		#5;

		//Print output:
		$display("Output is %b, we expected %b", sim_result, (4'b1100 & 4'b1010));
		$stop;
	end

endmodule
