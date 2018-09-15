//------------------------------------------- 
// Name:          vtotient
// Student no:    xx
// Lab Section:   xx
//--------------------------------------------



//*****************************************
// This is the testbench for the ALU 
// combinational logic block. It tests
// a few cases of each operation and 
// various edge cases.
//*****************************************

// Constants to use:
`define ADD 2'b00
`define SUB 2'b01
`define AND 2'b10
`define NOT 2'b11

module ALU_tb;
	
	// Signals I will test
	reg [1:0] sim_op;
	reg [15:0] sim_Ain;
	reg [15:0] sim_Bin;
	reg err;

	wire sim_status;
	wire [15:0] sim_out;
	
	// Instantiate the dut:
	ALU #(16) dut( .Ain(sim_Ain), .Bin(sim_Bin), .ALUop(sim_op), 
		 .path_to_C(sim_out), .path_to_status(sim_status) );
	
	task my_checker;
		input [15:0] expected_out;
		input expected_status;

	begin
		if( ALU_tb.dut.path_to_C !== expected_out ) begin
			$display("Error: Expected out: %b || Actual: %b", 
				  expected_out, ALU_tb.dut.path_to_C);
			err = 1'b1;
		end
		if( ALU_tb.dut.path_to_status !== expected_status ) begin
			$display("Error: Status incorrect");
			err = 1'b1;
		end
	end
	endtask
 
	initial begin
		// Check for proper operations being executed
		
		// Initialize Ain, Bin, then check if addition is working correctly
		sim_Ain = 16'b0; sim_Bin = 16'b0; err =1'b0;sim_op = `ADD; #100;
	
		 
		my_checker(16'b0, 1'b1); 		// 0+0 = 0
		#100;

                sim_Ain = 16'b1; sim_Bin = 16'b0;
                #100; my_checker(16'b1,1'b0);               
                #100;
    
                sim_Ain = 16'b0000000000010001; sim_Bin = 16'b01;
                #100; my_checker(16'b10010,1'b0);             
		#100;

		sim_Ain = 16'b1111111111111111; sim_Bin = 16'b1111111111111111; 
                #100;my_checker(16'b1111111111111110,1'b0);
		#100;
	
		// Check subtraction functionality:
		sim_op = `SUB;
		sim_Ain = 16'b111; sim_Bin = 16'b111;
		#100;my_checker(16'b0,1'b1);
		#100;

		sim_Ain = 16'b0;  sim_Bin = 16'b0;
		#100;my_checker(16'b0,1'b1);
		#100;
	
		sim_Ain = 16'b1101; sim_Bin = 16'b1000;
		#100;my_checker(16'b101,1'b0);
		#100;

		// Check ANDing:
		sim_op = `AND;
		sim_Ain = 16'b1; sim_Bin = 16'b1;
		#100;my_checker(16'b1,1'b0);
		#100;

		sim_Ain = 16'b0; sim_Bin = 16'b0;
		#100;my_checker(16'b0,1'b1);
		#100;
		
		sim_Ain = 16'b1; sim_Bin = 16'b0;
		#100;my_checker(16'b0,1'b1);
		#100;

		sim_Ain = 16'b101; sim_Bin = 16'b100;
		#100;my_checker(16'b100,1'b0);
		#100;
		
		// Check NOT
		sim_op = `NOT; sim_Ain = 16'b1; sim_Bin = 16'b0;
		#100;my_checker(16'b1111111111111111,1'b0);				// Make sure changing Ain won't affect the outcome
		#100;
		 
		sim_Ain = 16'b1; sim_Bin = 16'b1111111111111111;
		#100;my_checker(16'b0,1'b1);
		#100;
		
		sim_Ain = 16'b0; sim_Bin = 16'b1111111111111111;
		#100;my_checker(16'b0,1'b1);
		#100;
	
		
		if( err == 1'b1 )
			$display("TEST FAILED");
		else
			$display("TEST PASSED");
		$stop;

	end
endmodule
