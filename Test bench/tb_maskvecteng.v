module tb_maskvecteng(); 
// =============================================================================
// == Parameter declarations
// =============================================================================
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

// ==========================================================================
// == Port Declarations
// ==========================================================================
	reg	clk;
	reg	rst;
	
	reg	 [VTWID-1:0] i_Segment_Vector;
	
	wire [VTWID-1:0] o_Mask_Vector1;
	wire [VTWID-1:0] o_Mask_Vector2;
	wire [VTWID-1:0] o_Mask_Vector3;
	wire [VTWID-1:0] o_Mask_Vector4;
	wire [VTWID-1:0] o_Mask_Vector5;
	wire [VTWID-1:0] o_Mask_Vector6;
	wire [VTWID-1:0] o_Mask_Vector7;
	wire [VTWID-1:0] o_Mask_Vector8;
	wire [VTWID-1:0] o_Mask_Vector9;
	wire [VTWID-1:0] o_Mask_Vector10;
	wire [VTWID-1:0] o_Mask_Vector11;
	wire [VTWID-1:0] o_Mask_Vector12;
	wire [VTWID-1:0] o_Mask_Vector13;
	
	
	reg	[IDWID-1:0]	 i_Set_Mask_ID;
	reg	[MASKWID-1:0] i_Set_Mask_Vector;
	reg				 i_Set_Enable;

// ==========================================================================
// == Component Instatiation : Device Under Test (DUT)
// ==========================================================================
// == RAM 256x13 bits ;
	maskvecteng 	Mask_Engine_Inst 
		(
			.clk(clk),
			.rst(rst),
			
			// for searching purpose	
			.i_Segment_Vector(i_Segment_Vector),
			
			.o_Mask_Vector1(o_Mask_Vector1),
			.o_Mask_Vector2(o_Mask_Vector2),
			.o_Mask_Vector3(o_Mask_Vector3),
			.o_Mask_Vector4(o_Mask_Vector4),
			.o_Mask_Vector5(o_Mask_Vector5),
			.o_Mask_Vector6(o_Mask_Vector6),
			.o_Mask_Vector7(o_Mask_Vector7),
			.o_Mask_Vector8(o_Mask_Vector8),
			.o_Mask_Vector9(o_Mask_Vector9),
			.o_Mask_Vector10(o_Mask_Vector10),
			.o_Mask_Vector11(o_Mask_Vector11),
			.o_Mask_Vector12(o_Mask_Vector12),
			.o_Mask_Vector13(o_Mask_Vector13),
			
			// for setting purpose
			.i_Set_Mask_ID(i_Set_Mask_ID),
			.i_Set_Mask_Vector(i_Set_Mask_Vector),
			.i_Set_Enable(i_Set_Enable)
		);

// ==========================================================================
// == Signal Declarations
// ==========================================================================
	reg [MASKWID-1:0] Input_Mask_Data [9:0];
	reg [IDWID-1:0] Input_Rule_ID [9:0];
	
	reg [VTWID-1:0] Input_Segment_Vector [9:0];
	
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
	
	// -- Iteration Control
	integer i;
