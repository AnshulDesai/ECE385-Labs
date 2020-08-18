module reg_8 (input logic Clk, Reset, Shift_In, Shift_En, Load, input logic[7:0] Data, output logic Shift, output logic [7:0] Out);

	logic[7:0] Data_New;
	
	always_ff @ (posedge Clk)
	begin
		Out <= Data_New;
	end
	
	always_comb begin
	Data_New = Out;
		if (Reset)
			Data_New = 0;
		else if (Load)
			Data_New = Data;
		else if (Shift_En)
			Data_New = { Shift_In, Out[7:1] };
	end
	
	assign Shift = Out[0];
	
endmodule
