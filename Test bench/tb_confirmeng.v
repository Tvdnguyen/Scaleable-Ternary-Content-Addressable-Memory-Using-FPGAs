module tb_confirmeng ();
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
	reg [KWID-1:0] 	 i_Key;
	
	reg [VTWID-1:0] i_Mask_Vector1;
	reg [VTWID-1:0] i_Mask_Vector2;
	reg [VTWID-1:0] i_Mask_Vector3;
	reg [VTWID-1:0] i_Mask_Vector4;
	reg [VTWID-1:0] i_Mask_Vector5;
	reg [VTWID-1:0] i_Mask_Vector6;
	reg [VTWID-1:0] i_Mask_Vector7;
	reg [VTWID-1:0] i_Mask_Vector8;
	reg [VTWID-1:0] i_Mask_Vector9;
	reg [VTWID-1:0] i_Mask_Vector10;
	reg [VTWID-1:0] i_Mask_Vector11;
	reg [VTWID-1:0] i_Mask_Vector12;
	reg [VTWID-1:0] i_Mask_Vector13;
	
	wire [CFWID-1:0] o_Confirm_Result1;
	wire [CFWID-1:0] o_Confirm_Result2;
	wire [CFWID-1:0] o_Confirm_Result3;
	wire [CFWID-1:0] o_Confirm_Result4;
	wire [CFWID-1:0] o_Confirm_Result5;
	wire [CFWID-1:0] o_Confirm_Result6;
	wire [CFWID-1:0] o_Confirm_Result7;
	wire [CFWID-1:0] o_Confirm_Result8;
	wire [CFWID-1:0] o_Confirm_Result9;
	wire [CFWID-1:0] o_Confirm_Result10;
	wire [CFWID-1:0] o_Confirm_Result11;
	wire [CFWID-1:0] o_Confirm_Result12;
	wire [CFWID-1:0] o_Confirm_Result13;
	
	// for setting purpose
	reg [IDWID-1:0] i_Set_Confirm_ID;
	reg [TOTALWID-1:0] i_Set_Confirm_String;
	reg i_Set_Confirm_Enable;

// ==========================================================================
// == Component Instatiation : Device Under Test (DUT)
// ==========================================================================
	confirmeng 	Confirm_Engine_Inst
		(
			.clk(clk),
			.rst(rst),
			
			// for searching purpose
			.i_Key(i_Key),
			
			.i_Mask_Vector1(i_Mask_Vector1),
			.i_Mask_Vector2(i_Mask_Vector2),
			.i_Mask_Vector3(i_Mask_Vector3),
			.i_Mask_Vector4(i_Mask_Vector4),
			.i_Mask_Vector5(i_Mask_Vector5),
			.i_Mask_Vector6(i_Mask_Vector6),
			.i_Mask_Vector7(i_Mask_Vector7),
			.i_Mask_Vector8(i_Mask_Vector8),
			.i_Mask_Vector9(i_Mask_Vector9),
			.i_Mask_Vector10(i_Mask_Vector10),
			.i_Mask_Vector11(i_Mask_Vector11),
			.i_Mask_Vector12(i_Mask_Vector12),
			.i_Mask_Vector13(i_Mask_Vector13),
			
			.o_Confirm_Result1(o_Confirm_Result1),
			.o_Confirm_Result2(o_Confirm_Result2),
			.o_Confirm_Result3(o_Confirm_Result3),
			.o_Confirm_Result4(o_Confirm_Result4),
			.o_Confirm_Result5(o_Confirm_Result5),
			.o_Confirm_Result6(o_Confirm_Result6),
			.o_Confirm_Result7(o_Confirm_Result7),
			.o_Confirm_Result8(o_Confirm_Result8),
			.o_Confirm_Result9(o_Confirm_Result9),
			.o_Confirm_Result10(o_Confirm_Result10),
			.o_Confirm_Result11(o_Confirm_Result11),
			.o_Confirm_Result12(o_Confirm_Result12),
			.o_Confirm_Result13(o_Confirm_Result13),
			
			// for setting purpose
			.i_Set_Confirm_ID(i_Set_Confirm_ID),	
			.i_Set_Confirm_String(i_Set_Confirm_String),
			.i_Set_Confirm_Enable(i_Set_Confirm_Enable)
		);
	 
// ==========================================================================
// == Signal Declarations
// ==========================================================================
// ===== For Setting Purpose
	reg [TOTALWID-1:0] Input_Confirm_String [9:0];
	reg [IDWID-1:0]	Input_Confirm_ID [9:0];
	
	reg [KWID-1:0] Input_Key [9:0];
	
	reg [VTWID-1:0] Mask_Vector_Seg1 [12:0];
	reg [VTWID-1:0] Mask_Vector_Seg2 [12:0];
	reg [VTWID-1:0] Mask_Vector_Seg3 [12:0];
	reg [VTWID-1:0] Mask_Vector_Seg4 [12:0];
	reg [VTWID-1:0] Mask_Vector_Seg5 [12:0];
	reg [VTWID-1:0] Mask_Vector_Seg6 [12:0];
	reg [VTWID-1:0] Mask_Vector_Seg7 [12:0];
	reg [VTWID-1:0] Mask_Vector_Seg8 [12:0];
	reg [VTWID-1:0] Mask_Vector_Seg9 [12:0];
	reg [VTWID-1:0] Mask_Vector_Seg10 [12:0];
	
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
	
	// -- Iteration Control
	integer i;

