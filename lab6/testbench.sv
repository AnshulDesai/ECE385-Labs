/*
testbench.sv by Anshul Desai & Tailin Zhang (2020)

- Used as testing for I/O Tests 1 and 2
*/

module testbench();

timeunit 10ns;	
timeprecision 1ns;

logic [19:0] ADDR;
logic [15:0] MAR, MDR, PC, IR, busMuxOut, SR1Out, SR2Out, ADDERMuxOut, ALUOut, S;
logic [11:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
logic [2:0] DRMUXOut, SR1MuxOut;
logic [1:0]  PCMUX, ADDR2MUX, ALUK;
logic LD_MAR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_MDR, Clk, Reset, Run, Continue, PCSelect, MDRSelect, ALUSelect, MARMUXSelect, DRMUX, SR1MUX, SR2MUX, ADDR1MUX, CE, UB, LB, OE, WE;

always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

lab6_toplevel topLevel(.*, .Data());

assign MAR = topLevel.my_slc.d0.regMARout;
assign IR  = topLevel.my_slc.d0.regIRout;
assign PC  = topLevel.my_slc.d0.regPCout;
assign MDR = topLevel.my_slc.d0.regMDRout;
assign MDRMUXSelect = topLevel.my_slc.state_controller.GateMDR;
assign ALUMUXSelect = topLevel.my_slc.state_controller.GateALU;
assign MARMUXSelect = topLevel.my_slc.state_controller.GateMARMUX;
assign PCMUX = topLevel.my_slc.state_controller.PCMUX;
assign DRMUX = topLevel.my_slc.state_controller.DRMUX;
assign SR1MUX = topLevel.my_slc.state_controller.SR1MUX;
assign SR2MUX = topLevel.my_slc.state_controller.SR2MUX;
assign ADDR1MUX = topLevel.my_slc.state_controller.ADDR1MUX;
assign ADDER2MUX = topLevel.my_slc.state_controller.ADDR2MUX;
assign mode = topLevel.my_slc.state_controller.ALUK;
assign busMuxOut = topLevel.my_slc.d0.busMuxOut;
assign ADDERMuxOut = topLevel.my_slc.d0.ADDERMuxOut;
assign ALUout = topLevel.my_slc.d0.ALUout;
assign DRMuxOut = topLevel.my_slc.d0.DRMuxOut;
assign SR1MuxOut = topLevel.my_slc.d0.SR1MuxOut;
assign SR1Out = topLevel.my_slc.d0.rUnit.SR1out;
assign SR2Out = topLevel.my_slc.d0.rUnit.SR2out;
assign BEN_OUTPUT = topLevel.my_slc.d0.BEN_OUTPUT;
assign PCMUXSelect = topLevel.my_slc.state_controller.GatePC;
assign LD_MAR = topLevel.my_slc.state_controller.LD_MAR;
assign LD_IR = topLevel.my_slc.state_controller.LD_IR;
assign LD_BEN = topLevel.my_slc.state_controller.LD_BEN;
assign LD_CC = topLevel.my_slc.state_controller.LD_CC;
assign LD_REG = topLevel.my_slc.state_controller.LD_REG;
assign LD_PC = topLevel.my_slc.state_controller.LD_PC;
assign LD_MDR = topLevel.my_slc.state_controller.LD_MDR;

initial begin : TEST_VEC			
Reset = 0;
Run = 1;
Continue = 1;

//Basic I/O Test 1
S = 16'h0006;
#2 Reset = 1;
#2 Run = 0;
#2 Run = 1;
#66 S = 16'h0004;
#2 Continue = 0;
#2 Continue = 1;
#66 S = 16'h0050;
#2 Continue = 0;
#2 Continue = 1;

#22;
end
endmodule
