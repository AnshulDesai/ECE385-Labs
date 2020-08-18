/*
Router.sv by Anshul Desai (2020)
================================
Router module used for routing inputs/outputs based off of four cases identified by mode
*/

module router (input  logic [8:0] A,
					input  logic [7:0] Din,
					input  logic [7:0] Din_Complement,
					input  logic [7:0] B,
					input  logic [1:0]  mode,
					output logic X,
					output logic [7:0] Aout,
					output logic [7:0] Bout,
					output logic [7:0] Addout);
	
	// X Logic based off of mode
	always_comb
	begin
		unique case (mode)
			2'b10 : X = A[8];
			2'b11 : X = A[8];
	 	   2'b00 : X = 1'b0;
		   2'b01 : X = 1'b0;
	  	 endcase
	end
	
	// Routing of A val based off of mode
	always_comb
	begin
		unique case (mode)
		   2'b10 : Aout[7:0] = A[7:0];
			2'b11 : Aout[7:0] = A[7:0];
	 	   2'b00 : Aout[7:0] = 8'b00000000;
		   2'b01 : Aout[7:0] = 8'b00000000;
	  	 endcase
	end
	
	// Routing of B val based off of mode
	always_comb
	begin
		unique case (mode)
		   2'b10 : Bout[7:0] = B[7:0];
			2'b11 : Bout[7:0] = B[7:0];
	 	   2'b00 : Bout[7:0] = 8'b00000000;
		   2'b01 : Bout[7:0] = B[7:0];
	  	 endcase
	end
	
	// Routing of input of adder based off of mode
	always_comb
	begin
		unique case (mode)
		   2'b10 : Addout[7:0] = Din[7:0];
			2'b11 : Addout[7:0] = Din_Complement[7:0];
	 	   2'b00 : Addout[7:0] = 8'b00000000;
		   2'b01 : Addout[7:0] = 8'b00000000;
	  	 endcase
	end
	
endmodule
