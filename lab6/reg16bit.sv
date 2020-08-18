/*
reg16bit.sv by Anshul Desai & Tailin Zhang (2020

- Basic 16-bit register with shifting
*/

module reg16bit (input logic Clk, Reset, shiftIn, shiftEn, Load,
						input logic [15:0] Din,
						output logic [15:0] Dout,
						output logic shiftOut);
						
		logic [15:0] nextData;
		
		always_ff @ (posedge Clk)
		begin
			Dout <= nextData;
		end
		
		always_comb begin
		nextData = Dout;
			if (Reset)
				nextData = 16'h0000;
			else if (Load)
				nextData = Din;
			else if (shiftEn)
				nextData = { shiftIn, Dout[15:1] };
		end
		assign shiftOut = Dout[0];
endmodule 