/*
register_unit.sv by Anshul Desai & Tailin Zhang (2020)

- Our register file
*/

module register_unit(input logic Clk, Reset, Load,
							input logic [15:0] busMuxIn,
							input logic [2:0] DRin,
							input logic [2:0] SR1in,
							input logic [2:0] SR2in,
							output logic [15:0] SR1out,
							output logic [15:0] SR2out);
							
		logic [15:0] tmpRegs[8];	// Creates 8 16-bit registers
		
		assign SR1out = tmpRegs[SR1in];	// Assigns a register to SR1
		assign SR2out = tmpRegs[SR2in];	// Assigns a register to SR2
		
		always_ff @ (posedge Clk)
		begin
			if (Reset)
				begin
					for (integer i = 0; i < 8; i = i + 1)
					begin
						tmpRegs[i] <= 16'h0000;	// Loads empty value into register
					end
				end
			else if (Load)
				begin
					tmpRegs[DRin] <= busMuxIn;	// Loads value from bus to register
				end
		end
endmodule
