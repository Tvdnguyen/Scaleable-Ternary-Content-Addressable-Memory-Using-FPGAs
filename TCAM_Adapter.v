module TCAM_Adapter (
		// inputs 
		clk,
		rst,
		
		i_Key, 
		i_Set_String,
		i_Set_ID,
		i_Set_Enable,
		
		// outputs
		o_RuleID,
		o_Valid,
		o_SetDone
	);
	
// ==========================================================================
// == Parameters
// ==========================================================================
	parameter KWID 	= 104; //Key width
	parameter MASKWID = KWID/8; //13
	parameter IDWID = 8;
	parameter PRIOR = 8; // 8-bit priority
	parameter TOTALWID = KWID+MASKWID+PRIOR;

// ==========================================================================
// == Signal Declarations
// ==========================================================================
	wire [KWID-1:0] Key;
	wire [TOTALWID-1:0] String;
	wire [IDWID-1:0] ID;


// ==========================================================================
// == Port Declarations
// ==========================================================================
	input rst;
	input clk;
	
	// inputs
	input i_Key;
	input i_Set_String;
	input i_Set_ID;
	
	// outputs
	output o_RuleID;
	output o_Valid;
	output o_SetDone;

// ==========================================================================
// == Architecture: Structural
// ==========================================================================
	
	// -- Serial to Parallel Connection
	Serial_to_Parallel 	#(KWID)		Key_Inst	(clk, rst, i_Key, Key);
	Serial_to_Parallel 	#(TOTALWID)	String_Inst	(clk, rst, i_Set_String, String);
	Serial_to_Parallel 	#(IDWID) 	Set_ID_Inst	(clk, rst, i_Set_ID, ID);
	
	
	// -- TCAM
	tcam (	
		.clk(clk),
		.rst(rst),
		
		.i_Key(Key),
		.o_RuleID(o_RuleID),
		.o_Valid(o_Valid),
		.o_SetDone(o_SetDone),
	
		.i_Set_ID(ID),
		.i_Set_String(String),
		.i_Set_Enable(i_Set_Enable)	
	);
	
endmodule