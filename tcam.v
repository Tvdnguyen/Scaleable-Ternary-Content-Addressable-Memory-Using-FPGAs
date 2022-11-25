// ============================================================================
// -- Update (24 May): Setting is set through Set_String and Set_ID
// -- Update (26 May): Searching ID of Key Input now become continuously
// -- Update (27 May): Resource reduces 13 M10K
// --
// --
// --
// --
// ============================================================================

module tcam
	(
		clk,
		rst,
		
		// for Searching purpose
		// == Input and Output
		i_Key,
		o_RuleID,
		o_Valid,
		o_Set_Done,
		
		// for setting purpose
		i_Set_ID,
		i_Set_String,
		i_Set_Enable
	);
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

// =============================================================================
// == Port Declarations
// =============================================================================
	input clk;
	input rst;
	
	// for searching 
	input [KWID-1:0] 	i_Key;
	output [IDWID-1:0] 	o_RuleID;
	output 				o_Valid;	
	
	// == New Setting 
	output 					o_Set_Done;
	input [IDWID-1:0]		i_Set_ID;
	input [TOTALWID-1:0]	i_Set_String;
	input 					i_Set_Enable;

// =============================================================================
// == Signal Declarations
// =============================================================================
	// == Pipeline Input
	// == Pipeline Key Input: 
	wire [KWID-1:0] Key8;	
	ffxkclkx #(8, KWID) pp_Key (clk,rst,i_Key,Key8);	// delay 8 clock cycles

	// =========================================================
	// == Component Instatiation : Segment Vector Engine 
	// =========================================================
	wire [VTWID-1:0] Segment_Vector;	// 2 clocks
	
	wire [MASKWID-1:0]	Mask_Data1;
	wire [MASKWID-1:0]	Mask_Data2;
	wire [MASKWID-1:0]	Mask_Data3;
	wire [MASKWID-1:0]	Mask_Data4;
	wire [MASKWID-1:0]	Mask_Data5;
	wire [MASKWID-1:0]	Mask_Data6;
	wire [MASKWID-1:0]	Mask_Data7;
	wire [MASKWID-1:0]	Mask_Data8;
	wire [MASKWID-1:0]	Mask_Data9;
	wire [MASKWID-1:0]	Mask_Data10;
	wire [MASKWID-1:0]	Mask_Data11;
	wire [MASKWID-1:0]	Mask_Data12;
	wire [MASKWID-1:0]	Mask_Data13;
	
	
	segvecteng 	Segment_Vector_Engine_Inst
		(
			.clk(clk),
			.rst(rst),
			
			// for searching 
			.i_Key(i_Key),		// input data
			.o_Segment_Vector(Segment_Vector),	// output 
			
			.o_Mask_Data1(Mask_Data1),
			.o_Mask_Data2(Mask_Data2),
			.o_Mask_Data3(Mask_Data3),
			.o_Mask_Data4(Mask_Data4),
			.o_Mask_Data5(Mask_Data5),
			.o_Mask_Data6(Mask_Data6),
			.o_Mask_Data7(Mask_Data7),
			.o_Mask_Data8(Mask_Data8),
			.o_Mask_Data9(Mask_Data9),
			.o_Mask_Data10(Mask_Data10),
			.o_Mask_Data11(Mask_Data11),
			.o_Mask_Data12(Mask_Data12),
			.o_Mask_Data13(Mask_Data13),
		
			// for setting
			.o_Set_Done(o_Set_Done),
			.i_Set_Data(i_Set_String[116:0]),
			.i_Set_ID(i_Set_ID),
			.i_Set_Segment_Enable(i_Set_Enable)
		);

	// =========================================================
	// == Component Instatiation : Mask Vector Engine 
	// =========================================================
	wire [VTWID-1:0]	Mask_Vector_n1;   // 1 clock
	wire [VTWID-1:0]	Mask_Vector_n2;   // 1 clock
	wire [VTWID-1:0]	Mask_Vector_n3;   // 1 clock
	wire [VTWID-1:0]	Mask_Vector_n4;   // 1 clock
	wire [VTWID-1:0]	Mask_Vector_n5;   // 1 clock
	wire [VTWID-1:0]	Mask_Vector_n6;   // 1 clock
	wire [VTWID-1:0]	Mask_Vector_n7;   // 1 clock
	wire [VTWID-1:0]	Mask_Vector_n8;   // 1 clock
	wire [VTWID-1:0]	Mask_Vector_n9;   // 1 clock
	wire [VTWID-1:0]	Mask_Vector_n10;   // 1 clock
	wire [VTWID-1:0]	Mask_Vector_n11;   // 1 clock
	wire [VTWID-1:0]	Mask_Vector_n12;   // 1 clock
	wire [VTWID-1:0]	Mask_Vector_n13;   // 1 clock
	
	maskvecteng 	Mask_Vector_Engine_Inst
		(
			.clk(clk),
			.rst(rst),
			
			// for searching purpose	
			.i_Segment_Vector(Segment_Vector),
			
			.i_Mask_Data1(Mask_Data1),
			.i_Mask_Data2(Mask_Data2),
			.i_Mask_Data3(Mask_Data3),
			.i_Mask_Data4(Mask_Data4),
			.i_Mask_Data5(Mask_Data5),
			.i_Mask_Data6(Mask_Data6),
			.i_Mask_Data7(Mask_Data7),
			.i_Mask_Data8(Mask_Data8),
			.i_Mask_Data9(Mask_Data9),
			.i_Mask_Data10(Mask_Data10),
			.i_Mask_Data11(Mask_Data11),
			.i_Mask_Data12(Mask_Data12),
			.i_Mask_Data13(Mask_Data13),
			
			.o_Mask_Vector1(Mask_Vector_n1),
			.o_Mask_Vector2(Mask_Vector_n2),
			.o_Mask_Vector3(Mask_Vector_n3),
			.o_Mask_Vector4(Mask_Vector_n4),
			.o_Mask_Vector5(Mask_Vector_n5),
			.o_Mask_Vector6(Mask_Vector_n6),
			.o_Mask_Vector7(Mask_Vector_n7),
			.o_Mask_Vector8(Mask_Vector_n8),
			.o_Mask_Vector9(Mask_Vector_n9),
			.o_Mask_Vector10(Mask_Vector_n10),
			.o_Mask_Vector11(Mask_Vector_n11),
			.o_Mask_Vector12(Mask_Vector_n12),
			.o_Mask_Vector13(Mask_Vector_n13)
		);
	// =========================================================
	// == Component Instatiation : Comparation Engine       
	// ========================================================= 
	
	wire [SEGWID-1:0]	Compare_Result_n1;   // 1 clock
	wire [SEGWID-1:0]	Compare_Result_n2;   // 1 clock
	wire [SEGWID-1:0]	Compare_Result_n3;   // 1 clock
	wire [SEGWID-1:0]	Compare_Result_n4;   // 1 clock
	wire [SEGWID-1:0]	Compare_Result_n5;   // 1 clock
	wire [SEGWID-1:0]	Compare_Result_n6;   // 1 clock
	wire [SEGWID-1:0]	Compare_Result_n7;   // 1 clock
	wire [SEGWID-1:0]	Compare_Result_n8;   // 1 clock
	wire [SEGWID-1:0]	Compare_Result_n9;   // 1 clock
	wire [SEGWID-1:0]	Compare_Result_n10;   // 1 clock
	wire [SEGWID-1:0]	Compare_Result_n11;   // 1 clock
	wire [SEGWID-1:0]	Compare_Result_n12;   // 1 clock
	wire [SEGWID-1:0]	Compare_Result_n13;   // 1 clock
	
	compareeng 		Compare_Engine_Inst
		(
			.clk				(clk), 
			.rst				(rst), 
			
			// for searching purpose
			.i_Mask_Vector1		(Mask_Vector_n1),
			.i_Mask_Vector2		(Mask_Vector_n2),
			.i_Mask_Vector3		(Mask_Vector_n3),
			.i_Mask_Vector4		(Mask_Vector_n4),
			.i_Mask_Vector5		(Mask_Vector_n5),
			.i_Mask_Vector6		(Mask_Vector_n6),
			.i_Mask_Vector7		(Mask_Vector_n7),
			.i_Mask_Vector8		(Mask_Vector_n8),
			.i_Mask_Vector9		(Mask_Vector_n9),
			.i_Mask_Vector10	(Mask_Vector_n10),
			.i_Mask_Vector11	(Mask_Vector_n11),
			.i_Mask_Vector12	(Mask_Vector_n12),
			.i_Mask_Vector13	(Mask_Vector_n13),
			
			.o_Compare_Result1	(Compare_Result_n1),
			.o_Compare_Result2	(Compare_Result_n2),
			.o_Compare_Result3	(Compare_Result_n3),
			.o_Compare_Result4	(Compare_Result_n4),
			.o_Compare_Result5	(Compare_Result_n5),
			.o_Compare_Result6	(Compare_Result_n6),
			.o_Compare_Result7	(Compare_Result_n7),
			.o_Compare_Result8	(Compare_Result_n8),
			.o_Compare_Result9	(Compare_Result_n9),
			.o_Compare_Result10	(Compare_Result_n10),
			.o_Compare_Result11	(Compare_Result_n11),
			.o_Compare_Result12	(Compare_Result_n12),
			.o_Compare_Result13	(Compare_Result_n13)
		);
		
		
	// =========================================================
	// == Component Instatiation : Confirmation Engine       
	// =========================================================
	wire [CFWID-1:0]	Confirm_Result_n1;  
	wire [CFWID-1:0]	Confirm_Result_n2;  
	wire [CFWID-1:0]	Confirm_Result_n3;  
	wire [CFWID-1:0]	Confirm_Result_n4;  
	wire [CFWID-1:0]	Confirm_Result_n5;  
	wire [CFWID-1:0]	Confirm_Result_n6;  
	wire [CFWID-1:0]	Confirm_Result_n7;  
	wire [CFWID-1:0]	Confirm_Result_n8;  
	wire [CFWID-1:0]	Confirm_Result_n9;  
	wire [CFWID-1:0]	Confirm_Result_n10; 
	wire [CFWID-1:0]	Confirm_Result_n11; 
	wire [CFWID-1:0]	Confirm_Result_n12; 
	wire [CFWID-1:0]	Confirm_Result_n13; 
	
	confirmeng		Confirmation_Engine_Inst
		(
			.clk				(clk),
			.rst				(rst),
			
			// for searching purpose
			.i_Key(Key8),	
			
			.i_Compare_Result1 	(Compare_Result_n1),
			.i_Compare_Result2 	(Compare_Result_n2),
			.i_Compare_Result3 	(Compare_Result_n3),
			.i_Compare_Result4 	(Compare_Result_n4),
			.i_Compare_Result5 	(Compare_Result_n5),
			.i_Compare_Result6 	(Compare_Result_n6),
			.i_Compare_Result7 	(Compare_Result_n7),
			.i_Compare_Result8 	(Compare_Result_n8),
			.i_Compare_Result9 	(Compare_Result_n9),
			.i_Compare_Result10	(Compare_Result_n10), 
			.i_Compare_Result11	(Compare_Result_n11), 
			.i_Compare_Result12	(Compare_Result_n12), 
			.i_Compare_Result13	(Compare_Result_n13), 
			
			.o_Confirm_Result1	(Confirm_Result_n1),   
			.o_Confirm_Result2	(Confirm_Result_n2), 
			.o_Confirm_Result3	(Confirm_Result_n3), 
			.o_Confirm_Result4	(Confirm_Result_n4), 
			.o_Confirm_Result5	(Confirm_Result_n5), 
			.o_Confirm_Result6	(Confirm_Result_n6), 
			.o_Confirm_Result7	(Confirm_Result_n7), 
			.o_Confirm_Result8	(Confirm_Result_n8), 
			.o_Confirm_Result9	(Confirm_Result_n9), 
			.o_Confirm_Result10	(Confirm_Result_n10), 
			.o_Confirm_Result11	(Confirm_Result_n11), 
			.o_Confirm_Result12	(Confirm_Result_n12), 
			.o_Confirm_Result13	(Confirm_Result_n13), 
			
			// for setting purpose
			.i_Set_Confirm_ID(i_Set_ID),
			.i_Set_Confirm_String(i_Set_String),
			.i_Set_Confirm_Enable(i_Set_Enable)
		);

	// =========================================================
	// == Component Instatiation : Priority Compare Engine     
	// =========================================================
	priocmpeng	Priority_Compare_Engine_Inst
		(
			.clk(clk),
			.rst(rst),
		
			.i_Confirm_Result1(Confirm_Result_n1),   
			.i_Confirm_Result2(Confirm_Result_n2), 
			.i_Confirm_Result3(Confirm_Result_n3), 
			.i_Confirm_Result4(Confirm_Result_n4), 
			.i_Confirm_Result5(Confirm_Result_n5), 
			.i_Confirm_Result6(Confirm_Result_n6), 
			.i_Confirm_Result7(Confirm_Result_n7), 
			.i_Confirm_Result8(Confirm_Result_n8), 
			.i_Confirm_Result9(Confirm_Result_n9), 
			.i_Confirm_Result10(Confirm_Result_n10), 
			.i_Confirm_Result11(Confirm_Result_n11), 
			.i_Confirm_Result12(Confirm_Result_n12), 
			.i_Confirm_Result13(Confirm_Result_n13),
			
			.o_ruleid(o_RuleID),
			.o_valid(o_Valid)
		);	
	
