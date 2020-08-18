/*
reg16bitNZP.sv by Anshul Desai & Tailin Zhang (2020)

- 16-bit register with nzp (negative, zero, positive) info regarding value
*/

module reg16bitNZP (input logic Clk, Reset, Load,
							input logic [15:0] busIn,
							output logic nOut, zOut, pOut);
							
		logic nzp [2:0];
		logic n, z, p;
		
		always_comb 
		begin
			// nzp = 3'b001;
			nzp[2] = 1'b0;
			nzp[1] = 1'b0;
			nzp[0] = 1'b1;
			if (busIn[15])
				begin
					// nzp = 3'b100;
					nzp[2] = 1'b1;
					nzp[1] = 1'b0;
					nzp[0] = 1'b0;
				end
			else if (busIn == 16'h0000)
				begin
					// nzp = 3'b010;
					nzp[2] = 1'b0;
					nzp[1] = 1'b1;
					nzp[0] = 1'b0;
				end
		end
		
		always_ff @ (posedge Clk)
		begin
			if (Load)
				begin
					n <= nzp[2];
					z <= nzp[1];
					p <= nzp[0];
				end
		end
		
		assign nOut = n;
		assign zOut = z;
		assign pOut = p;
endmodule
