module tb_wrapper (); 
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
	
	reg [KWID-1:0]   i_Key;
	wire [IDWID-1:0] o_RuleID;
	wire 			 o_Invalid;
	
	// == Segment Engine 
	reg [KWID-1:0]  i_Set_Key;
	reg [VTWID-1:0] i_Set_Vector_ID;
	reg 		 	 i_Set_Segment_Enable;
	
	// == Mask Engine 
	reg [IDWID-1:0]   i_Set_Mask_ID;
	reg [MASKWID-1:0] i_Set_Mask_Vector;
	reg 			  i_Set_Mask_Enable;
	
	// == Confirmation Engine
	reg [IDWID-1:0] 	i_Set_Confirm_ID;
	reg [TOTALWID-1:0] 	i_Set_Confirm_String;
	reg 				i_Set_Confirm_Enable;
	
// ==========================================================================
// == Component Instatiation : Device Under Test (DUT)
// ==========================================================================
	wrapper		TCAM_Inst
		(
			.clk(clk),
			.rst(rst),
			
			// for Searching purpose
			// == Input and Output
			.i_Key(i_Key),
			.o_RuleID(o_RuleID),
			.o_Invalid(o_Invalid),
			
			// for Setting purpose
			// == Segment Engine 
			.i_Set_Key(i_Set_Key),
			.i_Set_Vector_ID(i_Set_Vector_ID),
			.i_Set_Segment_Enable(i_Set_Segment_Enable),
			
			// == Mask Engine 
			.i_Set_Mask_ID(i_Set_Mask_ID),
			.i_Set_Mask_Vector(i_Set_Mask_Vector),
			.i_Set_Mask_Enable(i_Set_Mask_Enable), 
			
			// == Confirm Engine
			.i_Set_Confirm_ID(i_Set_Confirm_ID),	
			.i_Set_Confirm_String(i_Set_Confirm_String),
			.i_Set_Confirm_Enable(i_Set_Confirm_Enable)
		);
	

// ==========================================================================
// == Signal Declarations
// ==========================================================================
	// -- segment data
	reg [KWID-1:0] key_arr [9:0];
	reg [VTWID-1:0] rule_arr [9:0];
	
	// -- mask data
	reg [MASKWID-1:0] Input_Mask_Data [9:0];
	reg [IDWID-1:0] Input_Rule_ID [9:0];
	
	// -- confirm data
	reg [TOTALWID-1:0] Input_Confirm_String [9:0];
	reg [IDWID-1:0]	Input_Confirm_ID [9:0];
	
	// -- Expected ID
	reg [IDWID-1:0] Expected_ID [9:0];
	
	// -- iteration control 
	integer i;
	
