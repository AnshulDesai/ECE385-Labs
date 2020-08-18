module two_complement (input logic[7:0] A, output logic[7:0] Complement);

	logic[7:0] ANot;
	logic[7:0] OneBit;
	
	assign ANot[7:0] = ~A[7:0];
	assign OneBit[7:0] = 8'b00000001;
	
	ripple_adder RA (.A (ANot[7:0]), .Din (OneBit[7:0]), .Sum (Complement[7:0]) );
	
endmodule
