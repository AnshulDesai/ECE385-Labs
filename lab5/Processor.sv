/*
Processor.sv by Anshul Desai (2020)
===================================
Top level module for lab 5, instantiates all necessary modules with given inputs, oututs, and logic
*/
module Processor (input logic   Clk,				// Internal
                                Reset,				// KEY0
                                ClearA_LoadB,	// KEY2
                                Execute,			// KEY3
                  input  logic [7:0]  Din,		// Input switches
                  output logic [3:0]  LED,		// LEDs used for debugging
                  output logic [6:0]  AhexL, AhexU, BhexL, BhexU,
						output logic [7:0]  A_val,		// Value for A
						output logic [7:0]  B_val);	// Value for B

	 // Local logic variables
	 logic [7:0] Din_loc;
	 logic ClearA_LoadB_loc, Execute_loc, Reset_loc;
	 
	 // Register unit logic (in)
	 logic ResetA;
	 
	 // Register unit logic (out)
	 logic [7:0] A, B;
	 logic [8:0] Sum;
	 logic M;
	 
	 // Local control unit logic (out)
	 logic Ld_A, Ld_B, ClearA, mode, Shift_En;
	 	 
	 // Debugging assignments
	 assign ResetA = (ClearA | Reset_loc); // Clears X and A if ClearA or Reset_loc are set to 1
	 assign A_val = A; 
	 assign B_val = B;
	 
	 // Lights debugging LEDs based off of settings
	 assign LED = {ClearA_LoadB_loc, Execute_loc, Reset_loc};
	 
	 // Module instantiation
	 // Control unit instantiated based off of universal inputs as well as debugging inputs
	 control	cUnit (.Clk(Clk), .Reset(Reset_loc), .ClearA_LoadB(ClearA_LoadB_loc), .Execute(Execute_loc), .M(M), .Shift_En(Shift_En), .Ld_A(Ld_A), .Ld_B(Ld_B), .mode(mode), .ClearA(ClearA));

	 // Register unit instantiated based off of universal inputs as well as debugging inputs
	 register_unit	rUnit (.Clk(Clk), .Reset(Reset_loc), .Reset_A(ResetA), .Xin(Sum[8]), .Ld_A(Ld_A), .Ld_B(Ld_B), .Shift_En(Shift_En), .A(Sum[7:0]), .B(Din_loc[7:0]), .M(M), .AOut(A[7:0]), .BOut(B[7:0]));
	 
	 // Ripple adder instantiated based off of universal inputs as well as debugging inputs
	 ripple_adder raUnit (.A(A[7:0]), .Din(Din_loc[7:0]), .mode(mode), .Sum(Sum[8:0]));															
 
	 HexDriver HexAL (
		.In0(A[3:0]),
		.Out0(AhexL) );
	 HexDriver HexBL (
		.In0(B[3:0]),
		.Out0(BhexL) );					
	 HexDriver HexAU (
		.In0(A[7:4]),
		.Out0(AhexU) );	
	 HexDriver HexBU (
		.In0(B[7:4]),
		.Out0(BhexU) );
	 
	 // Synchronizers allowing for aysnchronous inputs from push buttons and switches (one for each button and switch, using loc variables
	 sync sSync[7:0] (Clk, Din, Din_loc);
	 sync bSync[2:0] (Clk, {~Reset, ~ClearA_LoadB, ~Execute}, {Reset_loc, ClearA_LoadB_loc, Execute_loc});

endmodule
