module flipflop (input logic Clk, Load, Reset, Xin, output logic Xout);

always_ff @ (posedge Clk)
begin
	if (Reset)
		Xout <= 1'b0;
	else if (Load)
		Xout <= Xin;
	else
		Xout <= Xout;
end

endmodule