endmodule 














































//		// for Simulation 
//		o_Segment_Vector,
//		
//		o_Mask_Vector1,
//		o_Mask_Vector2,
//		o_Mask_Vector3,
//		o_Mask_Vector4,
//		o_Mask_Vector5,
//		o_Mask_Vector6,
//		o_Mask_Vector7,
//		o_Mask_Vector8,
//		o_Mask_Vector9,
//		o_Mask_Vector10,
//		o_Mask_Vector11,
//		o_Mask_Vector12,
//		o_Mask_Vector13,
//		
//		o_Confirm_Result1,
//		o_Confirm_Result2,
//		o_Confirm_Result3,
//		o_Confirm_Result4,
//		o_Confirm_Result5,
//		o_Confirm_Result6,
//		o_Confirm_Result7,
//		o_Confirm_Result8,
//		o_Confirm_Result9,
//		o_Confirm_Result10,
//		o_Confirm_Result11,
//		o_Confirm_Result12,
//		o_Confirm_Result13,
	
//	// for Simulation
//	output [VTWID-1:0] o_Segment_Vector;
//
//	output [VTWID-1:0] o_Mask_Vector1;
//	output [VTWID-1:0] o_Mask_Vector2;
//	output [VTWID-1:0] o_Mask_Vector3;
//	output [VTWID-1:0] o_Mask_Vector4;
//	output [VTWID-1:0] o_Mask_Vector5;
//	output [VTWID-1:0] o_Mask_Vector6;
//	output [VTWID-1:0] o_Mask_Vector7;
//	output [VTWID-1:0] o_Mask_Vector8;
//	output [VTWID-1:0] o_Mask_Vector9;
//	output [VTWID-1:0] o_Mask_Vector10;
//	output [VTWID-1:0] o_Mask_Vector11;
//	output [VTWID-1:0] o_Mask_Vector12;
//	output [VTWID-1:0] o_Mask_Vector13;
// 
//	output [CFWID-1:0] o_Confirm_Result1;
//	output [CFWID-1:0] o_Confirm_Result2;
//	output [CFWID-1:0] o_Confirm_Result3;
//	output [CFWID-1:0] o_Confirm_Result4;
//	output [CFWID-1:0] o_Confirm_Result5;
//	output [CFWID-1:0] o_Confirm_Result6;
//	output [CFWID-1:0] o_Confirm_Result7;
//	output [CFWID-1:0] o_Confirm_Result8;
//	output [CFWID-1:0] o_Confirm_Result9;
//	output [CFWID-1:0] o_Confirm_Result10;
//	output [CFWID-1:0] o_Confirm_Result11;
//	output [CFWID-1:0] o_Confirm_Result12;
//	output [CFWID-1:0] o_Confirm_Result13;



