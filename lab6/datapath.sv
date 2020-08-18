/*
datapath.sv by Anshul Desai & Tailin Zhang (2020)

- Initializes all of our modules as well as some local variables, used by sl3
*/

module datapath ( input logic [15:0] Data,
						input logic Clk, Reset, LD_MAR, LD_MDR, LD_IR, LD_PC, LD_REG, LD_CC, LD_BEN, SBusPC, SBusMDR, SBusALU, SBusMARMUX,
						input logic [1:0] PCSelect, ADDR2Select, mode,
						input logic DRSelect, SR1Select, SR2Select, ADDR1Select, MIO_EN,
						output logic [15:0] regMDRinfo, regIRinfo, regPCinfo, regMARinfo,
						output logic BEN_OUTPUT);
		
		// Local variables
		logic [15:0] ALUout, SR1out, SR2out, sign11bit, sign9bit, sign6bit, sign5bit, busMuxOut, PCMuxOut, ADDR1MuxOut, ADDR2MuxOut, MDRMuxOut, ADDERMuxOut, SR2MuxOut, regPCout, regIRout, regMARout, regMDRout, PCPlus;
		logic [2:0] SR2Val, DRMuxOut, SR1MuxOut;
		logic SR2ControlSelect;
		logic n, z, p;
		
		// 16-bit register and mux initializations using correct inputs and outputs
		reg16bit regIR (.Clk(Clk), .Reset(Reset), .shiftIn( ), .Load(LD_IR), .shiftEn(1'b0), .Din(busMuxOut), .Dout(regIRout), .shiftOut( ));
		reg16bit regPC (.Clk(Clk), .Reset(Reset), .shiftIn( ), .Load(LD_PC), .shiftEn(1'b0), .Din(PCMuxOut), .Dout(regPCout), .shiftOut( ));
		reg16bit regMDR (.Clk(Clk), .Reset(Reset), .shiftIn( ), .Load(LD_MDR), .shiftEn(1'b0), .Din(MDRMuxOut), .Dout(regMDRout), .shiftOut( ));
		reg16bit regMAR (.Clk(Clk), .Reset(Reset), .shiftIn( ), .Load(LD_MAR), .shiftEn(1'b0), .Din(busMuxOut), .Dout(regMARout), .shiftOut( ));
		busMux busMUX (.dinA(ADDERMuxOut), .dinB(regPCout), .dinC(ALUout), .dinD(regMDRout), .s({SBusMARMUX, SBusPC, SBusALU, SBusMDR}), .busOut(busMuxOut));
		sixteen4to1Mux PCMUX (.dinA(regPCout + 16'h0001), .dinB(busMuxOut), .dinC(ADDERMuxOut), .dinD( ), .s(PCSelect), .muxOut(PCMuxOut));
		sixteen2to1Mux MDRMUX (.dinA(busMuxOut), .dinB(Data), .s(MIO_EN), .muxOut(MDRMuxOut));
		sixteen2to1Mux ADDR1MUX (.dinA(regPCout), .dinB(SR1out), .s(ADDR1Select), .muxOut(ADDR1MuxOut));
		sixteen4to1Mux ADDR2MUX (.dinA(16'h0000), .dinB(sign6bit[15:0]), .dinC(sign9bit[15:0]), .dinD(sign11bit[15:0]), .s(ADDR2Select), .muxOut(ADDR2MuxOut));
		
		// Register values assigned to info variables
		assign regIRinfo = regIRout;
		assign regPCinfo = regPCout;
		assign regMDRinfo = regMDRout;
		assign regMARinfo = regMARout;
		
		// Mux output from two sub-adders assigned
		assign ADDERMuxOut = ADDR1MuxOut + ADDR2MuxOut;
		
		// Sign-extension calculations
		always @ (posedge Clk)
		begin
			sign11bit[15:0] <= { {5 { regIRout[10] } }, regIRout[10:0] };
			sign9bit[15:0] <= { {7 { regIRout[8] } }, regIRout[8:0] };
			sign6bit[15:0] <= { {10 { regIRout[5] } }, regIRout[5:0] };
			sign5bit[15:0] <= { {11 { regIRout[4] } }, regIRout[4:0] };
			SR2Val[2:0] <= regIRout[2:0];
		end
		 
		// Initialization of NZP register and register file
		reg16bitNZP NZP (.Clk(Clk), .Reset(Reset), .Load(LD_CC), .busIn(busMuxOut), .nOut(n), .zOut(z), .pOut(p));
		register_unit rUnit (.Clk(Clk), .Reset(Reset), .Load(LD_REG), .busMuxIn(busMuxOut[15:0]), .DRin(DRMuxOut[2:0]), .SR1in(SR1MuxOut[2:0]), .SR2in(SR2Val[2:0]), .SR1out(SR1out[15:0]), .SR2out(SR2out[15:0]));

		// Initializtion of mux for DR, SR1, and SR2
		three2to1Mux DRMUX (.dinA(regIRinfo[11:9]), .dinB(3'b111), .s(DRSelect), .muxOut(DRMuxOut));
		three2to1Mux SR1MUX (.dinA(regIRinfo[11:9]), .dinB(regIRinfo[8:6]), .s(SR1Select), .muxOut(SR1MuxOut));
		sixteen2to1Mux SR2MUX (.dinA(SR2out[15:0]), .dinB(sign5bit[15:0]), .s(SR2Select), .muxOut(SR2MuxOut[15:0]));
				
		// Initialiation of ALU
		ALU a0 (.SR1in(SR1out[15:0]), .SR2in(SR2MuxOut[15:0]), .mode(mode[1:0]), .ALUout(ALUout[15:0]));
		
		// Initialization of BEN flip-flop
		flipflop BEN (.Clk(Clk), .Load(LD_BEN), .Reset(Reset), .Xin((regIRout[11] & n) | (regIRout[10] & z) | (regIRout[9] & p)), .Xout(BEN_OUTPUT));
endmodule