// ==========================================================================
// == Architecture of Test Bench
// ==========================================================================
	initial
	begin
		// -- Mask Data for Setting
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
		Input_Rule_ID[0] = 8'h00;	// rule R1
		Input_Rule_ID[1] = 8'h01;	// rule R2
		Input_Rule_ID[2] = 8'h02;	// rule R3
		Input_Rule_ID[3] = 8'h03;	// rule R4
		Input_Rule_ID[4] = 8'h04;	// rule R5
		Input_Rule_ID[5] = 8'h05;	// rule R6
		Input_Rule_ID[6] = 8'h06;	// rule R7
		Input_Rule_ID[7] = 8'h07;	// rule R8
		Input_Rule_ID[8] = 8'h08;	// rule R9
		Input_Rule_ID[9] = 8'h09;	// rule R10
		
		// -- Segment Vector
		Input_Segment_Vector[0] = {{2'b11,8'h00}, {2'b11,8'h00}, {2'b11,8'h00}, {2'b11,8'h00}, {2'b01,8'h00}, {2'b01,8'h00}, {2'b11,8'h00}, {2'b11,8'h00}, {5{2'b11,8'h00}}};
		Input_Segment_Vector[1] = {{2'b11,8'h00}, {2'b11,8'h00}, {2'b11,8'h01}, {2'b01,8'h01}, {2'b01,8'h01}, {2'b01,8'h01}, {2'b01,8'h01}, {2'b11,8'h00}, {5{2'b11,8'h00}}};
		Input_Segment_Vector[2] = {{2'b11,8'h00}, {2'b11,8'h00}, {2'b11,8'h01}, {2'b01,8'h02}, {2'b01,8'h02}, {2'b01,8'h02}, {2'b01,8'h02}, {2'b11,8'h00}, {5{2'b11,8'h00}}};
		Input_Segment_Vector[3] = {{2'b11,8'h03}, {2'b11,8'h03}, {2'b11,8'h03}, {2'b11,8'h00}, {2'b11,8'h03}, {2'b11,8'h03}, {2'b11,8'h00}, {2'b11,8'h00}, {5{2'b11,8'h00}}};
		Input_Segment_Vector[4] = {{2'b11,8'h03}, {2'b11,8'h03}, {2'b11,8'h03}, {2'b01,8'h04}, {2'b01,8'h04}, {2'b01,8'h04}, {2'b01,8'h04}, {2'b01,8'h04}, {5{2'b11,8'h00}}};
		Input_Segment_Vector[5] = {{2'b11,8'h05}, {2'b11,8'h05}, {2'b11,8'h05}, {2'b01,8'h05}, {2'b11,8'h05}, {2'b11,8'h03}, {2'b11,8'h00}, {2'b11,8'h00}, {5{2'b11,8'h00}}};
		Input_Segment_Vector[6] = {{2'b11,8'h05}, {2'b11,8'h05}, {2'b11,8'h05}, {2'b01,8'h06}, {2'b01,8'h06}, {2'b01,8'h06}, {2'b01,8'h06}, {2'b01,8'h06}, {5{2'b11,8'h00}}};
		Input_Segment_Vector[7] = {{2'b11,8'h00}, {2'b11,8'h00}, {2'b11,8'h00}, {2'b11,8'h00}, {2'b01,8'h07}, {2'b11,8'h03}, {2'b11,8'h00}, {2'b11,8'h00}, {5{2'b11,8'h00}}};
		Input_Segment_Vector[8] = {{2'b11,8'h03}, {2'b11,8'h03}, {2'b11,8'h03}, {2'b01,8'h08}, {2'b11,8'h03}, {2'b11,8'h03}, {2'b11,8'h00}, {2'b11,8'h00}, {5{2'b11,8'h00}}};
		Input_Segment_Vector[9] = {{2'b11,8'h03}, {2'b11,8'h03}, {2'b11,8'h03}, {2'b01,8'h09}, {2'b11,8'h05}, {2'b11,8'h03}, {2'b01,8'h09}, {2'b01,8'h09}, {5{2'b11,8'h00}}};
		
		// -- Expected Vectors
		// -- Expected Vector Seg 1
		Expected_Vector_Seg1[0]  = {13{2'b11, R1}};
		Expected_Vector_Seg1[1]  = {13{2'b11, R1}};
		Expected_Vector_Seg1[2]  = {13{2'b11, R1}};
		Expected_Vector_Seg1[3]  = {13{2'b11, R1}};
		Expected_Vector_Seg1[4]  = {13{2'b11, R1}};
		Expected_Vector_Seg1[5]  = {13{2'b11, R1}};
		Expected_Vector_Seg1[6]  = {13{2'b11, R1}};
		Expected_Vector_Seg1[7]  = {{4{2'b11, R1}}, {2{2'b01, R1}}, {7{2'b11, R1}}};
		Expected_Vector_Seg1[8]  = {{4{2'b11, R1}}, {2{2'b01, R1}}, {7{2'b11, R1}}};
		Expected_Vector_Seg1[9]  = {13{2'b11, R1}};
		Expected_Vector_Seg1[10] = {13{2'b11, R1}};
		Expected_Vector_Seg1[11] = {13{2'b11, R1}};
		Expected_Vector_Seg1[12] = {13{2'b11, R1}};
		
		// -- Expected Vector Seg 2
		Expected_Vector_Seg2[0]  = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		Expected_Vector_Seg2[1]  = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		Expected_Vector_Seg2[2]  = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		Expected_Vector_Seg2[3]  = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		Expected_Vector_Seg2[4]  = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		Expected_Vector_Seg2[5]  = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		Expected_Vector_Seg2[6]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b01, R2}}, {6{2'b11, R1}}};
		Expected_Vector_Seg2[7]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b01, R2}}, {6{2'b11, R1}}};
		Expected_Vector_Seg2[8]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b01, R2}}, {6{2'b11, R1}}};
		Expected_Vector_Seg2[9]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b01, R2}}, {6{2'b11, R1}}};
		Expected_Vector_Seg2[10] = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		Expected_Vector_Seg2[11] = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		Expected_Vector_Seg2[12] = {{2{2'b11, R1}}, {5{2'b11, R2}}, {6{2'b11, R1}}};
		
		// -- Expected Vector Seg 3
		Expected_Vector_Seg3[0]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		Expected_Vector_Seg3[1]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		Expected_Vector_Seg3[2]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		Expected_Vector_Seg3[3]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		Expected_Vector_Seg3[4]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		Expected_Vector_Seg3[5]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		Expected_Vector_Seg3[6]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b01, R3}}, {6{2'b11, R1}}};
		Expected_Vector_Seg3[7]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b01, R3}}, {6{2'b11, R1}}};
		Expected_Vector_Seg3[8]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b01, R3}}, {6{2'b11, R1}}};
		Expected_Vector_Seg3[9]  = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b01, R3}}, {6{2'b11, R1}}};
		Expected_Vector_Seg3[10] = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		Expected_Vector_Seg3[11] = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		Expected_Vector_Seg3[12] = {{2{2'b11, R1}}, {1{2'b11, R2}}, {4{2'b11, R3}}, {6{2'b11, R1}}};
		
		// -- Expected Vector Seg 4
		Expected_Vector_Seg4[0]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg4[1]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg4[2]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg4[3]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg4[4]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg4[5]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg4[6]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg4[7]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg4[8]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg4[9]  = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg4[10] = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg4[11] = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg4[12] = {{3{2'b11, R4}}, {1{2'b11, R1}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		
		// -- Expected Vector Seg 5
		Expected_Vector_Seg5[0]  = {{3{2'b11, R4}}, {5{2'b11, R5}}, {5{2'b11, R1}}};
		Expected_Vector_Seg5[1]  = {{3{2'b11, R4}}, {5{2'b11, R5}}, {5{2'b11, R1}}};
		Expected_Vector_Seg5[2]  = {{3{2'b11, R4}}, {5{2'b11, R5}}, {5{2'b11, R1}}};
		Expected_Vector_Seg5[3]  = {{3{2'b11, R4}}, {5{2'b11, R5}}, {5{2'b11, R1}}};
		Expected_Vector_Seg5[4]  = {{3{2'b11, R4}}, {5{2'b11, R5}}, {5{2'b11, R1}}};
		Expected_Vector_Seg5[5]  = {{3{2'b11, R4}}, {5{2'b01, R5}}, {5{2'b11, R1}}};
		Expected_Vector_Seg5[6]  = {{3{2'b11, R4}}, {5{2'b01, R5}}, {5{2'b11, R1}}};
		Expected_Vector_Seg5[7]  = {{3{2'b11, R4}}, {5{2'b01, R5}}, {5{2'b11, R1}}};
		Expected_Vector_Seg5[8]  = {{3{2'b11, R4}}, {5{2'b01, R5}}, {5{2'b11, R1}}};
		Expected_Vector_Seg5[9]  = {{3{2'b11, R4}}, {5{2'b01, R5}}, {5{2'b11, R1}}};
		Expected_Vector_Seg5[10] = {{3{2'b11, R4}}, {5{2'b11, R5}}, {5{2'b11, R1}}};
		Expected_Vector_Seg5[11] = {{3{2'b11, R4}}, {5{2'b11, R5}}, {5{2'b11, R1}}};
		Expected_Vector_Seg5[12] = {{3{2'b11, R4}}, {5{2'b11, R5}}, {5{2'b11, R1}}};
		
		// -- Expected Vector Seg 6
		Expected_Vector_Seg6[0]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg6[1]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg6[2]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg6[3]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg6[4]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg6[5]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg6[6]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg6[7]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg6[8]  = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg6[9]  = {{3{2'b11, R6}}, {1{2'b01, R6}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg6[10] = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg6[11] = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg6[12] = {{5{2'b11, R6}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		
		// -- Expected Vector Seg 7
		Expected_Vector_Seg7[0]  = {{3{2'b11, R6}}, {5{2'b11, R7}}, {5{2'b11, R1}}};
		Expected_Vector_Seg7[1]  = {{3{2'b11, R6}}, {5{2'b11, R7}}, {5{2'b11, R1}}};
		Expected_Vector_Seg7[2]  = {{3{2'b11, R6}}, {5{2'b11, R7}}, {5{2'b11, R1}}};
		Expected_Vector_Seg7[3]  = {{3{2'b11, R6}}, {5{2'b11, R7}}, {5{2'b11, R1}}};
		Expected_Vector_Seg7[4]  = {{3{2'b11, R6}}, {5{2'b11, R7}}, {5{2'b11, R1}}};
		Expected_Vector_Seg7[5]  = {{3{2'b11, R6}}, {5{2'b01, R7}}, {5{2'b11, R1}}};
		Expected_Vector_Seg7[6]  = {{3{2'b11, R6}}, {5{2'b01, R7}}, {5{2'b11, R1}}};
		Expected_Vector_Seg7[7]  = {{3{2'b11, R6}}, {5{2'b01, R7}}, {5{2'b11, R1}}};
		Expected_Vector_Seg7[8]  = {{3{2'b11, R6}}, {5{2'b01, R7}}, {5{2'b11, R1}}};
		Expected_Vector_Seg7[9]  = {{3{2'b11, R6}}, {5{2'b01, R7}}, {5{2'b11, R1}}};
		Expected_Vector_Seg7[10] = {{3{2'b11, R6}}, {5{2'b11, R7}}, {5{2'b11, R1}}};
		Expected_Vector_Seg7[11] = {{3{2'b11, R6}}, {5{2'b11, R7}}, {5{2'b11, R1}}};
		Expected_Vector_Seg7[12] = {{3{2'b11, R6}}, {5{2'b11, R7}}, {5{2'b11, R1}}};
		
		// -- Expected Vector Seg 8
		Expected_Vector_Seg8[0]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg8[1]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg8[2]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg8[3]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg8[4]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg8[5]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg8[6]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg8[7]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg8[8]  = {{4{2'b11, R1}}, {1{2'b01, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg8[9]  = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg8[10] = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg8[11] = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg8[12] = {{4{2'b11, R1}}, {1{2'b11, R8}}, {1{2'b11, R4}}, {7{2'b11, R1}}};
		
		// -- Expected Vector Seg 9
		Expected_Vector_Seg9[0]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg9[1]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg9[2]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg9[3]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg9[4]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg9[5]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg9[6]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg9[7]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg9[8]  = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg9[9]  = {{3{2'b11, R4}}, {1{2'b01, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg9[10] = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg9[11] = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		Expected_Vector_Seg9[12] = {{3{2'b11, R4}}, {1{2'b11, R9}}, {2{2'b11, R4}}, {7{2'b11, R1}}};
		
		// -- Expected Vector Seg 10
		Expected_Vector_Seg10[0]  = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Expected_Vector_Seg10[1]  = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Expected_Vector_Seg10[2]  = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Expected_Vector_Seg10[3]  = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Expected_Vector_Seg10[4]  = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Expected_Vector_Seg10[5]  = {{3{2'b11, R4}}, {1{2'b01, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b01, R10}}, {5{2'b11, R1}}};
		Expected_Vector_Seg10[6]  = {{3{2'b11, R4}}, {1{2'b01, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b01, R10}}, {5{2'b11, R1}}};
		Expected_Vector_Seg10[7]  = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Expected_Vector_Seg10[8]  = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Expected_Vector_Seg10[9]  = {{3{2'b11, R4}}, {1{2'b01, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b01, R10}}, {5{2'b11, R1}}};
		Expected_Vector_Seg10[10] = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Expected_Vector_Seg10[11] = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
		Expected_Vector_Seg10[12] = {{3{2'b11, R4}}, {1{2'b11, R10}}, {1{2'b11, R6}}, {1{2'b11, R4}}, {2{2'b11, R10}}, {5{2'b11, R1}}};
	end                 
	
	always #10 clk = ~clk;
	
	initial 
	begin
		clk = 0;
		
		@(negedge clk);
		
		// -- power up reset and deactivate reset
		rst = 1;
		repeat (2) @(negedge clk);
		rst = 0;
		
		// -- Setting Mask
		for (i = 0; i < N; i = i + 1)
			set_mask(Input_Mask_Data[i], Input_Rule_ID[i]);
		
		// -- Searching Mask Phase
		@(negedge clk);
		$display("--------------------------------------- 13 MASKs of Segment Vector 1 ---------------------------------------");
		search_mask(Input_Segment_Vector[0]);
		compare_mask(1, o_Mask_Vector1, Expected_Vector_Seg1[0]);
		compare_mask(2, o_Mask_Vector2, Expected_Vector_Seg1[1]);
		compare_mask(3, o_Mask_Vector3, Expected_Vector_Seg1[2]);
		compare_mask(4, o_Mask_Vector4, Expected_Vector_Seg1[3]);
		compare_mask(5, o_Mask_Vector5, Expected_Vector_Seg1[4]);
		compare_mask(6, o_Mask_Vector6, Expected_Vector_Seg1[5]);
		compare_mask(7, o_Mask_Vector7, Expected_Vector_Seg1[6]);
		compare_mask(8, o_Mask_Vector8, Expected_Vector_Seg1[7]);
		compare_mask(9, o_Mask_Vector9, Expected_Vector_Seg1[8]);
		compare_mask(10, o_Mask_Vector10, Expected_Vector_Seg1[9]);
		compare_mask(11, o_Mask_Vector11, Expected_Vector_Seg1[10]);
		compare_mask(12, o_Mask_Vector12, Expected_Vector_Seg1[11]);
		compare_mask(13, o_Mask_Vector13, Expected_Vector_Seg1[12]);
		
		@(negedge clk)
		search_mask(Input_Segment_Vector[1]);
		$display("--------------------------------------- 13 MASKs of Segment Vector 2 ---------------------------------------");
		compare_mask(1, o_Mask_Vector1, Expected_Vector_Seg2[0]);
		compare_mask(2, o_Mask_Vector2, Expected_Vector_Seg2[1]);
		compare_mask(3, o_Mask_Vector3, Expected_Vector_Seg2[2]);
		compare_mask(4, o_Mask_Vector4, Expected_Vector_Seg2[3]);
		compare_mask(5, o_Mask_Vector5, Expected_Vector_Seg2[4]);
		compare_mask(6, o_Mask_Vector6, Expected_Vector_Seg2[5]);
		compare_mask(7, o_Mask_Vector7, Expected_Vector_Seg2[6]);
		compare_mask(8, o_Mask_Vector8, Expected_Vector_Seg2[7]);
		compare_mask(9, o_Mask_Vector9, Expected_Vector_Seg2[8]);
		compare_mask(10, o_Mask_Vector10, Expected_Vector_Seg2[9]);
		compare_mask(11, o_Mask_Vector11, Expected_Vector_Seg2[10]);
		compare_mask(12, o_Mask_Vector12, Expected_Vector_Seg2[11]);
		compare_mask(13, o_Mask_Vector13, Expected_Vector_Seg2[12]);
		
		@(negedge clk)
		search_mask(Input_Segment_Vector[2]);
		$display("--------------------------------------- 13 MASKs of Segment Vector 3 ---------------------------------------");
		compare_mask(1, o_Mask_Vector1, Expected_Vector_Seg3[0]);
		compare_mask(2, o_Mask_Vector2, Expected_Vector_Seg3[1]);
		compare_mask(3, o_Mask_Vector3, Expected_Vector_Seg3[2]);
		compare_mask(4, o_Mask_Vector4, Expected_Vector_Seg3[3]);
		compare_mask(5, o_Mask_Vector5, Expected_Vector_Seg3[4]);
		compare_mask(6, o_Mask_Vector6, Expected_Vector_Seg3[5]);
		compare_mask(7, o_Mask_Vector7, Expected_Vector_Seg3[6]);
		compare_mask(8, o_Mask_Vector8, Expected_Vector_Seg3[7]);
		compare_mask(9, o_Mask_Vector9, Expected_Vector_Seg3[8]);
		compare_mask(10, o_Mask_Vector10, Expected_Vector_Seg3[9]);
		compare_mask(11, o_Mask_Vector11, Expected_Vector_Seg3[10]);
		compare_mask(12, o_Mask_Vector12, Expected_Vector_Seg3[11]);
		compare_mask(13, o_Mask_Vector13, Expected_Vector_Seg3[12]);
		
		@(negedge clk)
		$display("--------------------------------------- 13 MASKs of Segment Vector 4 ---------------------------------------");
		search_mask(Input_Segment_Vector[3]);
		compare_mask(1, o_Mask_Vector1, Expected_Vector_Seg4[0]);
		compare_mask(2, o_Mask_Vector2, Expected_Vector_Seg4[1]);
		compare_mask(3, o_Mask_Vector3, Expected_Vector_Seg4[2]);
		compare_mask(4, o_Mask_Vector4, Expected_Vector_Seg4[3]);
		compare_mask(5, o_Mask_Vector5, Expected_Vector_Seg4[4]);
		compare_mask(6, o_Mask_Vector6, Expected_Vector_Seg4[5]);
		compare_mask(7, o_Mask_Vector7, Expected_Vector_Seg4[6]);
		compare_mask(8, o_Mask_Vector8, Expected_Vector_Seg4[7]);
		compare_mask(9, o_Mask_Vector9, Expected_Vector_Seg4[8]);
		compare_mask(10, o_Mask_Vector10, Expected_Vector_Seg4[9]);
		compare_mask(11, o_Mask_Vector11, Expected_Vector_Seg4[10]);
		compare_mask(12, o_Mask_Vector12, Expected_Vector_Seg4[11]);
		compare_mask(13, o_Mask_Vector13, Expected_Vector_Seg4[12]);
		
		@(negedge clk)
		$display("--------------------------------------- 13 MASKs of Segment Vector 5 ---------------------------------------");
		search_mask(Input_Segment_Vector[4]);
		compare_mask(1, o_Mask_Vector1, Expected_Vector_Seg5[0]);
		compare_mask(2, o_Mask_Vector2, Expected_Vector_Seg5[1]);
		compare_mask(3, o_Mask_Vector3, Expected_Vector_Seg5[2]);
		compare_mask(4, o_Mask_Vector4, Expected_Vector_Seg5[3]);
		compare_mask(5, o_Mask_Vector5, Expected_Vector_Seg5[4]);
		compare_mask(6, o_Mask_Vector6, Expected_Vector_Seg5[5]);
		compare_mask(7, o_Mask_Vector7, Expected_Vector_Seg5[6]);
		compare_mask(8, o_Mask_Vector8, Expected_Vector_Seg5[7]);
		compare_mask(9, o_Mask_Vector9, Expected_Vector_Seg5[8]);
		compare_mask(10, o_Mask_Vector10, Expected_Vector_Seg5[9]);
		compare_mask(11, o_Mask_Vector11, Expected_Vector_Seg5[10]);
		compare_mask(12, o_Mask_Vector12, Expected_Vector_Seg5[11]);
		compare_mask(13, o_Mask_Vector13, Expected_Vector_Seg5[12]);
		
		@(negedge clk)
		$display("--------------------------------------- 13 MASKs of Segment Vector 6 ---------------------------------------");
		search_mask(Input_Segment_Vector[5]);
		compare_mask(1, o_Mask_Vector1, Expected_Vector_Seg6[0]);
		compare_mask(2, o_Mask_Vector2, Expected_Vector_Seg6[1]);
		compare_mask(3, o_Mask_Vector3, Expected_Vector_Seg6[2]);
		compare_mask(4, o_Mask_Vector4, Expected_Vector_Seg6[3]);
		compare_mask(5, o_Mask_Vector5, Expected_Vector_Seg6[4]);
		compare_mask(6, o_Mask_Vector6, Expected_Vector_Seg6[5]);
		compare_mask(7, o_Mask_Vector7, Expected_Vector_Seg6[6]);
		compare_mask(8, o_Mask_Vector8, Expected_Vector_Seg6[7]);
		compare_mask(9, o_Mask_Vector9, Expected_Vector_Seg6[8]);
		compare_mask(10, o_Mask_Vector10, Expected_Vector_Seg6[9]);
		compare_mask(11, o_Mask_Vector11, Expected_Vector_Seg6[10]);
		compare_mask(12, o_Mask_Vector12, Expected_Vector_Seg6[11]);
		compare_mask(13, o_Mask_Vector13, Expected_Vector_Seg6[12]);
		
		@(negedge clk)
		$display("--------------------------------------- 13 MASKs of Segment Vector 7 ---------------------------------------");
		search_mask(Input_Segment_Vector[6]);
		compare_mask(1, o_Mask_Vector1, Expected_Vector_Seg7[0]);
		compare_mask(2, o_Mask_Vector2, Expected_Vector_Seg7[1]);
		compare_mask(3, o_Mask_Vector3, Expected_Vector_Seg7[2]);
		compare_mask(4, o_Mask_Vector4, Expected_Vector_Seg7[3]);
		compare_mask(5, o_Mask_Vector5, Expected_Vector_Seg7[4]);
		compare_mask(6, o_Mask_Vector6, Expected_Vector_Seg7[5]);
		compare_mask(7, o_Mask_Vector7, Expected_Vector_Seg7[6]);
		compare_mask(8, o_Mask_Vector8, Expected_Vector_Seg7[7]);
		compare_mask(9, o_Mask_Vector9, Expected_Vector_Seg7[8]);
		compare_mask(10, o_Mask_Vector10, Expected_Vector_Seg7[9]);
		compare_mask(11, o_Mask_Vector11, Expected_Vector_Seg7[10]);
		compare_mask(12, o_Mask_Vector12, Expected_Vector_Seg7[11]);
		compare_mask(13, o_Mask_Vector13, Expected_Vector_Seg7[12]);
		
		@(negedge clk)
		$display("--------------------------------------- 13 MASKs of Segment Vector 8 ---------------------------------------");
		search_mask(Input_Segment_Vector[7]);
		compare_mask(1, o_Mask_Vector1, Expected_Vector_Seg8[0]);
		compare_mask(2, o_Mask_Vector2, Expected_Vector_Seg8[1]);
		compare_mask(3, o_Mask_Vector3, Expected_Vector_Seg8[2]);
		compare_mask(4, o_Mask_Vector4, Expected_Vector_Seg8[3]);
		compare_mask(5, o_Mask_Vector5, Expected_Vector_Seg8[4]);
		compare_mask(6, o_Mask_Vector6, Expected_Vector_Seg8[5]);
		compare_mask(7, o_Mask_Vector7, Expected_Vector_Seg8[6]);
		compare_mask(8, o_Mask_Vector8, Expected_Vector_Seg8[7]);
		compare_mask(9, o_Mask_Vector9, Expected_Vector_Seg8[8]);
		compare_mask(10, o_Mask_Vector10, Expected_Vector_Seg8[9]);
		compare_mask(11, o_Mask_Vector11, Expected_Vector_Seg8[10]);
		compare_mask(12, o_Mask_Vector12, Expected_Vector_Seg8[11]);
		compare_mask(13, o_Mask_Vector13, Expected_Vector_Seg8[12]);
		
		@(negedge clk)
		$display("--------------------------------------- 13 MASKs of Segment Vector 9 ---------------------------------------");
		search_mask(Input_Segment_Vector[8]);
		compare_mask(1, o_Mask_Vector1, Expected_Vector_Seg9[0]);
		compare_mask(2, o_Mask_Vector2, Expected_Vector_Seg9[1]);
		compare_mask(3, o_Mask_Vector3, Expected_Vector_Seg9[2]);
		compare_mask(4, o_Mask_Vector4, Expected_Vector_Seg9[3]);
		compare_mask(5, o_Mask_Vector5, Expected_Vector_Seg9[4]);
		compare_mask(6, o_Mask_Vector6, Expected_Vector_Seg9[5]);
		compare_mask(7, o_Mask_Vector7, Expected_Vector_Seg9[6]);
		compare_mask(8, o_Mask_Vector8, Expected_Vector_Seg9[7]);
		compare_mask(9, o_Mask_Vector9, Expected_Vector_Seg9[8]);
		compare_mask(10, o_Mask_Vector10, Expected_Vector_Seg9[9]);
		compare_mask(11, o_Mask_Vector11, Expected_Vector_Seg9[10]);
		compare_mask(12, o_Mask_Vector12, Expected_Vector_Seg9[11]);
		compare_mask(13, o_Mask_Vector13, Expected_Vector_Seg9[12]);
		
		@(negedge clk)
		$display("--------------------------------------- 13 MASKs of Segment Vector 10 ---------------------------------------");
		search_mask(Input_Segment_Vector[9]);
		compare_mask(1, o_Mask_Vector1, Expected_Vector_Seg10[0]);
		compare_mask(2, o_Mask_Vector2, Expected_Vector_Seg10[1]);
		compare_mask(3, o_Mask_Vector3, Expected_Vector_Seg10[2]);
		compare_mask(4, o_Mask_Vector4, Expected_Vector_Seg10[3]);
		compare_mask(5, o_Mask_Vector5, Expected_Vector_Seg10[4]);
		compare_mask(6, o_Mask_Vector6, Expected_Vector_Seg10[5]);
		compare_mask(7, o_Mask_Vector7, Expected_Vector_Seg10[6]);
		compare_mask(8, o_Mask_Vector8, Expected_Vector_Seg10[7]);
		compare_mask(9, o_Mask_Vector9, Expected_Vector_Seg10[8]);
		compare_mask(10, o_Mask_Vector10, Expected_Vector_Seg10[9]);
		compare_mask(11, o_Mask_Vector11, Expected_Vector_Seg10[10]);
		compare_mask(12, o_Mask_Vector12, Expected_Vector_Seg10[11]);
		compare_mask(13, o_Mask_Vector13, Expected_Vector_Seg10[12]);
	
	end
// ==========================================================================
// == Tasks & Functions
// ==========================================================================
	task set_mask;
		input [MASKWID-1:0] mask_data;
		input [IDWID-1:0] rule;
		begin
			repeat (2) @(negedge clk) 
			begin 
				i_Set_Enable = 1'b1;
				i_Set_Mask_ID = rule;
				i_Set_Mask_Vector = mask_data;
			end 
	
			@(negedge clk);
			
			i_Set_Enable = 1'b0;
		end 
	endtask
	
	task search_mask;
		input [VTWID-1:0] segment_vector;
		begin
			i_Set_Enable = 0;
			i_Segment_Vector = segment_vector;
			
			@(negedge clk);
		end 
	endtask
	
	task compare_mask;
		input [3:0]		  i;
		input [VTWID-1:0] mask;
		input [VTWID-1:0] expected;
		begin
			if (mask == expected)	$display("%t : Correct Mask %d", $time, i);
			else 					$display("%t : generated 0x%04x - expected 0x%04x", $time, mask, expected); 
		end 
	endtask
endmodule // tb_maskvecteng










