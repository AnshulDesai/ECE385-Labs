/*
ripple_adder.sv by Anshul Desai (2020)
======================================
Modified ripple adder that will change adder input based off of mode
*/
module ripple_adder
(
    input   logic[7:0]     A,
    input   logic[7:0]     Din,
	 input	logic				mode,		// 0 = Addition, 1 = Subtraction
    output  logic[8:0]     Sum
);

	  logic[8:0] carr;
	  logic[7:0] SMode;
	  
	  // Incurs two's complement input if necessary (based on mode)
	  assign SMode = (Din ^ { 8 { mode } });
		
	  full_adder FA0 (.x (A[0]), .y (SMode[0]), .z (mode), .s (Sum[0]), .c (carr[0]));
	  full_adder FA1 (.x (A[1]), .y (SMode[1]), .z (carr[0]), .s (Sum[1]), .c (carr[1]));
	  full_adder FA2 (.x (A[2]), .y (SMode[2]), .z (carr[1]), .s (Sum[2]), .c (carr[2]));
	  full_adder FA3 (.x (A[3]), .y (SMode[3]), .z (carr[2]), .s (Sum[3]), .c (carr[3]));
	  full_adder FA4 (.x (A[4]), .y (SMode[4]), .z (carr[3]), .s (Sum[4]), .c (carr[4]));
	  full_adder FA5 (.x (A[5]), .y (SMode[5]), .z (carr[4]), .s (Sum[5]), .c (carr[5]));
	  full_adder FA6 (.x (A[6]), .y (SMode[6]), .z (carr[5]), .s (Sum[6]), .c (carr[6]));
	  full_adder FA7 (.x (A[7]), .y (SMode[7]), .z (carr[6]), .s (Sum[7]), .c (carr[7]));
	  full_adder FA8 (.x (A[7]), .y (SMode[7]), .z (carr[7]), .s (Sum[8]), .c (carr[8]));
	 
endmodule
