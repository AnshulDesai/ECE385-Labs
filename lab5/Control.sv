//Two-always example for state machine

module control (input  logic Clk, Reset, ClearA_LoadB, Execute, M,
                output logic Shift_En, Ld_A, Ld_B, mode, ClearA);

    // Declare signals curr_state, next_state of type enum
    // with enum values of A, B, ..., F as the state values
	 // Note that the length implies a max of 8 states, so you will need to bump this up for 8-bits
    enum logic [5:0] {Clear, Rst, Add1, Add2, Add3, Add4, Add5, Add6, Add7, Shift1, Shift2, Shift3, Shift4, Shift5, Shift6, Shift7, Shift8, Subtract, Halt1, Halt2}   curr_state, next_state; 
	 
	 // Flip-flop is updated
    always_ff @ (posedge Clk)  
    begin
        if (Reset)
            curr_state <= Rst;
        else 
            curr_state <= next_state;
    end

	 // Correct state assigned
	always_comb
    begin
		  next_state  = curr_state;
        unique case (curr_state) 
            Rst : if (Execute)
                       next_state = Clear;
            Clear : next_state = Add1;
            Add1 : next_state = Shift1;
            Shift1 : next_state = Add2;
            Add2 : next_state = Shift2;
				Shift2 : next_state = Add3;
            Add3 : next_state = Shift3;
            Shift3 : next_state = Add4;
            Add4 : next_state = Shift4;
				Shift4 : next_state = Add5;
				Add5 : next_state = Shift5;
				Shift5 : next_state = Add6;
				Add6 : next_state = Shift6;
				Shift6 : next_state = Add7;
				Add7 : next_state = Shift7;
				Shift7 : next_state = Subtract;
				Subtract : next_state = Shift8;
				Shift8 : next_state = Halt1;
				Halt1 : if (~Execute)
								next_state = Halt2;
				Halt2 : if (Execute)
								next_state = Clear;
						  else if (ClearA_LoadB)
								next_state = Rst;
        endcase
   
        case (curr_state) 
	   	   Rst: 
	         begin
                Shift_En = 1'b0;
					 Ld_A = 1'b0;
					 Ld_B = ClearA_LoadB;
					 ClearA = 1'b0;
					 mode = 1'b0;
		      end
				
	   	   Clear: 
		      begin
                Shift_En = 1'b0;
                Ld_A = 1'b0;
                Ld_B = 1'b0;
					 ClearA = 1'b0;
					 mode = 1'b0;
		      end
				
	   	   Add1, Add2, Add3, Add4, Add5, Add6, Add7:
		      begin 
                Shift_En = 1'b0;
                Ld_A = M;
                Ld_B = 1'b0;
					 ClearA = 1'b0;
					 mode = 1'b0;
		      end
				
				Subtract:
				begin
					 Shift_En = 1'b0;
					 Ld_A = M;
					 Ld_B = 1'b0;
					 ClearA = 1'b0;
					 mode = 1'b1;
				end
				
				Halt1, Halt2:
				begin
					 Shift_En = 1'b0;
					 Ld_A = 1'b0;
					 Ld_B = 1'b0;
					 ClearA = 1'b0;
					 mode = 1'b0;
				end
				
				default:
				begin
					 Shift_En = 1'b1;
					 Ld_A = 1'b0;
					 Ld_B = 1'b0;
					 ClearA = 1'b0;
					 mode = 1'b0;
				end
        endcase
    end

endmodule
