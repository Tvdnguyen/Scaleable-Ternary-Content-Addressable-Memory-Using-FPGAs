module compareeng 
	(
		clk, 
		rst, 
		
		// for searching purpose
		i_Mask_Vector1,
		i_Mask_Vector2,
		i_Mask_Vector3,
		i_Mask_Vector4,
		i_Mask_Vector5,
		i_Mask_Vector6,
		i_Mask_Vector7,
		i_Mask_Vector8,
		i_Mask_Vector9,
		i_Mask_Vector10,
		i_Mask_Vector11,
		i_Mask_Vector12,
		i_Mask_Vector13,
		
		o_Compare_Result1,
		o_Compare_Result2,
		o_Compare_Result3,
		o_Compare_Result4,
		o_Compare_Result5,
		o_Compare_Result6,
		o_Compare_Result7,
		o_Compare_Result8,
		o_Compare_Result9,
		o_Compare_Result10,
		o_Compare_Result11,
		o_Compare_Result12,
		o_Compare_Result13
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

// ============================================================================
// == Port declarations
// ============================================================================
	input clk;
	input rst; 
	
	input [VTWID-1:0] i_Mask_Vector1;
	input [VTWID-1:0] i_Mask_Vector2;
	input [VTWID-1:0] i_Mask_Vector3;
	input [VTWID-1:0] i_Mask_Vector4;
	input [VTWID-1:0] i_Mask_Vector5;
	input [VTWID-1:0] i_Mask_Vector6;
	input [VTWID-1:0] i_Mask_Vector7;
	input [VTWID-1:0] i_Mask_Vector8;
	input [VTWID-1:0] i_Mask_Vector9;
	input [VTWID-1:0] i_Mask_Vector10;
	input [VTWID-1:0] i_Mask_Vector11;
	input [VTWID-1:0] i_Mask_Vector12;
	input [VTWID-1:0] i_Mask_Vector13;
	
	output [SEGWID-1:0] o_Compare_Result1;
	output [SEGWID-1:0] o_Compare_Result2;
	output [SEGWID-1:0] o_Compare_Result3;
	output [SEGWID-1:0] o_Compare_Result4;
	output [SEGWID-1:0] o_Compare_Result5;
	output [SEGWID-1:0] o_Compare_Result6;
	output [SEGWID-1:0] o_Compare_Result7;
	output [SEGWID-1:0] o_Compare_Result8;
	output [SEGWID-1:0] o_Compare_Result9;
	output [SEGWID-1:0] o_Compare_Result10;
	output [SEGWID-1:0] o_Compare_Result11;
	output [SEGWID-1:0] o_Compare_Result12;
	output [SEGWID-1:0] o_Compare_Result13;

// ============================================================================
// == Architecture
// ============================================================================
	// -- Inst 
	compreng  Compare_Inst_1  (clk, rst, i_Mask_Vector1, o_Compare_Result1);
	compreng  Compare_Inst_2  (clk, rst, i_Mask_Vector2, o_Compare_Result2);
	compreng  Compare_Inst_3  (clk, rst, i_Mask_Vector3, o_Compare_Result3);
	compreng  Compare_Inst_4  (clk, rst, i_Mask_Vector4, o_Compare_Result4);
	compreng  Compare_Inst_5  (clk, rst, i_Mask_Vector5, o_Compare_Result5);
	compreng  Compare_Inst_6  (clk, rst, i_Mask_Vector6, o_Compare_Result6);
	compreng  Compare_Inst_7  (clk, rst, i_Mask_Vector7, o_Compare_Result7);
	compreng  Compare_Inst_8  (clk, rst, i_Mask_Vector8, o_Compare_Result8);
	compreng  Compare_Inst_9  (clk, rst, i_Mask_Vector9, o_Compare_Result9);
	compreng  Compare_Inst_10 (clk, rst, i_Mask_Vector10, o_Compare_Result10);
	compreng  Compare_Inst_11 (clk, rst, i_Mask_Vector11, o_Compare_Result11);
	compreng  Compare_Inst_12 (clk, rst, i_Mask_Vector12, o_Compare_Result12);
	compreng  Compare_Inst_13 (clk, rst, i_Mask_Vector13, o_Compare_Result13);

endmodule