module confirmmem
	(
		clk,
		rst,
		
		// for searching purpose
		i_Key,
		i_Compare_Result,
		
		o_Confirm_Result,
		
		// for setting purpose
		i_Set_ID,	// ID for Confirmation
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

// ============================================================================
// == Port declarations
// ============================================================================
	input clk;
	input rst;
	
	// for searching purpose
	input [KWID-1:0] 	i_Key;
	input [SEGWID-1:0]	i_Compare_Result;
	
	output [CFWID-1:0]	o_Confirm_Result;
	
	// for setting purpose
	input [IDWID-1:0] 		i_Set_ID;
	input [TOTALWID-1:0] 	i_Set_String;
	input 					i_Set_Enable;

// ============================================================================
// == Signal Declarations and Delays
// ============================================================================	
	// ===================================================
	// == Component Instantiations : RAM Instantiation
	
	wire [TOTALWID-1:0] Confirm_Data;  // data from Confirmation RAM (SET BEFORE)
	
	// ram2port 	Confirm_RAM
	// 	(
	// 		.clock			(clk),
	// 		
	// 		// Confirm
	// 		.rdaddress		(i_Compare_Result[7:0]),
	// 		.q					(Confirm_Data),
	// 		
	// 		// Setting 
	// 		.wraddress		(i_Set_ID),
	// 		.data				(i_Set_Key),
	// 		.wren				(i_Set_Enable)	
	// 	);

	alram1x #(TOTALWID, AWID) iconram (
			.clk(clk),
			.rst(rst),
			
			// for confirmation
			.rdo(Confirm_Data),	 	// Data to Confirm
			.ra(i_Compare_Result[7:0]),	// rule as input
		
			// for setting
			.wa(i_Set_ID),
			.wdi(i_Set_String),
			.we(i_Set_Enable)
		);
	
	wire Confirm1;
	wire Confirm2;
	wire Confirm3;
	wire Confirm4;
	wire Confirm5;
	wire Confirm6;
	wire Confirm7;
	wire Confirm8;
	wire Confirm9;
	wire Confirm10;
	wire Confirm11;
	wire Confirm12;
	wire Confirm13;
	
	
	// =============================================
	// == Data Flow
	// == compare setted data with key input 
	// == Confirm_Data[14 : 10] means 5 bit mask 
	// =============================================
	// == compareconfirm_x <= key[1:0] == Confirm_Data[1:0]	when ( 8 bits are BINARY -> Need to be compared )
	// == 				      
	// =============================================
	assign Confirm1		=  Confirm_Data[104] ? 1'b1 : (i_Key[7:0]   == Confirm_Data[7:0]);
	assign Confirm2 	=  Confirm_Data[105] ? 1'b1 : (i_Key[15:8]  == Confirm_Data[15:8]);
	assign Confirm3  	=  Confirm_Data[106] ? 1'b1 : (i_Key[23:16] == Confirm_Data[23:16]);
	assign Confirm4  	=  Confirm_Data[107] ? 1'b1 : (i_Key[31:24] == Confirm_Data[31:24]);
	assign Confirm5  	=  Confirm_Data[108] ? 1'b1 : (i_Key[39:32] == Confirm_Data[39:32]);
	assign Confirm6  	=  Confirm_Data[109] ? 1'b1 : (i_Key[47:40] == Confirm_Data[47:40]);
	assign Confirm7  	=  Confirm_Data[110] ? 1'b1 : (i_Key[55:48] == Confirm_Data[55:48]);
	assign Confirm8  	=  Confirm_Data[111] ? 1'b1 : (i_Key[63:56] == Confirm_Data[63:56]);
	assign Confirm9  	=  Confirm_Data[112] ? 1'b1 : (i_Key[71:64] == Confirm_Data[71:64]);
	assign Confirm10  	=  Confirm_Data[113] ? 1'b1 : (i_Key[79:72] == Confirm_Data[79:72]);
	assign Confirm11  	=  Confirm_Data[114] ? 1'b1 : (i_Key[87:80] == Confirm_Data[87:80]);
	assign Confirm12  	=  Confirm_Data[115] ? 1'b1 : (i_Key[95:88] == Confirm_Data[95:88]);
	assign Confirm13  	=  Confirm_Data[116] ? 1'b1 : (i_Key[103:96] == Confirm_Data[103:96]);
	
	// -- Valid bits
	wire Valid;
	assign Valid = (i_Compare_Result[9:8] == 2'b11) ? 1'b0 : 1'b1;
	
	// -- Priority
	wire [7:0] Priority;
	assign Priority = Confirm_Data[124:117];
	
	// =======================================================================================
	// == if both 104-bit strings are identical ==> compareconfirm == 1 which means MATCH.
	wire [12:0] Match;
	assign Match = { Confirm1, Confirm2, Confirm3, Confirm4, Confirm5, Confirm6,
					 Confirm7,Confirm8,Confirm9, Confirm10, Confirm11, Confirm12, Confirm13 };
	
	// =====================================================
	// == Pipeline for ID
	reg [16:0] Segment_reg;	// 8-bit Priority + 1-bit Valid + 8-bit ID
	
	always@(posedge clk)
	begin
		if (rst) begin
			Segment_reg <= {17{1'b0}};
		end
		
		Segment_reg <= {Priority, Valid, i_Compare_Result[7:0]};		// Match_reg
	end
	
	// =====================================================
	// == Pipeline for Result
	reg [29:0] Result_reg1;	// output
	
	always@(posedge clk)
	begin
		if (rst) begin
			Result_reg1 <= {30{1'b0}};
		end
		
		Result_reg1 <= {Segment_reg[16:8], Match, Segment_reg[7:0]};		// Match_reg
	end
	
	wire Match_Signal1;
	assign Match_Signal1 = (&Result_reg1[12:8]); 
	
	wire Match_Signal2;
	assign Match_Signal2 = (&Result_reg1[17:13]);
	
	wire Match_Signal3;
	assign Match_Signal3 = (&Result_reg1[20:18]);
	
	// =====================================================
	// == Pipeline for Result
	reg [19:0] Result_reg2;	// output
	
	always@(posedge clk)
	begin
		if (rst) begin
			Result_reg2 <= {20{1'b0}};
		end
		
		Result_reg2 <= {Result_reg1[29:21], Match_Signal1, Match_Signal2, Match_Signal3, Result_reg1[7:0]};		// Match_reg
	end
	
	wire Match_Final;
	assign Match_Final = (Result_reg2[11]) ? (&Result_reg2[10:8]) : 1'b0;
	
	// =====================================================
	// == Result Register
	
	reg [CFWID-1:0] Confirm_Result;	// output
	
	always@(posedge clk)
	begin
		if (rst) begin
			Confirm_Result <= {CFWID{1'b0}};
		end
		
		Confirm_Result <= {Match_Final, Result_reg2[7:0], Result_reg2[19:12]};		// rule
	end
	
	// == Output Assignment
	assign o_Confirm_Result = Confirm_Result;

endmodule 