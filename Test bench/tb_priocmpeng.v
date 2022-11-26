module tb_priocmpeng ();
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

	reg [CFWID-1:0] i_Confirm_Result1;
	reg [CFWID-1:0] i_Confirm_Result2;
	reg [CFWID-1:0] i_Confirm_Result3;
	reg [CFWID-1:0] i_Confirm_Result4;
	reg [CFWID-1:0] i_Confirm_Result5;
	reg [CFWID-1:0] i_Confirm_Result6;
	reg [CFWID-1:0] i_Confirm_Result7;
	reg [CFWID-1:0] i_Confirm_Result8;
	reg [CFWID-1:0] i_Confirm_Result9;
	reg [CFWID-1:0] i_Confirm_Result10;
	reg [CFWID-1:0] i_Confirm_Result11;
	reg [CFWID-1:0] i_Confirm_Result12;
	reg [CFWID-1:0] i_Confirm_Result13;

	wire [IDWID-1:0] 	o_ruleid;
	wire 				o_invalid;
	
// ==========================================================================
// == Component Instatiation : Device Under Test (DUT)
// ==========================================================================
	priocmpeng	Priority_Engine
		(
			.clk(clk),
			.rst(rst),
			
			.i_Confirm_Result1(i_Confirm_Result1),
			.i_Confirm_Result2(i_Confirm_Result2),
			.i_Confirm_Result3(i_Confirm_Result3),
			.i_Confirm_Result4(i_Confirm_Result4),
			.i_Confirm_Result5(i_Confirm_Result5),
			.i_Confirm_Result6(i_Confirm_Result6),
			.i_Confirm_Result7(i_Confirm_Result7),
			.i_Confirm_Result8(i_Confirm_Result8),
			.i_Confirm_Result9(i_Confirm_Result9),
			.i_Confirm_Result10(i_Confirm_Result10),
			.i_Confirm_Result11(i_Confirm_Result11),
			.i_Confirm_Result12(i_Confirm_Result12),
			.i_Confirm_Result13(i_Confirm_Result13),
			
			.o_ruleid(o_ruleid),
			.o_invalid(o_invalid)
		);

// ==========================================================================
// == Signal Declarations
// ==========================================================================
	reg [CFWID-1:0] Confirm_Vector_Seg1 [12:0];
	reg [CFWID-1:0] Confirm_Vector_Seg2 [12:0];
	reg [CFWID-1:0] Confirm_Vector_Seg3 [12:0];
	reg [CFWID-1:0] Confirm_Vector_Seg4 [12:0];
	reg [CFWID-1:0] Confirm_Vector_Seg5 [12:0];
	reg [CFWID-1:0] Confirm_Vector_Seg6 [12:0];
	reg [CFWID-1:0] Confirm_Vector_Seg7 [12:0];
	reg [CFWID-1:0] Confirm_Vector_Seg8 [12:0];
	reg [CFWID-1:0] Confirm_Vector_Seg9 [12:0];
	reg [CFWID-1:0] Confirm_Vector_Seg10 [12:0];
	
	reg [IDWID-1:0] Expected_ID_Seg1;
	reg [IDWID-1:0] Expected_ID_Seg2;
	reg [IDWID-1:0] Expected_ID_Seg3;
	reg [IDWID-1:0] Expected_ID_Seg4;
	reg [IDWID-1:0] Expected_ID_Seg5;
	reg [IDWID-1:0] Expected_ID_Seg6;
	reg [IDWID-1:0] Expected_ID_Seg7;
	reg [IDWID-1:0] Expected_ID_Seg8;
	reg [IDWID-1:0] Expected_ID_Seg9;
	reg [IDWID-1:0] Expected_ID_Seg10;
	
