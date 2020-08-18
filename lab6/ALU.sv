/*
ALU.sv by Anshul Desai & Tailin Zhang (2020)

- Basic ALU allowing for addition, ANDing, NOTing, and simply returning SR1
*/

module ALU(input logic [15:0] SR1in,
				input logic [15:0] SR2in,
				input logic [1:0] mode,
				output logic [15:0] ALUout);
				
		always_comb
		begin
		case (mode)
			2'b00: ALUout = SR1in + SR2in;
			2'b01: ALUout = SR1in & SR2in;
			2'b10: ALUout = ~SR1in;
			2'b11: ALUout = SR1in;
		endcase
		end
endmodule 