//	// =========================================================
//	// == Output Assignment For Simulation     
//	// =========================================================
//	assign o_Segment_Vector = Segment_Vector;
//	
//	assign o_Mask_Vector1  = Mask_Vector_n1;
//	assign o_Mask_Vector2  = Mask_Vector_n2;
//	assign o_Mask_Vector3  = Mask_Vector_n3;
//	assign o_Mask_Vector4  = Mask_Vector_n4;
//	assign o_Mask_Vector5  = Mask_Vector_n5;
//	assign o_Mask_Vector6  = Mask_Vector_n6;
//	assign o_Mask_Vector7  = Mask_Vector_n7;
//	assign o_Mask_Vector8  = Mask_Vector_n8;
//	assign o_Mask_Vector9  = Mask_Vector_n9;
//	assign o_Mask_Vector10 = Mask_Vector_n10;
//	assign o_Mask_Vector11 = Mask_Vector_n11;
//	assign o_Mask_Vector12 = Mask_Vector_n12;
//	assign o_Mask_Vector13 = Mask_Vector_n13;
//	
//	assign o_Confirm_Result1  = Confirm_Result_n1;
//	assign o_Confirm_Result2  = Confirm_Result_n2;
//	assign o_Confirm_Result3  = Confirm_Result_n3;
//	assign o_Confirm_Result4  = Confirm_Result_n4;
//	assign o_Confirm_Result5  = Confirm_Result_n5;
//	assign o_Confirm_Result6  = Confirm_Result_n6;
//	assign o_Confirm_Result7  = Confirm_Result_n7;
//	assign o_Confirm_Result8  = Confirm_Result_n8;
//	assign o_Confirm_Result9  = Confirm_Result_n9;
//	assign o_Confirm_Result10 = Confirm_Result_n10;
//	assign o_Confirm_Result11 = Confirm_Result_n11;
//	assign o_Confirm_Result12 = Confirm_Result_n12;
//	assign o_Confirm_Result13 = Confirm_Result_n13;