module tb_tcam(); 
// ==========================================================================
// == Parameters
// ==========================================================================
	parameter KWID 	= 104; //Key width
	parameter SEGWID = 10; //Segment width IDwid+2stt
	parameter VTWID = SEGWID*(KWID/8); //segmem width
	parameter AWID = 8; //address width
	parameter DEP = 1<<AWID; //segmem depth
	parameter CFWID = 1+(SEGWID-2)+8; //Match/Not Match + Rule ID + Rule Priority 
	parameter MASKWID = KWID/8; //13
	parameter IDWID = 8;
	parameter PRIOR = 8; // 8-bit priority
	parameter TOTALWID = KWID+MASKWID+PRIOR;

// ==========================================================================
// == Local Parameters
// ==========================================================================
	localparam N = 10;
	
	localparam R1	= 8'h00;
	localparam R2	= 8'h01;
	localparam R3	= 8'h02;
	localparam R4	= 8'h03;
	localparam R5	= 8'h04;
	localparam R6	= 8'h05;
	localparam R7	= 8'h06;
	localparam R8	= 8'h07;
	localparam R9	= 8'h08;
	localparam R10	= 8'h09;
	
	localparam MATCH = 1'b1;
	localparam NO_MATCH = 1'b0;
	
// =============================================================================
// == Port Declarations
// =============================================================================
	reg clk;
	reg rst;
	
	// for searching purpose 
	reg [KWID-1:0]   i_Key;
	wire [IDWID-1:0] o_RuleID;
	wire 			 o_Valid;
	
	// for setting purpose
	wire 				o_Set_Done;
	reg [TOTALWID-1:0] 	i_Set_String;
	reg [IDWID-1:0]		i_Set_ID;
	
	reg 				i_Set_Enable;
	
// ==========================================================================
// == Component Instatiation : Device Under Test (DUT)
// ==========================================================================
	tcam	TCAM_Inst
		(
			.clk(clk),
			.rst(rst),
			
			// for Searching purpose
			// == Input and Output
			.i_Key(i_Key),
			.o_RuleID(o_RuleID),
			.o_Valid(o_Valid),
			
			// for Setting purpose
			.o_Set_Done(o_Set_Done),
			.i_Set_ID(i_Set_ID),	
			.i_Set_String(i_Set_String),
			.i_Set_Enable(i_Set_Enable)
		);
	
// ==========================================================================
// == Signal Declarations
// ==========================================================================
	// -- searching 
	reg [KWID-1:0] key_arr [10:0];
	
	// -- setting data
	reg [TOTALWID-1:0] Input_String [9:0];
	reg [IDWID-1:0]	Input_ID [9:0];
	
	// -- Expected Segment Vector
	reg [VTWID-1:0] Expected_Vector [9:0];
	
	// -- Expected Mask Vectors
	reg [VTWID-1:0]	Expected_Vector_Seg1 [12:0];
	reg [VTWID-1:0]	Expected_Vector_Seg2 [12:0];
	reg [VTWID-1:0]	Expected_Vector_Seg3 [12:0];
	reg [VTWID-1:0]	Expected_Vector_Seg4 [12:0];
	reg [VTWID-1:0]	Expected_Vector_Seg5 [12:0];
	reg [VTWID-1:0]	Expected_Vector_Seg6 [12:0];
	reg [VTWID-1:0]	Expected_Vector_Seg7 [12:0];
	reg [VTWID-1:0]	Expected_Vector_Seg8 [12:0];
	reg [VTWID-1:0]	Expected_Vector_Seg9 [12:0];
	reg [VTWID-1:0]	Expected_Vector_Seg10 [12:0];
	
	// -- Expected Confirm Results
	reg [CFWID-1:0] Expected_Confirm_Vector_Seg1 [12:0];
	reg [CFWID-1:0] Expected_Confirm_Vector_Seg2 [12:0];
	reg [CFWID-1:0] Expected_Confirm_Vector_Seg3 [12:0];
	reg [CFWID-1:0] Expected_Confirm_Vector_Seg4 [12:0];
	reg [CFWID-1:0] Expected_Confirm_Vector_Seg5 [12:0];
	reg [CFWID-1:0] Expected_Confirm_Vector_Seg6 [12:0];
	reg [CFWID-1:0] Expected_Confirm_Vector_Seg7 [12:0];
	reg [CFWID-1:0] Expected_Confirm_Vector_Seg8 [12:0];
	reg [CFWID-1:0] Expected_Confirm_Vector_Seg9 [12:0];
	reg [CFWID-1:0] Expected_Confirm_Vector_Seg10 [12:0];
	
	// -- Expected ID
	reg [IDWID-1:0] Expected_ID [9:0];
	
	// -- iteration control 
	integer i;
	
