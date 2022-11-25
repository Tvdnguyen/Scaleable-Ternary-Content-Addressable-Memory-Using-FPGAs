module compreng 
	(
		clk,
		rst,
		
		// for searching purpose
		i_Mask_Vector,
		o_Compare_Result
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
	
	input [VTWID-1:0] i_Mask_Vector;
	
	output [SEGWID-1:0] o_Compare_Result;
	
// ============================================================================
// == Architecture
// ============================================================================
	// ----------------------------------------------------------------------------------------------------------
	// -- Level 1
	reg [VTWID-1:0] Vector_Register_1;
	
	always @(posedge clk or posedge rst)
	begin
		if (rst)
			Vector_Register_1 <= 0;
		else
			Vector_Register_1 <= i_Mask_Vector;
	end
	
	// -- Connections
	wire [SEGWID-1:0] Mask_Result_11;
	wire [SEGWID-1:0] Mask_Result_21;
	wire [SEGWID-1:0] Mask_Result_31;
	wire [SEGWID-1:0] Mask_Result_41;
	wire [SEGWID-1:0] Mask_Result_51;
	wire [SEGWID-1:0] Mask_Result_61;
	wire [SEGWID-1:0] Mask_Result_71;
	
	// -- Datapath 
	compr_datapath 		Level_1_Inst1 	(Vector_Register_1[9:0], 	 Vector_Register_1[19:10], 	 Mask_Result_11);
	compr_datapath 		Level_1_Inst2 	(Vector_Register_1[29:20], 	 Vector_Register_1[39:30], 	 Mask_Result_21);
	compr_datapath 		Level_1_Inst3 	(Vector_Register_1[49:40], 	 Vector_Register_1[59:50], 	 Mask_Result_31);
	compr_datapath 		Level_1_Inst4 	(Vector_Register_1[69:60], 	 Vector_Register_1[79:70], 	 Mask_Result_41);
	compr_datapath 		Level_1_Inst5 	(Vector_Register_1[89:80], 	 Vector_Register_1[99:90],	 Mask_Result_51);
	compr_datapath 		Level_1_Inst6 	(Vector_Register_1[109:100], Vector_Register_1[119:110], Mask_Result_61);
	compr_datapath 		Level_1_Inst7 	(Vector_Register_1[129:120], Vector_Register_1[129:120], Mask_Result_71);		// Compare itself
	
	// ----------------------------------------------------------------------------------------------------------
	// -- Level 2	
	reg [69:0] Vector_Register_2;
	
	always @(posedge clk or posedge rst)
	begin
		if (rst)
			Vector_Register_2 <= 0;
		else begin
			Vector_Register_2[9:0] 	 <= Mask_Result_11;
			Vector_Register_2[19:10] <= Mask_Result_21;
			Vector_Register_2[29:20] <= Mask_Result_31;
			Vector_Register_2[39:30] <= Mask_Result_41;
			Vector_Register_2[49:40] <= Mask_Result_51;
			Vector_Register_2[59:50] <= Mask_Result_61;
			Vector_Register_2[69:60] <= Mask_Result_71;
		end
	end
	
	// -- Connections
	wire [SEGWID-1:0] Mask_Result_12;
	wire [SEGWID-1:0] Mask_Result_22;
	wire [SEGWID-1:0] Mask_Result_32;
	wire [SEGWID-1:0] Mask_Result_42;
	
	// -- Datapath 
	compr_datapath 		Level_2_Inst1 	(Vector_Register_2[9:0], 	 Vector_Register_2[19:10], 	 Mask_Result_12);
	compr_datapath 		Level_2_Inst2 	(Vector_Register_2[29:20], 	 Vector_Register_2[39:30], 	 Mask_Result_22);
	compr_datapath 		Level_2_Inst3 	(Vector_Register_2[49:40], 	 Vector_Register_2[59:50], 	 Mask_Result_32);
	compr_datapath 		Level_2_Inst4 	(Vector_Register_2[69:60], 	 Vector_Register_2[69:60], 	 Mask_Result_42);	// Compare itself
	
	// ----------------------------------------------------------------------------------------------------------
	// -- Level 3
	reg [39:0] Vector_Register_3;
	
	always @(posedge clk or posedge rst)
	begin
		if (rst)
			Vector_Register_3 <= 0;
		else begin
			Vector_Register_3[9:0] 	 <= Mask_Result_12;
			Vector_Register_3[19:10] <= Mask_Result_22;
			Vector_Register_3[29:20] <= Mask_Result_32;
			Vector_Register_3[39:30] <= Mask_Result_42;
		end
	end
	
	// -- Connections
	wire [SEGWID-1:0] Mask_Result_13;
	wire [SEGWID-1:0] Mask_Result_23;
	
	// -- Datapath 
	compr_datapath 		Level_3_Inst1 	(Vector_Register_3[9:0], 	 Vector_Register_3[19:10], 	 Mask_Result_13);
	compr_datapath 		Level_3_Inst2 	(Vector_Register_3[29:20], 	 Vector_Register_3[39:30], 	 Mask_Result_23);
	
	// ----------------------------------------------------------------------------------------------------------
	// -- Level 4
	reg [19:0] Vector_Register_4;
	
	always @(posedge clk or posedge rst)
	begin
		if (rst)
			Vector_Register_4 <= 0;
		else begin
			Vector_Register_4[9:0] 	 <= Mask_Result_13;
			Vector_Register_4[19:10] <= Mask_Result_23;
		end
	end
	
	// -- Connections
	wire [SEGWID-1:0] Mask_Result_14;
	
	// -- Datapath 
	compr_datapath 		Level_4_Inst1 	(Vector_Register_4[9:0], Vector_Register_4[19:10], Mask_Result_14);
	
	// ----------------------------------------------------------------------------------------------------------
	// -- Level 5
	reg [SEGWID-1:0] Vector_Register_5;
	
	always @(posedge clk or posedge rst)
	begin
		if (rst)
			Vector_Register_5 <= 0;
		else begin
			Vector_Register_5[9:0] 	<= Mask_Result_14;
		end
	end
	
// ============================================================================
// == Output Assignment
// ============================================================================
	assign o_Compare_Result = Vector_Register_5;
	
endmodule