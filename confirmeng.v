module confirmeng
	(
		clk,
		rst,
		
		// for searching purpose
		i_Key,
		
		i_Compare_Result1, 
		i_Compare_Result2, 
		i_Compare_Result3, 
		i_Compare_Result4, 
		i_Compare_Result5, 
		i_Compare_Result6, 
		i_Compare_Result7, 
		i_Compare_Result8, 
		i_Compare_Result9, 
		i_Compare_Result10,
		i_Compare_Result11,
		i_Compare_Result12,
		i_Compare_Result13,
		
		o_Confirm_Result1,
		o_Confirm_Result2,
		o_Confirm_Result3,
		o_Confirm_Result4,
		o_Confirm_Result5,
		o_Confirm_Result6,
		o_Confirm_Result7,
		o_Confirm_Result8,
		o_Confirm_Result9,
		o_Confirm_Result10,
		o_Confirm_Result11,
		o_Confirm_Result12,
		o_Confirm_Result13,
		
		// for setting purpose
		i_Set_Confirm_ID,	// ID for Confirmation
		i_Set_Confirm_String,
		i_Set_Confirm_Enable
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
	
	// for searching purpose
	input [KWID-1:0]	i_Key;
	
	input [SEGWID-1:0]	i_Compare_Result1; 	
	input [SEGWID-1:0]	i_Compare_Result2; 
	input [SEGWID-1:0]	i_Compare_Result3; 
	input [SEGWID-1:0]	i_Compare_Result4; 
	input [SEGWID-1:0]	i_Compare_Result5; 
	input [SEGWID-1:0]	i_Compare_Result6; 	
	input [SEGWID-1:0]	i_Compare_Result7; 
	input [SEGWID-1:0]	i_Compare_Result8; 
	input [SEGWID-1:0]	i_Compare_Result9; 
	input [SEGWID-1:0]	i_Compare_Result10;
	input [SEGWID-1:0]	i_Compare_Result11;
	input [SEGWID-1:0]	i_Compare_Result12;
	input [SEGWID-1:0]	i_Compare_Result13;
	
	output [CFWID-1:0]	o_Confirm_Result1;
	output [CFWID-1:0]	o_Confirm_Result2;
	output [CFWID-1:0]	o_Confirm_Result3;
	output [CFWID-1:0]	o_Confirm_Result4;
	output [CFWID-1:0]	o_Confirm_Result5;
	output [CFWID-1:0]	o_Confirm_Result6;
	output [CFWID-1:0]	o_Confirm_Result7;
	output [CFWID-1:0]	o_Confirm_Result8;
	output [CFWID-1:0]	o_Confirm_Result9;
	output [CFWID-1:0]	o_Confirm_Result10;
	output [CFWID-1:0]	o_Confirm_Result11;
	output [CFWID-1:0]	o_Confirm_Result12;
	output [CFWID-1:0]	o_Confirm_Result13;
	
	// for setting purpose
	input [IDWID-1:0] i_Set_Confirm_ID;
	input [TOTALWID-1:0] i_Set_Confirm_String;
	input i_Set_Confirm_Enable;

// ============================================================================
// == Signal Declarations and Delays
// ============================================================================
	// =============================
	// == Connecting Memories:
	// =============================
	confirmmem 	Confirm_Mem_1	(clk, rst, i_Key, i_Compare_Result1, o_Confirm_Result1, i_Set_Confirm_ID, i_Set_Confirm_String, i_Set_Confirm_Enable);
	confirmmem 	Confirm_Mem_2	(clk, rst, i_Key, i_Compare_Result2, o_Confirm_Result2, i_Set_Confirm_ID, i_Set_Confirm_String, i_Set_Confirm_Enable);
	confirmmem 	Confirm_Mem_3	(clk, rst, i_Key, i_Compare_Result3, o_Confirm_Result3, i_Set_Confirm_ID, i_Set_Confirm_String, i_Set_Confirm_Enable);
	confirmmem 	Confirm_Mem_4	(clk, rst, i_Key, i_Compare_Result4, o_Confirm_Result4, i_Set_Confirm_ID, i_Set_Confirm_String, i_Set_Confirm_Enable);
	confirmmem 	Confirm_Mem_5	(clk, rst, i_Key, i_Compare_Result5, o_Confirm_Result5, i_Set_Confirm_ID, i_Set_Confirm_String, i_Set_Confirm_Enable);
	confirmmem 	Confirm_Mem_6	(clk, rst, i_Key, i_Compare_Result6, o_Confirm_Result6, i_Set_Confirm_ID, i_Set_Confirm_String, i_Set_Confirm_Enable);
	confirmmem 	Confirm_Mem_7	(clk, rst, i_Key, i_Compare_Result7, o_Confirm_Result7, i_Set_Confirm_ID, i_Set_Confirm_String, i_Set_Confirm_Enable);
	confirmmem 	Confirm_Mem_8	(clk, rst, i_Key, i_Compare_Result8, o_Confirm_Result8, i_Set_Confirm_ID, i_Set_Confirm_String, i_Set_Confirm_Enable);
	confirmmem 	Confirm_Mem_9	(clk, rst, i_Key, i_Compare_Result9, o_Confirm_Result9, i_Set_Confirm_ID, i_Set_Confirm_String, i_Set_Confirm_Enable);
	confirmmem 	Confirm_Mem_10	(clk, rst, i_Key, i_Compare_Result10, o_Confirm_Result10, i_Set_Confirm_ID, i_Set_Confirm_String, i_Set_Confirm_Enable);
	confirmmem 	Confirm_Mem_11	(clk, rst, i_Key, i_Compare_Result11, o_Confirm_Result11, i_Set_Confirm_ID, i_Set_Confirm_String, i_Set_Confirm_Enable);
	confirmmem 	Confirm_Mem_12	(clk, rst, i_Key, i_Compare_Result12, o_Confirm_Result12, i_Set_Confirm_ID, i_Set_Confirm_String, i_Set_Confirm_Enable);
	confirmmem 	Confirm_Mem_13	(clk, rst, i_Key, i_Compare_Result13, o_Confirm_Result13, i_Set_Confirm_ID, i_Set_Confirm_String, i_Set_Confirm_Enable);

endmodule 