// ==========================================================================
// == Architecture of Test Bench
// ==========================================================================
	// ===================================================================
	// == Data Initialization
	// ===================================================================
	initial
	begin
		// ===================================================================
		// == Searching
		// ===================================================================
		key_arr[0] = 104'h40_5B_6A_00_A4_68_00_00_FF_FF_FF_FF_FF;
		key_arr[1] = 104'h40_5B_6B_3A_40_5B_6C_00_FF_FF_FF_FF_FF;
		key_arr[2] = 104'h40_5B_6B_3C_FB_E2_E9_00_FF_FF_FF_FF_FF;
		key_arr[3] = 104'hC0_97_0B_00_00_00_00_00_FF_FF_FF_FF_FF;
		key_arr[4] = 104'hC0_97_0B_7F_D0_B8_BC_27_FF_FF_FF_FF_FF;
		key_arr[5] = 104'h5F_69_8F_26_0F_00_00_00_FF_FF_FF_FF_FF;
		key_arr[6] = 104'h5F_69_8F_38_AF_55_44_F5_FF_FF_FF_FF_FF;
		key_arr[7] = 104'h40_5B_6A_00_88_00_00_00_FF_FF_FF_FF_FF;
		key_arr[8] = 104'hC0_97_0B_36_00_00_00_00_FF_FF_FF_FF_FF;
		key_arr[9] = 104'hC0_97_0B_29_0F_00_78_04_FF_FF_FF_FF_FF;
		key_arr[10] = 104'h40_5B_6A_00_A4_68_00_00_FF_FF_FF_FF_FF;
	
		// ===================================================================
		// == Setting
		// ===================================================================		
		// -- String initialization
		Input_String[0] = {8'h00, 13'b0001001100000, 104'h40_5B_6A_00_A4_68_00_00_FF_FF_FF_FF_FF};
		Input_String[1] = {8'h01, 13'b0000000100000, 104'h40_5B_6B_3A_40_5B_6C_00_FF_FF_FF_FF_FF};
		Input_String[2] = {8'h02, 13'b0000000100000, 104'h40_5B_6B_3C_FB_E2_E9_00_FF_FF_FF_FF_FF};
		Input_String[3] = {8'h03, 13'b0001011100000, 104'hC0_97_0B_00_00_00_00_00_FF_FF_FF_FF_FF};
		Input_String[4] = {8'h04, 13'b0000000000000, 104'hC0_97_0B_7F_D0_B8_BC_27_FF_FF_FF_FF_FF};
		Input_String[5] = {8'h05, 13'b0000011100000, 104'h5F_69_8F_26_0F_00_00_00_FF_FF_FF_FF_FF};
		Input_String[6] = {8'h06, 13'b0000000000000, 104'h5F_69_8F_38_AF_55_44_F5_FF_FF_FF_FF_FF};
		Input_String[7] = {8'h07, 13'b0001011100000, 104'h40_5B_6A_00_88_00_00_00_FF_FF_FF_FF_FF};
		Input_String[8] = {8'h08, 13'b0000011100000, 104'hC0_97_0B_36_00_00_00_00_FF_FF_FF_FF_FF};
		Input_String[9] = {8'h09, 13'b0000000000000, 104'hC0_97_0B_29_0F_00_78_04_FF_FF_FF_FF_FF};
		
		// -- ID initialization 
		Input_ID[0] = R1;	// rule R1
		Input_ID[1] = R2;	// rule R2
		Input_ID[2] = R3;	// rule R3
		Input_ID[3] = R4;	// rule R4
		Input_ID[4] = R5;	// rule R5
		Input_ID[5] = R6;	// rule R6
		Input_ID[6] = R7;	// rule R7
		Input_ID[7] = R8;	// rule R8
		Input_ID[8] = R9;	// rule R9
		Input_ID[9] = R10;	// rule R10
	end
	
	// ===================================================================
	// == Expect Result
	// ===================================================================
	initial
	begin 
		// -- Expected Result 
		// -- Expected ID Seg 1
		Expected_ID[0] = R1;
		Expected_ID[1] = R2;
		Expected_ID[2] = R3;
		Expected_ID[3] = 8'b0;
		Expected_ID[4] = R5;
		Expected_ID[5] = R6;
		Expected_ID[6] = R7;
		Expected_ID[7] = R8;
		Expected_ID[8] = R9;
		Expected_ID[9] = R10;
	end
	
// ==========================================================================
// == Process Begin
// ==========================================================================
	// -- Generate Clock
	always #10 clk = ~clk;
	
	// -- Architecture goes here
	initial
	begin
		{clk, i_Set_Enable} = 0;
		
		// -- power up reset, then deactivate it
		rst = 1;
		repeat (2) @(negedge clk);
		rst = 0;
		
		// -- Setting all goes here
		for (i = 0; i < N; i = i + 1)
		begin 
			set (					
				Input_String[i],
				Input_ID[i]
			);
		end
		
		@(negedge clk);
		
		for (i = 0; i < N+1; i = i + 1)
		begin 
			search(key_arr[i]);
		end 
	
		repeat (3) @(negedge clk);
		
		for (i = 0; i < N; i = i + 1)
		begin 
			confirm_id(Expected_ID[i]);
		end 
		
		$finish;
	end
	
// ==========================================================================
// == Tasks & Functions
// ==========================================================================
	// -----------------------------------------
	// -- Setting all 
	task set;
		input [TOTALWID-1:0] 	str;
		input [IDWID-1:0]		id;
		// -- process
		begin 
			repeat (2) @(negedge clk)
			begin
				// -- setting enable
				i_Set_Enable = 1'b1;
				
				// -- setting data
				i_Set_String = str;
				i_Set_ID = id;
			end

			@(negedge clk);
			
			// -- deactivate enables 
			i_Set_Enable = 1'b0;
			
		end // -- end process 
	endtask 
	
	// -----------------------------------------
	// -- Searching 
	task search;
		input [KWID-1:0] key;
		// -- process 
		begin 
			i_Key = key; 
			@(negedge clk);
		end // -- end process
	endtask 
	
	// -- Confirm ID Expectation
	task confirm_id;
		input [IDWID-1:0] expected_id;
		// -- process 
		begin 
			if (o_RuleID == expected_id)	$display("%t : Valid bit: %b -> Correct ID", $time, o_Valid);
			else							$display("%t : Valid bit: %b -> gnerated 0x%04x - expected 0x%04x -", $time, o_Valid, o_RuleID, expected_id);	
			
			@(negedge clk);
		end // -- end process 
	endtask
endmodule 