// ==========================================================================
// == Architecture of Test Bench
// ==========================================================================
// == Data Initialization
	initial 
	begin 
		// -- Confirm Inputs
		// -- Confirm Vector Seg 1
		Confirm_Vector_Seg1[0]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg1[1]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg1[2]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg1[3]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg1[4]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg1[5]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg1[6]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg1[7]  = {MATCH, R1, R1};
		Confirm_Vector_Seg1[8]  = {MATCH, R1, R1};
		Confirm_Vector_Seg1[9]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg1[10] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg1[11] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg1[12] = {NO_MATCH, R1, R1};
		
		// -- Confirm Vector Seg 2
		Confirm_Vector_Seg2[0]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg2[1]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg2[2]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg2[3]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg2[4]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg2[5]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg2[6]  = {MATCH, R2, R2};
		Confirm_Vector_Seg2[7]  = {MATCH, R2, R2};
		Confirm_Vector_Seg2[8]  = {MATCH, R2, R2};
		Confirm_Vector_Seg2[9]  = {MATCH, R2, R2};
		Confirm_Vector_Seg2[10] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg2[11] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg2[12] = {NO_MATCH, R1, R1};
		
		// -- Confirm Vector Seg 3
		Confirm_Vector_Seg3[0]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg3[1]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg3[2]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg3[3]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg3[4]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg3[5]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg3[6]  = {MATCH, R3, R3};
		Confirm_Vector_Seg3[7]  = {MATCH, R3, R3};
		Confirm_Vector_Seg3[8]  = {MATCH, R3, R3};
		Confirm_Vector_Seg3[9]  = {MATCH, R3, R3};
		Confirm_Vector_Seg3[10] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg3[11] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg3[12] = {NO_MATCH, R1, R1};
		
		// -- Confirm Vector Seg 4
		Confirm_Vector_Seg4[0]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg4[1]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg4[2]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg4[3]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg4[4]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg4[5]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg4[6]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg4[7]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg4[8]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg4[9]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg4[10] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg4[11] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg4[12] = {NO_MATCH, R1, R1};
		
		// -- Confirm Vector Seg 5
		Confirm_Vector_Seg5[0]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg5[1]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg5[2]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg5[3]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg5[4]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg5[5]  = {MATCH, R5, R5};
		Confirm_Vector_Seg5[6]  = {MATCH, R5, R5};
		Confirm_Vector_Seg5[7]  = {MATCH, R5, R5};
		Confirm_Vector_Seg5[8]  = {MATCH, R5, R5};
		Confirm_Vector_Seg5[9]  = {MATCH, R5, R5};
		Confirm_Vector_Seg5[10] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg5[11] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg5[12] = {NO_MATCH, R1, R1};
		
		// -- Confirm Vector Seg 6
		Confirm_Vector_Seg6[0]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg6[1]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg6[2]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg6[3]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg6[4]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg6[5]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg6[6]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg6[7]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg6[8]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg6[9]  = {MATCH, R6, R6};
		Confirm_Vector_Seg6[10] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg6[11] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg6[12] = {NO_MATCH, R1, R1};
		
		// -- Confirm Vector Seg 7
		Confirm_Vector_Seg7[0]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg7[1]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg7[2]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg7[3]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg7[4]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg7[5]  = {MATCH, R7, R7};
		Confirm_Vector_Seg7[6]  = {MATCH, R7, R7};
		Confirm_Vector_Seg7[7]  = {MATCH, R7, R7};
		Confirm_Vector_Seg7[8]  = {MATCH, R7, R7};
		Confirm_Vector_Seg7[9]  = {MATCH, R7, R7};
		Confirm_Vector_Seg7[10] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg7[11] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg7[12] = {NO_MATCH, R1, R1};
		
		// -- Confirm Vector Seg 8
		Confirm_Vector_Seg8[0]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg8[1]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg8[2]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg8[3]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg8[4]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg8[5]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg8[6]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg8[7]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg8[8]  = {MATCH, R8, R8};
		Confirm_Vector_Seg8[9]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg8[10] = {NO_MATCH, R1, R1}; 
		Confirm_Vector_Seg8[11] = {NO_MATCH, R1, R1}; 
		Confirm_Vector_Seg8[12] = {NO_MATCH, R1, R1};
		
		// -- Confirm Vector Seg 9
		Confirm_Vector_Seg9[0]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg9[1]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg9[2]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg9[3]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg9[4]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg9[5]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg9[6]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg9[7]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg9[8]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg9[9]  = {MATCH, R9, R9};
		Confirm_Vector_Seg9[10] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg9[11] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg9[12] = {NO_MATCH, R1, R1};
		
		// -- Confirm Vector Seg 10
		Confirm_Vector_Seg10[0]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg10[1]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg10[2]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg10[3]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg10[4]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg10[5]  = {MATCH, R10, R10};
		Confirm_Vector_Seg10[6]  = {MATCH, R10, R10};
		Confirm_Vector_Seg10[7]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg10[8]  = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg10[9]  = {MATCH, R10, R10};
		Confirm_Vector_Seg10[10] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg10[11] = {NO_MATCH, R1, R1};
		Confirm_Vector_Seg10[12] = {NO_MATCH, R1, R1};
		
		// -- Expected Result 
		// -- Expected ID Seg 1
		Expected_ID_Seg1 = R1;
		Expected_ID_Seg2 = R2;
		Expected_ID_Seg3 = R3;
		Expected_ID_Seg4 = 8'bx;
		Expected_ID_Seg5 = R5;
		Expected_ID_Seg6 = R6;
		Expected_ID_Seg7 = R7;
		Expected_ID_Seg8 = R8;
		Expected_ID_Seg9 = R9;
		Expected_ID_Seg10 = R10;
	end 
	
	// -- Generate clock
	always #10 clk = ~clk;
	
	// -- Process 
	initial
	begin
		clk = 0;
		
		@(negedge clk);
		
		// -- Compare Seg 1
		$display("--------------------------------------- Rule ID of KEY 1 ---------------------------------------");
		compare
			(
				Confirm_Vector_Seg1[0], 
				Confirm_Vector_Seg1[1], 
				Confirm_Vector_Seg1[2], 
				Confirm_Vector_Seg1[3], 
				Confirm_Vector_Seg1[4], 
				Confirm_Vector_Seg1[5], 
				Confirm_Vector_Seg1[6], 
				Confirm_Vector_Seg1[7], 
				Confirm_Vector_Seg1[8], 
				Confirm_Vector_Seg1[9], 
				Confirm_Vector_Seg1[10],
				Confirm_Vector_Seg1[11],
				Confirm_Vector_Seg1[12],
				
				Expected_ID_Seg1
			);
		
		// -- Compare Seg 2
		@(negedge clk);
		$display("--------------------------------------- Rule ID of KEY 2 ---------------------------------------");
		compare
			(
				Confirm_Vector_Seg2[0], 
				Confirm_Vector_Seg2[1], 
				Confirm_Vector_Seg2[2], 
				Confirm_Vector_Seg2[3], 
				Confirm_Vector_Seg2[4], 
				Confirm_Vector_Seg2[5], 
				Confirm_Vector_Seg2[6], 
				Confirm_Vector_Seg2[7], 
				Confirm_Vector_Seg2[8], 
				Confirm_Vector_Seg2[9], 
				Confirm_Vector_Seg2[10],
				Confirm_Vector_Seg2[11],
				Confirm_Vector_Seg2[12],
				
				Expected_ID_Seg2
			);
		
		// -- Compare Seg 3
		@(negedge clk);
		$display("--------------------------------------- Rule ID of KEY 3 ---------------------------------------");
		compare
			(
				Confirm_Vector_Seg3[0], 
				Confirm_Vector_Seg3[1], 
				Confirm_Vector_Seg3[2], 
				Confirm_Vector_Seg3[3], 
				Confirm_Vector_Seg3[4], 
				Confirm_Vector_Seg3[5], 
				Confirm_Vector_Seg3[6], 
				Confirm_Vector_Seg3[7], 
				Confirm_Vector_Seg3[8], 
				Confirm_Vector_Seg3[9], 
				Confirm_Vector_Seg3[10],
				Confirm_Vector_Seg3[11],
				Confirm_Vector_Seg3[12],
				
				Expected_ID_Seg3
			);
			
		// -- Compare Seg 4
		@(negedge clk);
		$display("--------------------------------------- Rule ID of KEY 4 ---------------------------------------");
		compare
			(
				Confirm_Vector_Seg4[0], 
				Confirm_Vector_Seg4[1], 
				Confirm_Vector_Seg4[2], 
				Confirm_Vector_Seg4[3], 
				Confirm_Vector_Seg4[4], 
				Confirm_Vector_Seg4[5], 
				Confirm_Vector_Seg4[6], 
				Confirm_Vector_Seg4[7], 
				Confirm_Vector_Seg4[8], 
				Confirm_Vector_Seg4[9], 
				Confirm_Vector_Seg4[10],
				Confirm_Vector_Seg4[11],
				Confirm_Vector_Seg4[12],
				
				Expected_ID_Seg4
			);
		
		// -- Compare Seg 5
		@(negedge clk);
		$display("--------------------------------------- Rule ID of KEY 5 ---------------------------------------");
		compare
			(
				Confirm_Vector_Seg5[0], 
				Confirm_Vector_Seg5[1], 
				Confirm_Vector_Seg5[2], 
				Confirm_Vector_Seg5[3], 
				Confirm_Vector_Seg5[4], 
				Confirm_Vector_Seg5[5], 
				Confirm_Vector_Seg5[6], 
				Confirm_Vector_Seg5[7], 
				Confirm_Vector_Seg5[8], 
				Confirm_Vector_Seg5[9], 
				Confirm_Vector_Seg5[10],
				Confirm_Vector_Seg5[11],
				Confirm_Vector_Seg5[12],
				
				Expected_ID_Seg5
			);	

		// -- Compare Seg 6
		@(negedge clk);
		$display("--------------------------------------- Rule ID of KEY 6 ---------------------------------------");
		compare
			(
				Confirm_Vector_Seg6[0], 
				Confirm_Vector_Seg6[1], 
				Confirm_Vector_Seg6[2], 
				Confirm_Vector_Seg6[3], 
				Confirm_Vector_Seg6[4], 
				Confirm_Vector_Seg6[5], 
				Confirm_Vector_Seg6[6], 
				Confirm_Vector_Seg6[7], 
				Confirm_Vector_Seg6[8], 
				Confirm_Vector_Seg6[9], 
				Confirm_Vector_Seg6[10],
				Confirm_Vector_Seg6[11],
				Confirm_Vector_Seg6[12],
				
				Expected_ID_Seg6
			);	
			
		// -- Compare Seg 7
		@(negedge clk);
		$display("--------------------------------------- Rule ID of KEY 7 ---------------------------------------");
		compare
			(
				Confirm_Vector_Seg7[0], 
				Confirm_Vector_Seg7[1], 
				Confirm_Vector_Seg7[2], 
				Confirm_Vector_Seg7[3], 
				Confirm_Vector_Seg7[4], 
				Confirm_Vector_Seg7[5], 
				Confirm_Vector_Seg7[6], 
				Confirm_Vector_Seg7[7], 
				Confirm_Vector_Seg7[8], 
				Confirm_Vector_Seg7[9], 
				Confirm_Vector_Seg7[10],
				Confirm_Vector_Seg7[11],
				Confirm_Vector_Seg7[12],
				
				Expected_ID_Seg7
			);	
			
		// -- Compare Seg 8
		@(negedge clk);
		$display("--------------------------------------- Rule ID of KEY 8 ---------------------------------------");
		compare
			(
				Confirm_Vector_Seg8[0], 
				Confirm_Vector_Seg8[1], 
				Confirm_Vector_Seg8[2], 
				Confirm_Vector_Seg8[3], 
				Confirm_Vector_Seg8[4], 
				Confirm_Vector_Seg8[5], 
				Confirm_Vector_Seg8[6], 
				Confirm_Vector_Seg8[7], 
				Confirm_Vector_Seg8[8], 
				Confirm_Vector_Seg8[9], 
				Confirm_Vector_Seg8[10],
				Confirm_Vector_Seg8[11],
				Confirm_Vector_Seg8[12],
				
				Expected_ID_Seg8
			);	
		
		// -- Compare Seg 9
		@(negedge clk);
		$display("--------------------------------------- Rule ID of KEY 9 ---------------------------------------");
		compare
			(
				Confirm_Vector_Seg9[0], 
				Confirm_Vector_Seg9[1], 
				Confirm_Vector_Seg9[2], 
				Confirm_Vector_Seg9[3], 
				Confirm_Vector_Seg9[4], 
				Confirm_Vector_Seg9[5], 
				Confirm_Vector_Seg9[6], 
				Confirm_Vector_Seg9[7], 
				Confirm_Vector_Seg9[8], 
				Confirm_Vector_Seg9[9], 
				Confirm_Vector_Seg9[10],
				Confirm_Vector_Seg9[11],
				Confirm_Vector_Seg9[12],
				
				Expected_ID_Seg9
			);	
		
		// -- Compare Seg 10
		@(negedge clk);
		$display("--------------------------------------- Rule ID of KEY 10 ---------------------------------------");
		compare
			(
				Confirm_Vector_Seg10[0], 
				Confirm_Vector_Seg10[1], 
				Confirm_Vector_Seg10[2], 
				Confirm_Vector_Seg10[3], 
				Confirm_Vector_Seg10[4], 
				Confirm_Vector_Seg10[5], 
				Confirm_Vector_Seg10[6], 
				Confirm_Vector_Seg10[7], 
				Confirm_Vector_Seg10[8], 
				Confirm_Vector_Seg10[9], 
				Confirm_Vector_Seg10[10],
				Confirm_Vector_Seg10[11],
				Confirm_Vector_Seg10[12],
				
				Expected_ID_Seg10
			);	
			
		@(negedge clk);
		$finish;
	end 

