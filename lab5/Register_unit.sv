/*
Register_unit.sv by Anshul Desai (2020)
=======================================
Register unit module that carries two 8-bit register's A and B as well as a Flip Flop for output
*/
module register_unit (input  logic Clk, Reset, Reset_A, Xin, Ld_A, Ld_B, 
                            Shift_En,
                      input  logic [7:0]  A,
							 input  logic [7:0]  B, 
                      output logic M, 
                      output logic [7:0]  AOut,
                      output logic [7:0]  BOut);
		
	logic AShift, XShift;
	
	// Standard inputs received from clock (Clk), Ld_A, Reset_A, as well as our Xin, outputting to our local logic variable XShift
	flipflop FF (.Clk (Clk), .Load (Ld_A), .Reset (Reset_A), .Xin (Xin), .Xout (XShift));
	
	// Register loaded with inputs based off of selected modes from input to register unit, shift data loaded into our local logic variable AShift
	reg_8 REGA (.Clk (Clk), .Reset (Reset_A), .Shift_In (XShift), .Shift_En (Shift_En), .Load (Ld_A), .Data (A[7:0]), .Shift (AShift), .Out (AOut[7:0]));
	
	// Register loaded with inputs based off of selected modes from input to register unit
	reg_8 REGB (.Clk (Clk), .Reset (Reset), .Shift_In (AShift), .Shift_En (Shift_En), .Load (Ld_B), .Data (B[7:0]), .Shift (M), .Out (BOut[7:0]));

endmodule
