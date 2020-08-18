/*
mux_bank.sv by Anshul Desai & Tailin Zhang (2020)

- Contains 4 different types of muxes used throughout datapath.sv
*/

// Mux used as bus for all modules
module busMux (input logic [15:0] dinA, dinB, dinC, dinD,
					input logic [3:0] s,
					output logic [15:0] busOut);
		always_comb
		begin
		case (s)
			4'b1000: busOut = dinA;
			4'b0100: busOut = dinB;
			4'b0010: busOut = dinC;
			4'b0001: busOut = dinD;
			default: busOut = 16'hXXXX;
		endcase
		end
endmodule

// 3-bit 2 to 1 mux
module three2to1Mux (input logic [2:0] dinA, dinB,
							input logic s,
							output logic [2:0] muxOut);
		always_comb
		begin
		case (s)
			1'b0: muxOut = dinA;
			1'b1: muxOut = dinB;
		endcase
		end
endmodule

// 16-bit 2 to 1 mux
module sixteen2to1Mux (input logic [15:0] dinA, dinB,
								input logic s,
								output logic [15:0] muxOut);
		always_comb
		begin
		case (s)
			1'b0: muxOut = dinA;
			1'b1: muxOut = dinB;
		endcase
		end
endmodule

// 16-bit 4 to 1 mux
module sixteen4to1Mux (input logic [15:0] dinA, dinB, dinC, dinD,
								input logic [1:0] s,
								output logic [15:0] muxOut);
		always_comb
		begin
		case (s)
			2'b00: muxOut = dinA;
			2'b01: muxOut = dinB;
			2'b10: muxOut = dinC;
			2'b11: muxOut = dinD;
		endcase
		end
endmodule
							