// ==========================================================================
// == Architecture of Test Bench
// ==========================================================================
// == Data Initialization:
	initial 
	begin
		// -- Key Initialization
		Input_Key[0] = 104'h40_5B_6A_00_A4_68_00_00_FF_FF_FF_FF_FF;	// key at address (rule) R1
		Input_Key[1] = 104'h40_5B_6B_3A_40_5B_6C_00_FF_FF_FF_FF_FF;	// key at address (rule) R2
		Input_Key[2] = 104'h40_5B_6B_3C_FB_E2_E9_00_FF_FF_FF_FF_FF;	// key at address (rule) R3
		Input_Key[3] = 104'hC0_97_0B_00_00_00_00_00_FF_FF_FF_FF_FF;	// key at address (rule) R4
		Input_Key[4] = 104'hC0_97_0B_7F_D0_B8_BC_27_FF_FF_FF_FF_FF;	// key at address (rule) R5
		Input_Key[5] = 104'h5F_69_8F_26_0F_00_00_00_FF_FF_FF_FF_FF;	// key at address (rule) R6
		Input_Key[6] = 104'h5F_69_8F_38_AF_55_44_F5_FF_FF_FF_FF_FF;	// key at address (rule) R7
		Input_Key[7] = 104'h40_5B_6A_00_88_00_00_00_FF_FF_FF_FF_FF;	// key at address (rule) R8
		Input_Key[8] = 104'hC0_97_0B_36_00_00_00_00_FF_FF_FF_FF_FF;	// key at address (rule) R9
		Input_Key[9] = 104'hC0_97_0B_29_0F_00_78_04_FF_FF_FF_FF_FF;	// key at address (rule) R10
		
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
		Input_Confirm_ID[0] = 8'h00;	// rule R1
		Input_Confirm_ID[1] = 8'h01;	// rule R2
		Input_Confirm_ID[2] = 8'h02;	// rule R3
		Input_Confirm_ID[3] = 8'h03;	// rule R4
		Input_Confirm_ID[4] = 8'h04;	// rule R5
		Input_Confirm_ID[5] = 8'h05;	// rule R6
		Input_Confirm_ID[6] = 8'h06;	// rule R7
		Input_Confirm_ID[7] = 8'h07;	// rule R8
		Input_Confirm_ID[8] = 8'h08;	// rule R9
		Input_Confirm_ID[9] = 8'h09;	// rule R10
		
		// -- Mask Vectors
		// -- Mask Vector Seg 1
		Mask_Vector_Seg1[0]  = {13{2'b11, R1}};
		Mask_Vector_Seg1[1]  = {13{2'b11, R1}};
		Mask_Vector_Seg1[2]  = {13{2'b11, R1}};
		Mask_Vector_Seg1[3]  = {13{2'b11, R1}};
		Mask_Vector_Seg1[4]  = {13{2'b11, R1}};
		Mask_Vector_Seg1[5]  = {13{2'b11, R1}};
		Mask_Vector_Seg1[6]  = {13{2'b11, R1}};
		Mask_Vector_Seg1[7]  = {{4{2'b11, R1}}, {2{2'b01, R1}}, {7{2'b11, R1}}};
		Mask_Vector_Seg1[8]  = {{4{2'b11, R1}}, {2{2'b01, R1}}, {7{2'b11, R1}}};
		Mask_Vector_Seg1[9]  = {13{2'b11, R1}};
		Mask_Vector_Seg1[10] = {13{2'b11, R1}};
		Mask_Vector_Seg1[11] = {13{2'b11, R1}};
		Mask_Vector_Seg1[12] = {13{2'b11, R1}};
		
		// -- Mask Vector Seg 2
		Mask_Vector_Seg2[0]  = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		Mask_Vector_Seg2[1]  = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		Mask_Vector_Seg2[2]  = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		Mask_Vector_Seg2[3]  = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		Mask_Vector_Seg2[4]  = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		Mask_Vector_Seg2[5]  = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		Mask_Vector_Seg2[6]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b01, R2}}, {6{2'b11, R1}}};
		Mask_Vector_Seg2[7]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b01, R2}}, {6{2'b11, R1}}};
		Mask_Vector_Seg2[8]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b01, R2}}, {6{2'b11, R1}}};
		Mask_Vector_Seg2[9]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b01, R2}}, {6{2'b11, R1}}};
		Mask_Vector_Seg2[10] = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		Mask_Vector_Seg2[11] = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		Mask_Vector_Seg2[12] = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		
		// -- Mask Vector Seg 3
		Mask_Vector_Seg3[0]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		Mask_Vector_Seg3[1]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		Mask_Vector_Seg3[2]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		Mask_Vector_Seg3[3]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		Mask_Vector_Seg3[4]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		Mask_Vector_Seg3[5]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		Mask_Vector_Seg3[6]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b01, R3}}, {6{2'b11, R1}}};
		Mask_Vector_Seg3[7]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b01, R3}}, {6{2'b11, R1}}};
		Mask_Vector_Seg3[8]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b01, R3}}, {6{2'b11, R1}}};
		Mask_Vector_Seg3[9]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b01, R3}}, {6{2'b11, R1}}};
		Mask_Vector_Seg3[10] = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		Mask_Vector_Seg3[11] = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		Mask_Vector_Seg3[12] = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		
		// -- Mask Vector Seg 4
		Mask_Vector_Seg4[0]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg4[1]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg4[2]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg4[3]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg4[4]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg4[5]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg4[6]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg4[7]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg4[8]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg4[9]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg4[10] = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg4[11] = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg4[12] = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		
		// -- Mask Vector Seg 5
		Mask_Vector_Seg5[0]  = {{3{2'b11, R4}}, {5{2'b11, R5}}, {5{2'b11, R1}}};
		Mask_Vector_Seg5[1]  = {{3{2'b11, R4}}, {5{2'b11, R5}}, {5{2'b11, R1}}};
		Mask_Vector_Seg5[2]  = {{3{2'b11, R4}}, {5{2'b11, R5}}, {5{2'b11, R1}}};
		Mask_Vector_Seg5[3]  = {{3{2'b11, R4}}, {5{2'b11, R5}}, {5{2'b11, R1}}};
		Mask_Vector_Seg5[4]  = {{3{2'b11, R4}}, {5{2'b11, R5}}, {5{2'b11, R1}}};
		Mask_Vector_Seg5[5]  = {{3{2'b11, R4}}, {5{2'b01, R5}}, {5{2'b11, R1}}};
		Mask_Vector_Seg5[6]  = {{3{2'b11, R4}}, {5{2'b01, R5}}, {5{2'b11, R1}}};
		Mask_Vector_Seg5[7]  = {{3{2'b11, R4}}, {5{2'b01, R5}}, {5{2'b11, R1}}};
		Mask_Vector_Seg5[8]  = {{3{2'b11, R4}}, {5{2'b01, R5}}, {5{2'b11, R1}}};
		Mask_Vector_Seg5[9]  = {{3{2'b11, R4}}, {5{2'b01, R5}}, {5{2'b11, R1}}};
		Mask_Vector_Seg5[10] = {{3{2'b11, R4}}, {5{2'b11, R5}}, {5{2'b11, R1}}};
		Mask_Vector_Seg5[11] = {{3{2'b11, R4}}, {5{2'b11, R5}}, {5{2'b11, R1}}};
		Mask_Vector_Seg5[12] = {{3{2'b11, R4}}, {5{2'b11, R5}}, {5{2'b11, R1}}};
		
		// -- Mask Vector Seg 6
		Mask_Vector_Seg6[0]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg6[1]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg6[2]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg6[3]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg6[4]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg6[5]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg6[6]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg6[7]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg6[8]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg6[9]  = {{3{2'b11, R6}}, {1{2'b01, R6}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg6[10] = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg6[11] = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg6[12] = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		
		// -- Mask Vector Seg 7
		Mask_Vector_Seg7[0]  = {{3{2'b11, R6}}, {5{2'b11, R7}}, {5{2'b11, R1}}};
		Mask_Vector_Seg7[1]  = {{3{2'b11, R6}}, {5{2'b11, R7}}, {5{2'b11, R1}}};
		Mask_Vector_Seg7[2]  = {{3{2'b11, R6}}, {5{2'b11, R7}}, {5{2'b11, R1}}};
		Mask_Vector_Seg7[3]  = {{3{2'b11, R6}}, {5{2'b11, R7}}, {5{2'b11, R1}}};
		Mask_Vector_Seg7[4]  = {{3{2'b11, R6}}, {5{2'b11, R7}}, {5{2'b11, R1}}};
		Mask_Vector_Seg7[5]  = {{3{2'b11, R6}}, {5{2'b01, R7}}, {5{2'b11, R1}}};
		Mask_Vector_Seg7[6]  = {{3{2'b11, R6}}, {5{2'b01, R7}}, {5{2'b11, R1}}};
		Mask_Vector_Seg7[7]  = {{3{2'b11, R6}}, {5{2'b01, R7}}, {5{2'b11, R1}}};
		Mask_Vector_Seg7[8]  = {{3{2'b11, R6}}, {5{2'b01, R7}}, {5{2'b11, R1}}};
		Mask_Vector_Seg7[9]  = {{3{2'b11, R6}}, {5{2'b01, R7}}, {5{2'b11, R1}}};
		Mask_Vector_Seg7[10] = {{3{2'b11, R6}}, {5{2'b11, R7}}, {5{2'b11, R1}}};
		Mask_Vector_Seg7[11] = {{3{2'b11, R6}}, {5{2'b11, R7}}, {5{2'b11, R1}}};
		Mask_Vector_Seg7[12] = {{3{2'b11, R6}}, {5{2'b11, R7}}, {5{2'b11, R1}}};
		
		// -- Mask Vector Seg 8
		Mask_Vector_Seg8[0]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg8[1]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg8[2]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg8[3]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg8[4]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg8[5]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg8[6]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg8[7]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg8[8]  = {{4{2'b11, R1}}, {1{2'b01, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg8[9]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg8[10] = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg8[11] = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg8[12] = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		
		// -- Mask Vector Seg 9
		Mask_Vector_Seg9[0]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg9[1]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg9[2]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg9[3]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg9[4]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg9[5]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg9[6]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg9[7]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg9[8]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg9[9]  = {{3{2'b11, R4}}, {1{2'b01, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg9[10] = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg9[11] = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Mask_Vector_Seg9[12] = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		
		// -- Mask Vector Seg 10
		Mask_Vector_Seg10[0]  = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Mask_Vector_Seg10[1]  = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Mask_Vector_Seg10[2]  = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Mask_Vector_Seg10[3]  = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Mask_Vector_Seg10[4]  = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Mask_Vector_Seg10[5]  = {{3{2'b11, R4}}, {1{2'b01, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b01, R10}}, {5{2'b11, R1}}};
		Mask_Vector_Seg10[6]  = {{3{2'b11, R4}}, {1{2'b01, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b01, R10}}, {5{2'b11, R1}}};
		Mask_Vector_Seg10[7]  = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Mask_Vector_Seg10[8]  = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Mask_Vector_Seg10[9]  = {{3{2'b11, R4}}, {1{2'b01, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b01, R10}}, {5{2'b11, R1}}};
		Mask_Vector_Seg10[10] = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Mask_Vector_Seg10[11] = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Mask_Vector_Seg10[12] = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		
		// -- Expected Confirm Result
		// -- Expected Confirm Vector Seg 1
		Expected_Confirm_Vector_Seg1[0]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg1[1]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg1[2]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg1[3]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg1[4]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg1[5]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg1[6]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg1[7]  = {MATCH, R1, R1};
		Expected_Confirm_Vector_Seg1[8]  = {MATCH, R1, R1};
		Expected_Confirm_Vector_Seg1[9]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg1[10] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg1[11] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg1[12] = {NO_MATCH, R1, R1};
		
		// -- Expected Confirm Vector Seg 2
		Expected_Confirm_Vector_Seg2[0]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg2[1]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg2[2]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg2[3]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg2[4]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg2[5]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg2[6]  = {MATCH, R2, R2};
		Expected_Confirm_Vector_Seg2[7]  = {MATCH, R2, R2};
		Expected_Confirm_Vector_Seg2[8]  = {MATCH, R2, R2};
		Expected_Confirm_Vector_Seg2[9]  = {MATCH, R2, R2};
		Expected_Confirm_Vector_Seg2[10] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg2[11] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg2[12] = {NO_MATCH, R1, R1};
		
		// -- Expected Confirm Vector Seg 3
		Expected_Confirm_Vector_Seg3[0]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg3[1]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg3[2]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg3[3]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg3[4]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg3[5]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg3[6]  = {MATCH, R3, R3};
		Expected_Confirm_Vector_Seg3[7]  = {MATCH, R3, R3};
		Expected_Confirm_Vector_Seg3[8]  = {MATCH, R3, R3};
		Expected_Confirm_Vector_Seg3[9]  = {MATCH, R3, R3};
		Expected_Confirm_Vector_Seg3[10] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg3[11] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg3[12] = {NO_MATCH, R1, R1};
		
		// -- Expected Confirm Vector Seg 4
		Expected_Confirm_Vector_Seg4[0]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg4[1]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg4[2]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg4[3]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg4[4]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg4[5]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg4[6]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg4[7]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg4[8]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg4[9]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg4[10] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg4[11] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg4[12] = {NO_MATCH, R1, R1};
		
		// -- Expected Confirm Vector Seg 5
		Expected_Confirm_Vector_Seg5[0]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg5[1]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg5[2]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg5[3]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg5[4]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg5[5]  = {MATCH, R5, R5};
		Expected_Confirm_Vector_Seg5[6]  = {MATCH, R5, R5};
		Expected_Confirm_Vector_Seg5[7]  = {MATCH, R5, R5};
		Expected_Confirm_Vector_Seg5[8]  = {MATCH, R5, R5};
		Expected_Confirm_Vector_Seg5[9]  = {MATCH, R5, R5};
		Expected_Confirm_Vector_Seg5[10] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg5[11] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg5[12] = {NO_MATCH, R1, R1};
		
		// -- Expected Confirm Vector Seg 6
		Expected_Confirm_Vector_Seg6[0]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg6[1]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg6[2]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg6[3]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg6[4]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg6[5]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg6[6]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg6[7]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg6[8]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg6[9]  = {MATCH, R6, R6};
		Expected_Confirm_Vector_Seg6[10] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg6[11] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg6[12] = {NO_MATCH, R1, R1};
		
		// -- Expected Confirm Vector Seg 7
		Expected_Confirm_Vector_Seg7[0]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg7[1]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg7[2]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg7[3]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg7[4]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg7[5]  = {MATCH, R7, R7};
		Expected_Confirm_Vector_Seg7[6]  = {MATCH, R7, R7};
		Expected_Confirm_Vector_Seg7[7]  = {MATCH, R7, R7};
		Expected_Confirm_Vector_Seg7[8]  = {MATCH, R7, R7};
		Expected_Confirm_Vector_Seg7[9]  = {MATCH, R7, R7};
		Expected_Confirm_Vector_Seg7[10] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg7[11] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg7[12] = {NO_MATCH, R1, R1};
		
		// -- Expected Confirm Vector Seg 8
		Expected_Confirm_Vector_Seg8[0]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg8[1]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg8[2]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg8[3]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg8[4]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg8[5]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg8[6]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg8[7]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg8[8]  = {MATCH, R8, R8};
		Expected_Confirm_Vector_Seg8[9]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg8[10] = {NO_MATCH, R1, R1}; 
		Expected_Confirm_Vector_Seg8[11] = {NO_MATCH, R1, R1}; 
		Expected_Confirm_Vector_Seg8[12] = {NO_MATCH, R1, R1};
		
		// -- Expected Confirm Vector Seg 9
		Expected_Confirm_Vector_Seg9[0]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg9[1]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg9[2]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg9[3]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg9[4]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg9[5]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg9[6]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg9[7]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg9[8]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg9[9]  = {MATCH, R9, R9};
		Expected_Confirm_Vector_Seg9[10] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg9[11] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg9[12] = {NO_MATCH, R1, R1};
		
		// -- Expected Confirm Vector Seg 10
		Expected_Confirm_Vector_Seg10[0]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg10[1]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg10[2]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg10[3]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg10[4]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg10[5]  = {MATCH, R10, R10};
		Expected_Confirm_Vector_Seg10[6]  = {MATCH, R10, R10};
		Expected_Confirm_Vector_Seg10[7]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg10[8]  = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg10[9]  = {MATCH, R10, R10};
		Expected_Confirm_Vector_Seg10[10] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg10[11] = {NO_MATCH, R1, R1};
		Expected_Confirm_Vector_Seg10[12] = {NO_MATCH, R1, R1};
	end 
	
	// Generate clock
	always #10 clk = ~clk;
	
	initial 
	begin
		// == Initialization
		clk = 0;
		
		@(negedge clk);
		
		// -- For setting purpose
		for (i = 0; i < N; i = i + 1) 
			set_confirm(Input_Confirm_String[i], Input_Confirm_ID[i]);
			
		// -- For searching purpose
		// -- Mask 1
		search_confirm ( 
			Input_Key[0],
			
			Mask_Vector_Seg1[0],
			Mask_Vector_Seg1[1],
			Mask_Vector_Seg1[2],
			Mask_Vector_Seg1[3],
			Mask_Vector_Seg1[4],
			Mask_Vector_Seg1[5],
			Mask_Vector_Seg1[6],
			Mask_Vector_Seg1[7],
			Mask_Vector_Seg1[8],
			Mask_Vector_Seg1[9],			
			Mask_Vector_Seg1[10],			
			Mask_Vector_Seg1[11],			
			Mask_Vector_Seg1[12]			
		);
		
		@(negedge clk); 	// 1
		
		// -- Mask 2
		search_confirm ( 
			Input_Key[1],
			
			Mask_Vector_Seg2[0],
			Mask_Vector_Seg2[1],
			Mask_Vector_Seg2[2],
			Mask_Vector_Seg2[3],
			Mask_Vector_Seg2[4],
			Mask_Vector_Seg2[5],
			Mask_Vector_Seg2[6],
			Mask_Vector_Seg2[7],
			Mask_Vector_Seg2[8],
			Mask_Vector_Seg2[9],			
			Mask_Vector_Seg2[10],			
			Mask_Vector_Seg2[11],			
			Mask_Vector_Seg2[12]			
		);
		
		@(negedge clk);		// 2
		
		// -- Mask 3
		search_confirm (
			Input_Key[2],
			
			Mask_Vector_Seg3[0],
			Mask_Vector_Seg3[1],
			Mask_Vector_Seg3[2],
			Mask_Vector_Seg3[3],
			Mask_Vector_Seg3[4],
			Mask_Vector_Seg3[5],
			Mask_Vector_Seg3[6],
			Mask_Vector_Seg3[7],
			Mask_Vector_Seg3[8],
			Mask_Vector_Seg3[9],			
			Mask_Vector_Seg3[10],			
			Mask_Vector_Seg3[11],			
			Mask_Vector_Seg3[12]			
		);
		
		@(negedge clk);		// 3
		
		// -- Mask 4
		search_confirm ( 
			Input_Key[3],
			
			Mask_Vector_Seg4[0],
			Mask_Vector_Seg4[1],
			Mask_Vector_Seg4[2],
			Mask_Vector_Seg4[3],
			Mask_Vector_Seg4[4],
			Mask_Vector_Seg4[5],
			Mask_Vector_Seg4[6],
			Mask_Vector_Seg4[7],
			Mask_Vector_Seg4[8],
			Mask_Vector_Seg4[9],			
			Mask_Vector_Seg4[10],			
			Mask_Vector_Seg4[11],			
			Mask_Vector_Seg4[12]			
		);
		
		@(negedge clk);		// 4
		
		// -- Mask 5
		search_confirm ( 
			Input_Key[4],
			
			Mask_Vector_Seg5[0],
			Mask_Vector_Seg5[1],
			Mask_Vector_Seg5[2],
			Mask_Vector_Seg5[3],
			Mask_Vector_Seg5[4],
			Mask_Vector_Seg5[5],
			Mask_Vector_Seg5[6],
			Mask_Vector_Seg5[7],
			Mask_Vector_Seg5[8],
			Mask_Vector_Seg5[9],			
			Mask_Vector_Seg5[10],			
			Mask_Vector_Seg5[11],			
			Mask_Vector_Seg5[12]			
		);
		
		@(negedge clk);		// 5
		
		// -- Mask 6
		search_confirm (
			Input_Key[5],
			
			Mask_Vector_Seg6[0],
			Mask_Vector_Seg6[1],
			Mask_Vector_Seg6[2],
			Mask_Vector_Seg6[3],
			Mask_Vector_Seg6[4],
			Mask_Vector_Seg6[5],
			Mask_Vector_Seg6[6],
			Mask_Vector_Seg6[7],
			Mask_Vector_Seg6[8],
			Mask_Vector_Seg6[9],			
			Mask_Vector_Seg6[10],			
			Mask_Vector_Seg6[11],			
			Mask_Vector_Seg6[12]			
		);
		
		@(negedge clk);		// 6
		
		// -- Mask 7
		search_confirm (
			Input_Key[6],
			
			Mask_Vector_Seg7[0],
			Mask_Vector_Seg7[1],
			Mask_Vector_Seg7[2],
			Mask_Vector_Seg7[3],
			Mask_Vector_Seg7[4],
			Mask_Vector_Seg7[5],
			Mask_Vector_Seg7[6],
			Mask_Vector_Seg7[7],
			Mask_Vector_Seg7[8],
			Mask_Vector_Seg7[9],			
			Mask_Vector_Seg7[10],			
			Mask_Vector_Seg7[11],			
			Mask_Vector_Seg7[12]			
		);
		
		@(negedge clk);		// 7
		
		// -- For confirm purpose
		$display("--------------------------------------- 13 CONFIRMs of Mask Vector Seg 1 ---------------------------------------");
		compare_confirm(1, o_Confirm_Result1, Expected_Confirm_Vector_Seg1[0]);
		compare_confirm(2, o_Confirm_Result2, Expected_Confirm_Vector_Seg1[1]);
		compare_confirm(3, o_Confirm_Result3, Expected_Confirm_Vector_Seg1[2]);
		compare_confirm(4, o_Confirm_Result4, Expected_Confirm_Vector_Seg1[3]);
		compare_confirm(5, o_Confirm_Result5, Expected_Confirm_Vector_Seg1[4]);
		compare_confirm(6, o_Confirm_Result6, Expected_Confirm_Vector_Seg1[5]);
		compare_confirm(7, o_Confirm_Result7, Expected_Confirm_Vector_Seg1[6]);
		compare_confirm(8, o_Confirm_Result8, Expected_Confirm_Vector_Seg1[7]);
		compare_confirm(9, o_Confirm_Result9, Expected_Confirm_Vector_Seg1[8]);
		compare_confirm(10, o_Confirm_Result10, Expected_Confirm_Vector_Seg1[9]);
		compare_confirm(11, o_Confirm_Result11, Expected_Confirm_Vector_Seg1[10]);
		compare_confirm(12, o_Confirm_Result12, Expected_Confirm_Vector_Seg1[11]);
		compare_confirm(13, o_Confirm_Result13, Expected_Confirm_Vector_Seg1[12]);

		// -- Mask 8
		search_confirm (
			Input_Key[7],
			
			Mask_Vector_Seg8[0],
			Mask_Vector_Seg8[1],
			Mask_Vector_Seg8[2],
			Mask_Vector_Seg8[3],
			Mask_Vector_Seg8[4],
			Mask_Vector_Seg8[5],
			Mask_Vector_Seg8[6],
			Mask_Vector_Seg8[7],
			Mask_Vector_Seg8[8],
			Mask_Vector_Seg8[9],			
			Mask_Vector_Seg8[10],			
			Mask_Vector_Seg8[11],			
			Mask_Vector_Seg8[12]			
		);
		
		@(negedge clk);
		
		$display("--------------------------------------- 13 CONFIRMs of Mask Vector Seg 2 ---------------------------------------");		
		compare_confirm(1, o_Confirm_Result1, Expected_Confirm_Vector_Seg2[0]);
		compare_confirm(2, o_Confirm_Result2, Expected_Confirm_Vector_Seg2[1]);
		compare_confirm(3, o_Confirm_Result3, Expected_Confirm_Vector_Seg2[2]);
		compare_confirm(4, o_Confirm_Result4, Expected_Confirm_Vector_Seg2[3]);
		compare_confirm(5, o_Confirm_Result5, Expected_Confirm_Vector_Seg2[4]);
		compare_confirm(6, o_Confirm_Result6, Expected_Confirm_Vector_Seg2[5]);
		compare_confirm(7, o_Confirm_Result7, Expected_Confirm_Vector_Seg2[6]);
		compare_confirm(8, o_Confirm_Result8, Expected_Confirm_Vector_Seg2[7]);
		compare_confirm(9, o_Confirm_Result9, Expected_Confirm_Vector_Seg2[8]);
		compare_confirm(10, o_Confirm_Result10, Expected_Confirm_Vector_Seg2[9]);
		compare_confirm(11, o_Confirm_Result11, Expected_Confirm_Vector_Seg2[10]);
		compare_confirm(12, o_Confirm_Result12, Expected_Confirm_Vector_Seg2[11]);
		compare_confirm(13, o_Confirm_Result13, Expected_Confirm_Vector_Seg2[12]);
		
		// -- Mask 9
		search_confirm (
			Input_Key[8],
			
			Mask_Vector_Seg9[0],
			Mask_Vector_Seg9[1],
			Mask_Vector_Seg9[2],
			Mask_Vector_Seg9[3],
			Mask_Vector_Seg9[4],
			Mask_Vector_Seg9[5],
			Mask_Vector_Seg9[6],
			Mask_Vector_Seg9[7],
			Mask_Vector_Seg9[8],
			Mask_Vector_Seg9[9],			
			Mask_Vector_Seg9[10],			
			Mask_Vector_Seg9[11],			
			Mask_Vector_Seg9[12]			
		);
		
		@(negedge clk);
		
		$display("--------------------------------------- 13 CONFIRMs of Mask Vector Seg 3 ---------------------------------------");	
		compare_confirm(1, o_Confirm_Result1, Expected_Confirm_Vector_Seg3[0]);
		compare_confirm(2, o_Confirm_Result2, Expected_Confirm_Vector_Seg3[1]);
		compare_confirm(3, o_Confirm_Result3, Expected_Confirm_Vector_Seg3[2]);
		compare_confirm(4, o_Confirm_Result4, Expected_Confirm_Vector_Seg3[3]);
		compare_confirm(5, o_Confirm_Result5, Expected_Confirm_Vector_Seg3[4]);
		compare_confirm(6, o_Confirm_Result6, Expected_Confirm_Vector_Seg3[5]);
		compare_confirm(7, o_Confirm_Result7, Expected_Confirm_Vector_Seg3[6]);
		compare_confirm(8, o_Confirm_Result8, Expected_Confirm_Vector_Seg3[7]);
		compare_confirm(9, o_Confirm_Result9, Expected_Confirm_Vector_Seg3[8]);
		compare_confirm(10, o_Confirm_Result10, Expected_Confirm_Vector_Seg3[9]);
		compare_confirm(11, o_Confirm_Result11, Expected_Confirm_Vector_Seg3[10]);
		compare_confirm(12, o_Confirm_Result12, Expected_Confirm_Vector_Seg3[11]);
		compare_confirm(13, o_Confirm_Result13, Expected_Confirm_Vector_Seg3[12]);
		
		// -- Mask 10
		search_confirm (
			Input_Key[9],
			
			Mask_Vector_Seg10[0],
			Mask_Vector_Seg10[1],
			Mask_Vector_Seg10[2],
			Mask_Vector_Seg10[3],
			Mask_Vector_Seg10[4],
			Mask_Vector_Seg10[5],
			Mask_Vector_Seg10[6],
			Mask_Vector_Seg10[7],
			Mask_Vector_Seg10[8],
			Mask_Vector_Seg10[9],			
			Mask_Vector_Seg10[10],			
			Mask_Vector_Seg10[11],			
			Mask_Vector_Seg10[12]			
		);
		
		@(negedge clk);

		$display("--------------------------------------- 13 CONFIRMs of Mask Vector Seg 4 ---------------------------------------");
		compare_confirm(1, o_Confirm_Result1, Expected_Confirm_Vector_Seg4[0]);
		compare_confirm(2, o_Confirm_Result2, Expected_Confirm_Vector_Seg4[1]);
		compare_confirm(3, o_Confirm_Result3, Expected_Confirm_Vector_Seg4[2]);
		compare_confirm(4, o_Confirm_Result4, Expected_Confirm_Vector_Seg4[3]);
		compare_confirm(5, o_Confirm_Result5, Expected_Confirm_Vector_Seg4[4]);
		compare_confirm(6, o_Confirm_Result6, Expected_Confirm_Vector_Seg4[5]);
		compare_confirm(7, o_Confirm_Result7, Expected_Confirm_Vector_Seg4[6]);
		compare_confirm(8, o_Confirm_Result8, Expected_Confirm_Vector_Seg4[7]);
		compare_confirm(9, o_Confirm_Result9, Expected_Confirm_Vector_Seg4[8]);
		compare_confirm(10, o_Confirm_Result10, Expected_Confirm_Vector_Seg4[9]);
		compare_confirm(11, o_Confirm_Result11, Expected_Confirm_Vector_Seg4[10]);
		compare_confirm(12, o_Confirm_Result12, Expected_Confirm_Vector_Seg4[11]);
		compare_confirm(13, o_Confirm_Result13, Expected_Confirm_Vector_Seg4[12]);
		
		@(negedge clk);
		
		$display("--------------------------------------- 13 CONFIRMs of Mask Vector Seg 5 ---------------------------------------");
		compare_confirm(1, o_Confirm_Result1, Expected_Confirm_Vector_Seg5[0]);
		compare_confirm(2, o_Confirm_Result2, Expected_Confirm_Vector_Seg5[1]);
		compare_confirm(3, o_Confirm_Result3, Expected_Confirm_Vector_Seg5[2]);
		compare_confirm(4, o_Confirm_Result4, Expected_Confirm_Vector_Seg5[3]);
		compare_confirm(5, o_Confirm_Result5, Expected_Confirm_Vector_Seg5[4]);
		compare_confirm(6, o_Confirm_Result6, Expected_Confirm_Vector_Seg5[5]);
		compare_confirm(7, o_Confirm_Result7, Expected_Confirm_Vector_Seg5[6]);
		compare_confirm(8, o_Confirm_Result8, Expected_Confirm_Vector_Seg5[7]);
		compare_confirm(9, o_Confirm_Result9, Expected_Confirm_Vector_Seg5[8]);
		compare_confirm(10, o_Confirm_Result10, Expected_Confirm_Vector_Seg5[9]);
		compare_confirm(11, o_Confirm_Result11, Expected_Confirm_Vector_Seg5[10]);
		compare_confirm(12, o_Confirm_Result12, Expected_Confirm_Vector_Seg5[11]);
		compare_confirm(13, o_Confirm_Result13, Expected_Confirm_Vector_Seg5[12]);
		
		@(negedge clk);
		$display("--------------------------------------- 13 CONFIRMs of Mask Vector Seg 6 ---------------------------------------");
		compare_confirm(1, o_Confirm_Result1, Expected_Confirm_Vector_Seg6[0]);
		compare_confirm(2, o_Confirm_Result2, Expected_Confirm_Vector_Seg6[1]);
		compare_confirm(3, o_Confirm_Result3, Expected_Confirm_Vector_Seg6[2]);
		compare_confirm(4, o_Confirm_Result4, Expected_Confirm_Vector_Seg6[3]);
		compare_confirm(5, o_Confirm_Result5, Expected_Confirm_Vector_Seg6[4]);
		compare_confirm(6, o_Confirm_Result6, Expected_Confirm_Vector_Seg6[5]);
		compare_confirm(7, o_Confirm_Result7, Expected_Confirm_Vector_Seg6[6]);
		compare_confirm(8, o_Confirm_Result8, Expected_Confirm_Vector_Seg6[7]);
		compare_confirm(9, o_Confirm_Result9, Expected_Confirm_Vector_Seg6[8]);
		compare_confirm(10, o_Confirm_Result10, Expected_Confirm_Vector_Seg6[9]);
		compare_confirm(11, o_Confirm_Result11, Expected_Confirm_Vector_Seg6[10]);
		compare_confirm(12, o_Confirm_Result12, Expected_Confirm_Vector_Seg6[11]);
		compare_confirm(13, o_Confirm_Result13, Expected_Confirm_Vector_Seg6[12]);
		
		@(negedge clk);
		$display("--------------------------------------- 13 CONFIRMs of Mask Vector Seg 7 ---------------------------------------");
		compare_confirm(1, o_Confirm_Result1, Expected_Confirm_Vector_Seg7[0]);
		compare_confirm(2, o_Confirm_Result2, Expected_Confirm_Vector_Seg7[1]);
		compare_confirm(3, o_Confirm_Result3, Expected_Confirm_Vector_Seg7[2]);
		compare_confirm(4, o_Confirm_Result4, Expected_Confirm_Vector_Seg7[3]);
		compare_confirm(5, o_Confirm_Result5, Expected_Confirm_Vector_Seg7[4]);
		compare_confirm(6, o_Confirm_Result6, Expected_Confirm_Vector_Seg7[5]);
		compare_confirm(7, o_Confirm_Result7, Expected_Confirm_Vector_Seg7[6]);
		compare_confirm(8, o_Confirm_Result8, Expected_Confirm_Vector_Seg7[7]);
		compare_confirm(9, o_Confirm_Result9, Expected_Confirm_Vector_Seg7[8]);
		compare_confirm(10, o_Confirm_Result10, Expected_Confirm_Vector_Seg7[9]);
		compare_confirm(11, o_Confirm_Result11, Expected_Confirm_Vector_Seg7[10]);
		compare_confirm(12, o_Confirm_Result12, Expected_Confirm_Vector_Seg7[11]);
		compare_confirm(13, o_Confirm_Result13, Expected_Confirm_Vector_Seg7[12]);
		
		@(negedge clk);
		$display("--------------------------------------- 13 CONFIRMs of Mask Vector Seg 8 ---------------------------------------");
		compare_confirm(1, o_Confirm_Result1, Expected_Confirm_Vector_Seg8[0]);
		compare_confirm(2, o_Confirm_Result2, Expected_Confirm_Vector_Seg8[1]);
		compare_confirm(3, o_Confirm_Result3, Expected_Confirm_Vector_Seg8[2]);
		compare_confirm(4, o_Confirm_Result4, Expected_Confirm_Vector_Seg8[3]);
		compare_confirm(5, o_Confirm_Result5, Expected_Confirm_Vector_Seg8[4]);
		compare_confirm(6, o_Confirm_Result6, Expected_Confirm_Vector_Seg8[5]);
		compare_confirm(7, o_Confirm_Result7, Expected_Confirm_Vector_Seg8[6]);
		compare_confirm(8, o_Confirm_Result8, Expected_Confirm_Vector_Seg8[7]);
		compare_confirm(9, o_Confirm_Result9, Expected_Confirm_Vector_Seg8[8]);
		compare_confirm(10, o_Confirm_Result10, Expected_Confirm_Vector_Seg8[9]);
		compare_confirm(11, o_Confirm_Result11, Expected_Confirm_Vector_Seg8[10]);
		compare_confirm(12, o_Confirm_Result12, Expected_Confirm_Vector_Seg8[11]);
		compare_confirm(13, o_Confirm_Result13, Expected_Confirm_Vector_Seg8[12]);
		
		@(negedge clk);
		$display("--------------------------------------- 13 CONFIRMs of Mask Vector Seg 9 ---------------------------------------");
		compare_confirm(1, o_Confirm_Result1, Expected_Confirm_Vector_Seg9[0]);
		compare_confirm(2, o_Confirm_Result2, Expected_Confirm_Vector_Seg9[1]);
		compare_confirm(3, o_Confirm_Result3, Expected_Confirm_Vector_Seg9[2]);
		compare_confirm(4, o_Confirm_Result4, Expected_Confirm_Vector_Seg9[3]);
		compare_confirm(5, o_Confirm_Result5, Expected_Confirm_Vector_Seg9[4]);
		compare_confirm(6, o_Confirm_Result6, Expected_Confirm_Vector_Seg9[5]);
		compare_confirm(7, o_Confirm_Result7, Expected_Confirm_Vector_Seg9[6]);
		compare_confirm(8, o_Confirm_Result8, Expected_Confirm_Vector_Seg9[7]);
		compare_confirm(9, o_Confirm_Result9, Expected_Confirm_Vector_Seg9[8]);
		compare_confirm(10, o_Confirm_Result10, Expected_Confirm_Vector_Seg9[9]);
		compare_confirm(11, o_Confirm_Result11, Expected_Confirm_Vector_Seg9[10]);
		compare_confirm(12, o_Confirm_Result12, Expected_Confirm_Vector_Seg9[11]);
		compare_confirm(13, o_Confirm_Result13, Expected_Confirm_Vector_Seg9[12]);
		
		@(negedge clk);
		$display("--------------------------------------- 13 CONFIRMs of Mask Vector Seg 10 ---------------------------------------");
		compare_confirm(1, o_Confirm_Result1, Expected_Confirm_Vector_Seg10[0]);
		compare_confirm(2, o_Confirm_Result2, Expected_Confirm_Vector_Seg10[1]);
		compare_confirm(3, o_Confirm_Result3, Expected_Confirm_Vector_Seg10[2]);
		compare_confirm(4, o_Confirm_Result4, Expected_Confirm_Vector_Seg10[3]);
		compare_confirm(5, o_Confirm_Result5, Expected_Confirm_Vector_Seg10[4]);
		compare_confirm(6, o_Confirm_Result6, Expected_Confirm_Vector_Seg10[5]);
		compare_confirm(7, o_Confirm_Result7, Expected_Confirm_Vector_Seg10[6]);
		compare_confirm(8, o_Confirm_Result8, Expected_Confirm_Vector_Seg10[7]);
		compare_confirm(9, o_Confirm_Result9, Expected_Confirm_Vector_Seg10[8]);
		compare_confirm(10, o_Confirm_Result10, Expected_Confirm_Vector_Seg10[9]);
		compare_confirm(11, o_Confirm_Result11, Expected_Confirm_Vector_Seg10[10]);
		compare_confirm(12, o_Confirm_Result12, Expected_Confirm_Vector_Seg10[11]);
		compare_confirm(13, o_Confirm_Result13, Expected_Confirm_Vector_Seg10[12]);
		
		@(negedge clk);
		$finish;
	end
	
// ==========================================================================
// == Tasks & Functions
// ==========================================================================
	task set_confirm;
		input [TOTALWID-1:0] str;
		input [IDWID-1:0] rule;
		begin
			repeat (2) @(negedge clk) 
			begin 
				i_Set_Confirm_Enable = 1'b1;
				i_Set_Confirm_String = str;
				i_Set_Confirm_ID = rule;
			end 
	
			@(negedge clk);
			
			i_Set_Confirm_Enable = 1'b0;
		end 
	endtask
	
	task search_confirm;
		input [KWID-1:0] key; 
		
		input [VTWID-1:0] mask1;
		input [VTWID-1:0] mask2;
		input [VTWID-1:0] mask3;
		input [VTWID-1:0] mask4;
		input [VTWID-1:0] mask5;
		input [VTWID-1:0] mask6;
		input [VTWID-1:0] mask7;
		input [VTWID-1:0] mask8;
		input [VTWID-1:0] mask9;
		input [VTWID-1:0] mask10;
		input [VTWID-1:0] mask11;
		input [VTWID-1:0] mask12;
		input [VTWID-1:0] mask13;

		begin
			i_Set_Confirm_Enable = 0;
			
			i_Key = key;
			
			i_Mask_Vector1 = mask1;
			i_Mask_Vector2 = mask2;
			i_Mask_Vector3 = mask3;
			i_Mask_Vector4 = mask4;
			i_Mask_Vector5 = mask5;
			i_Mask_Vector6 = mask6;
			i_Mask_Vector7 = mask7;
			i_Mask_Vector8 = mask8;
			i_Mask_Vector9 = mask9;
			i_Mask_Vector10 = mask10;
			i_Mask_Vector11 = mask11;
			i_Mask_Vector12 = mask12;
			i_Mask_Vector13 = mask13;
		end 
	endtask
	
	task compare_confirm;
		input [3:0]		  i;
		input [CFWID-1:0] confirm;
		input [CFWID-1:0] expected;
		begin
			if (confirm == expected)	$display("%t : Correct Confirm %d", $time, i);
			else 						$display("%t : generated 0x%04x - expected 0x%04x", $time, confirm, expected); 
		end 
	endtask
endmodule 