// ==========================================================================
// == Architecture of Test Bench
// ==========================================================================
	// == Data Initialization:
	initial
	begin
		// ===================================================================
		// == Segment Data for Setting
		// ===================================================================
		// key initialization
		key_arr[0] = 104'h40_5B_6A_00_A4_68_00_00_FF_FF_FF_FF_FF;	// key at address (rule) R1
		key_arr[1] = 104'h40_5B_6B_3A_40_5B_6C_00_FF_FF_FF_FF_FF;	// key at address (rule) R2
		key_arr[2] = 104'h40_5B_6B_3C_FB_E2_E9_00_FF_FF_FF_FF_FF;	// key at address (rule) R3
		key_arr[3] = 104'hC0_97_0B_00_00_00_00_00_FF_FF_FF_FF_FF;	// key at address (rule) R4
		key_arr[4] = 104'hC0_97_0B_7F_D0_B8_BC_27_FF_FF_FF_FF_FF;	// key at address (rule) R5
		key_arr[5] = 104'h5F_69_8F_26_0F_00_00_00_FF_FF_FF_FF_FF;	// key at address (rule) R6
		key_arr[6] = 104'h5F_69_8F_38_AF_55_44_F5_FF_FF_FF_FF_FF;	// key at address (rule) R7
		key_arr[7] = 104'h40_5B_6A_00_88_00_00_00_FF_FF_FF_FF_FF;	// key at address (rule) R8
		key_arr[8] = 104'hC0_97_0B_36_00_00_00_00_FF_FF_FF_FF_FF;	// key at address (rule) R9
		key_arr[9] = 104'hC0_97_0B_29_0F_00_78_04_FF_FF_FF_FF_FF;	// key at address (rule) R10
	
		// rule initialization
		rule_arr[0] = {13{2'b01,8'h00}};	// rule R1
		rule_arr[1] = {13{2'b01,8'h01}};	// rule R2
		rule_arr[2] = {13{2'b01,8'h02}};	// rule R3
		rule_arr[3] = {13{2'b01,8'h03}};	// rule R4
		rule_arr[4] = {13{2'b01,8'h04}};	// rule R5
		rule_arr[5] = {13{2'b01,8'h05}};	// rule R6
		rule_arr[6] = {13{2'b01,8'h06}};	// rule R7
		rule_arr[7] = {13{2'b01,8'h07}};	// rule R8
		rule_arr[8] = {13{2'b01,8'h08}};	// rule R9
		rule_arr[9] = {13{2'b01,8'h09}};	// rule R10
		
		// ===================================================================
		// == Mask Data for Setting
		// ===================================================================
		Input_Mask_Data[0] = 13'b0001001100000;
		Input_Mask_Data[1] = 13'b0000000100000;
		Input_Mask_Data[2] = 13'b0000000100000;
		Input_Mask_Data[3] = 13'b0001011100000;
		Input_Mask_Data[4] = 13'b0000000000000;
		Input_Mask_Data[5] = 13'b0000011100000;
		Input_Mask_Data[6] = 13'b0000000000000;
		Input_Mask_Data[7] = 13'b0001011100000;
		Input_Mask_Data[8] = 13'b0000011100000;
		Input_Mask_Data[9] = 13'b0000000000000;
		
		// -- Rule ID for Setting
		Input_Rule_ID[0] = R1;	// rule R1
		Input_Rule_ID[1] = R2;	// rule R2
		Input_Rule_ID[2] = R3;	// rule R3
		Input_Rule_ID[3] = R4;	// rule R4
		Input_Rule_ID[4] = R5;	// rule R5
		Input_Rule_ID[5] = R6;	// rule R6
		Input_Rule_ID[6] = R7;	// rule R7
		Input_Rule_ID[7] = R8;	// rule R8
		Input_Rule_ID[8] = R9;	// rule R9
		Input_Rule_ID[9] = R10;	// rule R10
		
		// ===================================================================
		// == Confirm
		// ===================================================================		
		// -- String initialization
		Input_Confirm_String[0] = {8'h00, 13'b0001001100000, 104'h40_5B_6A_00_A4_68_00_00_FF_FF_FF_FF_FF};
		Input_Confirm_String[1] = {8'h01, 13'b0000000100000, 104'h40_5B_6B_3A_40_5B_6C_00_FF_FF_FF_FF_FF};
		Input_Confirm_String[2] = {8'h02, 13'b0000000100000, 104'h40_5B_6B_3C_FB_E2_E9_00_FF_FF_FF_FF_FF};
		Input_Confirm_String[3] = {8'h03, 13'b0001011100000, 104'hC0_97_0B_00_00_00_00_00_FF_FF_FF_FF_FF};
		Input_Confirm_String[4] = {8'h04, 13'b0000000000000, 104'hC0_97_0B_7F_D0_B8_BC_27_FF_FF_FF_FF_FF};
		Input_Confirm_String[5] = {8'h05, 13'b0000011100000, 104'h5F_69_8F_26_0F_00_00_00_FF_FF_FF_FF_FF};
		Input_Confirm_String[6] = {8'h06, 13'b0000000000000, 104'h5F_69_8F_38_AF_55_44_F5_FF_FF_FF_FF_FF};
		Input_Confirm_String[7] = {8'h07, 13'b0001011100000, 104'h40_5B_6A_00_88_00_00_00_FF_FF_FF_FF_FF};
		Input_Confirm_String[8] = {8'h08, 13'b0000011100000, 104'hC0_97_0B_36_00_00_00_00_FF_FF_FF_FF_FF};
		Input_Confirm_String[9] = {8'h09, 13'b0000000000000, 104'hC0_97_0B_29_0F_00_78_04_FF_FF_FF_FF_FF};
		
		// -- Confirmation ID 
		Input_Confirm_ID[0] = R1;	// rule R1
		Input_Confirm_ID[1] = R2;	// rule R2
		Input_Confirm_ID[2] = R3;	// rule R3
		Input_Confirm_ID[3] = R4;	// rule R4
		Input_Confirm_ID[4] = R5;	// rule R5
		Input_Confirm_ID[5] = R6;	// rule R6
		Input_Confirm_ID[6] = R7;	// rule R7
		Input_Confirm_ID[7] = R8;	// rule R8
		Input_Confirm_ID[8] = R9;	// rule R9
		Input_Confirm_ID[9] = R10;	// rule R10
		
		// ===================================================================
		// == Expect Result
		// ===================================================================
		// -- Expected Result 
		// -- Expected ID Seg 1
		Expected_ID[0] = R1;
		Expected_ID[1] = R2;
		Expected_ID[2] = R3;
		Expected_ID[3] = 8'bx;
		Expected_ID[4] = R5;
		Expected_ID[5] = R6;
		Expected_ID[6] = R7;
		Expected_ID[7] = R8;
		Expected_ID[8] = R9;
		Expected_ID[9] = R10;
	end
	
	// -- Generate Clock
	always #10 clk = ~clk;
	
	// -- Architecture goes here
	initial
	begin
		clk = 0;
		
		// -- power up reset, then deactivate it
		rst = 1;
		repeat (2) @(negedge clk);
		rst = 0;
		
		// -- Setting all goes here
		for (i = 0; i < N; i = i + 1)
			set (					
				key_arr[i],
				rule_arr[i],
				Input_Mask_Data[i],
				Input_Rule_ID[i],
				Input_Confirm_String[i]
			);
		
		@(negedge clk);
		
		// -- Searching goes here
		for (i = 0; i < N; i = i + 1)
			search(key_arr[i], Expected_ID[i]); 
		
		@(negedge clk);
		$finish;
	end
	
// ==========================================================================
// == Tasks & Functions
// ==========================================================================
	// -----------------------------------------
	// -- Setting all 
	task set;
		input [KWID-1:0] 		key;
		input [VTWID-1:0] 		rule_vector; 
		input [MASKWID-1:0] 	mask_data;
		input [IDWID-1:0]		rule;
		input [TOTALWID-1:0] 	str;
		// -- process
		begin 
			repeat (2) @(negedge clk)
			begin
				// -- setting enable
				i_Set_Segment_Enable = 1'b1;
				i_Set_Mask_Enable = 1'b1;
				i_Set_Confirm_Enable = 1'b1;
				
				// -- Segment setting 
				i_Set_Key = key;
				i_Set_Vector_ID = rule_vector;
				
				// -- Mask setting 
				i_Set_Mask_Vector = mask_data;
				i_Set_Mask_ID = rule;
				
				// -- Confirm setting 
				i_Set_Confirm_String = str;
				i_Set_Confirm_ID = rule;
			end

			@(negedge clk);
			
			// -- deactivate enables 
			i_Set_Segment_Enable = 1'b0;
			i_Set_Mask_Enable = 1'b0;
			i_Set_Confirm_Enable = 1'b0;
			
		end // process 
	endtask 
	
	// -----------------------------------------
	// -- Searching 
	task search;
		input [KWID-1:0] key;
		input [IDWID-1:0] expected_id;
		// -- process 
		begin 
			i_Key = key;
			
			repeat (13) @(negedge clk);
			
			if (o_RuleID == expected_id)	$display("%t : Correct ID", $time);
			else							$display("%t : gnerated 0x%04x - expected 0x%04x", $time, o_RuleID, expected_id);				
		end // process
	endtask 
endmodule 