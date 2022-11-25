module priocmpeng
	(
		clk,
		rst,
	
		i_Confirm_Result1,
		i_Confirm_Result2,
		i_Confirm_Result3,
		i_Confirm_Result4,
		i_Confirm_Result5,
		i_Confirm_Result6,
		i_Confirm_Result7,
		i_Confirm_Result8,
		i_Confirm_Result9,
		i_Confirm_Result10,
		i_Confirm_Result11,
		i_Confirm_Result12,
		i_Confirm_Result13,
		
		o_ruleid,
		o_valid
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
// == Port Declarations
// ============================================================================
	input clk;
	input rst;
	
	input [CFWID-1:0]	i_Confirm_Result1;
	input [CFWID-1:0]	i_Confirm_Result2;
	input [CFWID-1:0]	i_Confirm_Result3;
	input [CFWID-1:0]	i_Confirm_Result4;
	input [CFWID-1:0]	i_Confirm_Result5;
	input [CFWID-1:0]	i_Confirm_Result6; 
	input [CFWID-1:0]	i_Confirm_Result7; 
	input [CFWID-1:0]	i_Confirm_Result8; 
	input [CFWID-1:0]	i_Confirm_Result9; 
	input [CFWID-1:0]	i_Confirm_Result10;
	input [CFWID-1:0]	i_Confirm_Result11;
	input [CFWID-1:0]	i_Confirm_Result12;
	input [CFWID-1:0]	i_Confirm_Result13;	
	
	output [IDWID-1:0] 	o_ruleid;
	output 		 		o_valid;

// ============================================================================
// == Signal Declarations
// ============================================================================
	wire valid;
	
	// ==== Comparision Level 0 Registers
	reg [220:0] result_lv0;
	
	// ==== Comparision Level 1 Registers
	reg [118:0] result_lv1;
	
	// ==== Comparision Level 2 Registers
	reg [67:0] result_lv2;
	
	// ==== Comparision Level 3 Registers
	reg [33:0] result_lv3;
	
	// ==== Comparision Level 4 Registers
	reg [16:0] result_lv4;
	
// ============================================================================
// == Architecture
// ============================================================================
	assign valid = 	i_Confirm_Result1[CFWID-1]  | 
					i_Confirm_Result2[CFWID-1]  | 						
					i_Confirm_Result3[CFWID-1]  |
					i_Confirm_Result4[CFWID-1]  |						
					i_Confirm_Result5[CFWID-1]  | 
					i_Confirm_Result6[CFWID-1]  | 
					i_Confirm_Result7[CFWID-1]  | 
					i_Confirm_Result8[CFWID-1]  | 
					i_Confirm_Result9[CFWID-1]  | 
					i_Confirm_Result10[CFWID-1] | 
					i_Confirm_Result11[CFWID-1] | 
					i_Confirm_Result12[CFWID-1] | 
					i_Confirm_Result13[CFWID-1]; 
	wire valid5;
	ffxkclkx #(5, 1) pp_valid (clk, rst, valid, valid5);
	
	
	always @(posedge clk)
	begin 
		if (rst)	
			result_lv0 <= 221'b0;
		else 
			result_lv0[16:0] 	<= i_Confirm_Result1;
			result_lv0[33:17] 	<= i_Confirm_Result2;
			result_lv0[50:34] 	<= i_Confirm_Result3;
			result_lv0[67:51] 	<= i_Confirm_Result4;
			result_lv0[84:68] 	<= i_Confirm_Result5;
			result_lv0[101:85] 	<= i_Confirm_Result6;
			result_lv0[118:102] <= i_Confirm_Result7;
			result_lv0[135:119] <= i_Confirm_Result8;
			result_lv0[152:136] <= i_Confirm_Result9;
			result_lv0[169:153] <= i_Confirm_Result10;
			result_lv0[186:170] <= i_Confirm_Result11;
			result_lv0[203:187] <= i_Confirm_Result12;
			result_lv0[220:204] <= i_Confirm_Result13;		
	end 
	
	// ------------------------------------------
	wire [CFWID-1:0] Confirm_Result1;
	assign Confirm_Result1  = result_lv0[16:0]; 
	
	wire [CFWID-1:0] Confirm_Result2;
	assign Confirm_Result2  = result_lv0[33:17]; 
	
	wire [CFWID-1:0] Confirm_Result3;
	assign Confirm_Result3  = result_lv0[50:34];
	
	wire [CFWID-1:0] Confirm_Result4;
	assign Confirm_Result4  = result_lv0[67:51];
	
	wire [CFWID-1:0] Confirm_Result5;
	assign Confirm_Result5  = result_lv0[84:68];
	
	wire [CFWID-1:0] Confirm_Result6;
	assign Confirm_Result6  = result_lv0[101:85];
	
	wire [CFWID-1:0] Confirm_Result7;
	assign Confirm_Result7  = result_lv0[118:102];
	
	wire [CFWID-1:0] Confirm_Result8;
	assign Confirm_Result8  = result_lv0[135:119];
	
	wire [CFWID-1:0] Confirm_Result9;
	assign Confirm_Result9  = result_lv0[152:136];
	
	wire [CFWID-1:0] Confirm_Result10;
	assign Confirm_Result10 = result_lv0[169:153];
	
	wire [CFWID-1:0] Confirm_Result11;
	assign Confirm_Result11 = result_lv0[186:170];
	
	wire [CFWID-1:0] Confirm_Result12;
	assign Confirm_Result12 = result_lv0[203:187];
	
	wire [CFWID-1:0] Confirm_Result13;
	assign Confirm_Result13 = result_lv0[220:204];
	
	
	// ==========================================
	// == Level 1
	// ==========================================
	wire pair1_lv1;
	assign pair1_lv1 = (Confirm_Result1[7:0] >= Confirm_Result2[7:0]);
	
	wire pair2_lv1;
	assign pair2_lv1 = (Confirm_Result3[7:0] >= Confirm_Result4[7:0]);
	
	wire pair3_lv1;
	assign pair3_lv1 = (Confirm_Result5[7:0] >= Confirm_Result6[7:0]);
	
	wire pair4_lv1;
	assign pair4_lv1 = (Confirm_Result7[7:0] >= Confirm_Result8[7:0]);
	
	wire pair5_lv1;
	assign pair5_lv1 = (Confirm_Result9[7:0] >= Confirm_Result10[7:0]);
	
	wire pair6_lv1;
	assign pair6_lv1 = (Confirm_Result11[7:0] >= Confirm_Result12[7:0]);
	
	// -- Behavioral
	always @(posedge clk)
	begin
		if (rst)
			result_lv1 <= 'b0;
		else
			// -- Result of pair 1
			result_lv1[16:0] <= (Confirm_Result1[CFWID-1] & Confirm_Result2[CFWID-1]) ? 
							    (pair1_lv1) ? Confirm_Result1 : Confirm_Result2 :
							    (Confirm_Result1[CFWID-1]) ? Confirm_Result1  :
							    (Confirm_Result2[CFWID-1]) ? Confirm_Result2  :   17'b0;
			// -- Result of pair 2
			result_lv1[33:17] <= (Confirm_Result3[CFWID-1] & Confirm_Result4[CFWID-1]) ? 
							    (pair2_lv1) ? Confirm_Result3 : Confirm_Result4 :
							    (Confirm_Result3[CFWID-1]) ? Confirm_Result3  :
							    (Confirm_Result4[CFWID-1]) ? Confirm_Result4  :   17'b0;
			// -- Result of pair 3
			result_lv1[50:34] <= (Confirm_Result5[CFWID-1] & Confirm_Result6[CFWID-1]) ? 
							    (pair3_lv1) ? Confirm_Result5 : Confirm_Result6 :
							    (Confirm_Result5[CFWID-1]) ? Confirm_Result5  :
							    (Confirm_Result6[CFWID-1]) ? Confirm_Result6  :   17'b0;
			// -- Result of pair 4
			result_lv1[67:51] <= (Confirm_Result7[CFWID-1] & Confirm_Result8[CFWID-1]) ? 
							    (pair4_lv1) ? Confirm_Result7 : Confirm_Result8 :
							    (Confirm_Result7[CFWID-1]) ? Confirm_Result7  :
							    (Confirm_Result8[CFWID-1]) ? Confirm_Result8  :   17'b0;
			// -- Result of pair 5
			result_lv1[84:68] <= (Confirm_Result9[CFWID-1] & Confirm_Result10[CFWID-1]) ? 
							    (pair5_lv1) ? Confirm_Result9 : Confirm_Result10 :
							    (Confirm_Result9[CFWID-1]) ? Confirm_Result9  :
							    (Confirm_Result10[CFWID-1]) ? Confirm_Result10  :   17'b0;
			// -- Result of pair 6
			result_lv1[101:85] <= (Confirm_Result11[CFWID-1] & Confirm_Result12[CFWID-1]) ? 
							    (pair6_lv1) ? Confirm_Result11 : Confirm_Result12 :
							    (Confirm_Result11[CFWID-1]) ? Confirm_Result11  :
							    (Confirm_Result12[CFWID-1]) ? Confirm_Result12  :   17'b0;
			// -- Result 7
			result_lv1[118:102] <= Confirm_Result13;
	end 
	
	// ==========================================
	// == Level 2
	// ==========================================
	wire pair1_lv2;
	assign pair1_lv2 = (result_lv1[7:0] >= result_lv1[24:17]);
	
	wire pair2_lv2;
	assign pair2_lv2 = (result_lv1[41:34] >= result_lv1[58:51]);
	
	wire pair3_lv2;
	assign pair3_lv2 = (result_lv1[75:68] >= result_lv1[92:85]);
	
	// -- Behavioral
	always @(posedge clk)
	begin
		if (rst)
			result_lv2 <= 'b0;
		else 
			// -- Result of pair 1
			result_lv2[16:0] <= (result_lv1[16] & result_lv1[33]) ?
							    (pair1_lv2) ? result_lv1[16:0] : result_lv1[33:17] :
							    (result_lv1[16]) ? result_lv1[16:0] : 
							    (result_lv1[33]) ? result_lv1[33:17] :	17'b0;
			// -- Result of pair 2
			result_lv2[33:17] <= (result_lv1[50] & result_lv1[67]) ?
							    (pair2_lv2) ? result_lv1[50:34] : result_lv1[67:51] :
							    (result_lv1[50]) ? result_lv1[50:34] : 
							    (result_lv1[67]) ? result_lv1[67:51] :	17'b0;
			// -- Result of pair 3
			result_lv2[50:34] <= (result_lv1[84] & result_lv1[101]) ?
							    (pair3_lv2) ? result_lv1[84:68] : result_lv1[101:85] :
							    (result_lv1[84]) ? result_lv1[84:68] : 
							    (result_lv1[101]) ? result_lv1[101:85] :	17'b0;
			// -- Result of pair 4
			result_lv2[67:51] <= result_lv1[118:112];
	end 
	
	// ==========================================
	// == Level 3
	// ==========================================
	wire pair1_lv3;
	assign pair1_lv3 = (result_lv2[7:0] >= result_lv2[24:17]);
	
	wire pair2_lv3;
	assign pair2_lv3 = (result_lv2[41:34] >= result_lv2[58:51]);
	
	// -- Behavioral
	always @(posedge clk)
	begin
		if (rst)
			result_lv3 <= 'b0;
		else 
			// -- Result of pair 1
			result_lv3[16:0] <= (result_lv2[16] & result_lv2[33]) ?
							  (pair1_lv3) ? result_lv2[16:0] : result_lv2[33:17] :
							  (result_lv2[16]) ? result_lv2[16:0] : 
							  (result_lv2[33]) ? result_lv2[33:17] :  17'b0;
			// -- Result of pair 2
			result_lv3[33:17] <= (result_lv2[50] & result_lv2[67]) ?
							  (pair2_lv3) ? result_lv2[50:34] : result_lv2[67:51] :
							  (result_lv2[50]) ? result_lv2[50:34] : 
							  (result_lv2[67]) ? result_lv2[67:51] :  17'b0;
	end
	
	// ==========================================
	// == Level 4
	// ==========================================
	wire pair1_lv4;
	assign pair1_lv4 = (result_lv3[7:0] >= result_lv3[24:17]);
	
	// -- Behavioral
	always @(posedge clk)
	begin
		if (rst)
			result_lv4 <= 'b0;
		else 
			// -- Result of pair 1
			result_lv4[16:0] <= (result_lv3[16] & result_lv3[33]) ?
							  (pair1_lv4) ? result_lv3[16:0] : result_lv3[33:17] :
							  (result_lv3[16]) ? result_lv3[16:0] : 
							  (result_lv3[33]) ? result_lv3[33:17] :  17'b0;
	end
// ============================================================================
// == Output Assignment
// ============================================================================
	assign o_valid = valid5;
	assign o_ruleid = (valid5) ? result_lv4[15:8] : 8'b0;
endmodule 