// ==========================================================================
// == Tasks & Functions
// ==========================================================================
	task compare;
		input [CFWID-1:0] confirm1;
		input [CFWID-1:0] confirm2;
		input [CFWID-1:0] confirm3;
		input [CFWID-1:0] confirm4;
		input [CFWID-1:0] confirm5;
		input [CFWID-1:0] confirm6;
		input [CFWID-1:0] confirm7;
		input [CFWID-1:0] confirm8;
		input [CFWID-1:0] confirm9;
		input [CFWID-1:0] confirm10;
		input [CFWID-1:0] confirm11;
		input [CFWID-1:0] confirm12;
		input [CFWID-1:0] confirm13;
		input [IDWID-1:0] expected;
		// -- process 
		begin	
			i_Confirm_Result1 = confirm1;
			i_Confirm_Result2 = confirm2;
			i_Confirm_Result3 = confirm3;
			i_Confirm_Result4 = confirm4;
			i_Confirm_Result5 = confirm5;
			i_Confirm_Result6 = confirm6;
			i_Confirm_Result7 = confirm7;
			i_Confirm_Result8 = confirm8;
			i_Confirm_Result9 = confirm9;
			i_Confirm_Result10 = confirm10;
			i_Confirm_Result11 = confirm11;
			i_Confirm_Result12 = confirm12;
			i_Confirm_Result13 = confirm13;
			
			repeat (5) @(negedge clk);
			
			if (o_ruleid == expected)	$display("%t : Correct ID", $time);
			else						$display("%t : gnerated 0x%04x - expected 0x%04x", $time, o_ruleid, expected);			
		end 
	endtask 
endmodule