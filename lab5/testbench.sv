/*
testbench.sv by Anshul Desai (2020)
===================================
Testbench for testing various inputs for the multiplier
*/

module testbench();

timeunit	10ns;

timeprecision 1ns;

logic Reset, ClearA_LoadB, Execute;
logic Clk = 0;
logic[7:0] A_val;
logic[7:0] B_val;
logic[7:0] Din;
logic[6:0] AhexL;
logic[6:0] AhexU;
logic[6:0] BhexL;
logic[6:0] BhexU;
logic[3:0] LED;

Processor p(.*);

always begin: CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
	Clk = 0;
end

initial begin: TEST_VECTORS

Reset = 0;
ClearA_LoadB = 1;
Execute = 1;

// 2 * 3 = 6
#2 Reset = 1;
#2 Din = 8'h07;
#2 ClearA_LoadB = 0;
#2 ClearA_LoadB = 1;
#2 Din = 8'hC5;
#2 Execute = 0;
#221 Execute = 1;

// 4 * -1 = -4
#2 Reset = 0;
#2 Reset = 1;
#2 Din = 8'h04;
#2 ClearA_LoadB = 0;
#2 ClearA_LoadB = 1;
#2 Din = 8'hFF;
#2 Execute = 0;
#221 Execute = 1;

// -3 * -2 = 6
#2 Reset = 0;
#2 Reset = 1;
#2 Din = 8'hFD;
#2 ClearA_LoadB = 0;
#2 ClearA_LoadB = 1;
#2 Din = 8'hFE;
#2 Execute = 0;
#221 Execute = 1;

// -1 * 3 = -3
#2 Reset = 0;
#2 Reset = 1;
#2 Din = 8'hFF;
#2 ClearA_LoadB = 0;
#2 ClearA_LoadB = 1;
#2 Din = 8'h03;
#2 Execute = 0;
#221 Execute = 1;

end
endmodule
