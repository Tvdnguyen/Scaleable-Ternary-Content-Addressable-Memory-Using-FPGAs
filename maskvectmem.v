module maskvectmem
	(
		clk,
		rst,
		
		// for searching purpose
		i_Segment,		
		i_Segment_Vector,
		i_Mask_Data,
		
		o_Mask_Vect	
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

// ==========================================================================
// == Port Declarations
// ==========================================================================
	input clk;
	input rst;
	
	// for searching purpose 
	input [SEGWID-1:0]	i_Segment; // segment 
	input [VTWID-1:0] 	i_Segment_Vector;	 // segment vector
	input [MASKWID-1:0]	i_Mask_Data;
	
	output [VTWID-1:0]	o_Mask_Vect;	 // output
	
// ==========================================================================
// == Architecture
// ==========================================================================
	// ======================================================================
	// == Input Register 
	// ======================================================================
	reg [MASKWID-1:0]	Mask_Data;
	reg [VTWID-1:0] 	Segment_Vector;
	
	always @(posedge clk)
	begin 
		if (rst) begin
			Mask_Data <= 13'b0;
			Segment_Vector <= 130'b0;
		end 
		else begin
			Mask_Data <= i_Mask_Data;
			Segment_Vector <= i_Segment_Vector;
		end 
	end 
	
	
	// ======================================================================
	// == Component Instatiation
	// ======================================================================
	wire Seg_is_Invalid; //invalid segment to mask meaning col emp or masked 	// segment-is-invalid variable	
	assign Seg_is_Invalid = (i_Segment[9:8] != 2'b01); // invalid -> status == 2'b11
 	
	wire Seg_is_Invalid2;
	ffxkclkx #(1, 1) pp_seg_is_invalid (clk, rst, Seg_is_Invalid, Seg_is_Invalid2);
	// ======================================================================
	// == Combinational Logic 
	// ======================================================================
	wire [MASKWID-1:0] Mask_Data_Check; //check for invalid
	
	assign Mask_Data_Check = Seg_is_Invalid2? 13'b1111111111111 : Mask_Data;	// mask data check 
	
	// == mask vector 1
	assign o_Mask_Vect[7:0]	= (!Mask_Data_Check[0] | Mask_Data_Check[0]) ?  Segment_Vector[7:0] : 8'bxx;
	assign o_Mask_Vect[9:8]	= (Mask_Data_Check[0]) ? 2'b11 	: 
							  (!Mask_Data_Check[0]) ? Segment_Vector[9:8] : 2'bxx;
	
	// == mask vector 2
	assign o_Mask_Vect[17:10]	= (!Mask_Data_Check[1] | Mask_Data_Check[1]) ? Segment_Vector[17:10] : 8'bxx;
	assign o_Mask_Vect[19:18]	= (Mask_Data_Check[1]) ? 2'b11 	: 
								  (!Mask_Data_Check[1]) ? Segment_Vector[19:18] : 2'bxx;
	
	// == mask vector 3
	assign o_Mask_Vect[27:20]	= (!Mask_Data_Check[2] | Mask_Data_Check[2]) ? Segment_Vector[27:20] : 8'bxx;
	assign o_Mask_Vect[29:28]	= (Mask_Data_Check[2]) ? 2'b11 	: 
								  (!Mask_Data_Check[2]) ? Segment_Vector[29:28] : 2'bxx;
	
	// == mask vector 4
	assign o_Mask_Vect[37:30]	= (!Mask_Data_Check[3] | Mask_Data_Check[3]) ? Segment_Vector[37:30] : 8'bxx;
	assign o_Mask_Vect[39:38]	= (Mask_Data_Check[3]) ? 2'b11 : 
								  (!Mask_Data_Check[3]) ? Segment_Vector[39:38] : 2'bxx;
	
	// == mask vector 5
	assign o_Mask_Vect[47:40]	= (!Mask_Data_Check[4] | Mask_Data_Check[4]) ? Segment_Vector[47:40] : 8'bxx;
	assign o_Mask_Vect[49:48]	= (Mask_Data_Check[4]) ? 2'b11 : 
								  (!Mask_Data_Check[4]) ? Segment_Vector[49:48] : 2'bxx;
								  
	// == mask vector 6
	assign o_Mask_Vect[57:50]	= (!Mask_Data_Check[5] | Mask_Data_Check[5]) ? Segment_Vector[57:50] : 8'bxx;
	assign o_Mask_Vect[59:58]	= (Mask_Data_Check[5]) ? 2'b11 : 
								  (!Mask_Data_Check[5]) ? Segment_Vector[59:58] : 2'bxx;
								  
	// == mask vector 7
	assign o_Mask_Vect[67:60]	= (!Mask_Data_Check[6] | Mask_Data_Check[6]) ? Segment_Vector[67:60] : 8'bxx;
	assign o_Mask_Vect[69:68]	= (Mask_Data_Check[6]) ? 2'b11 : 
								  (!Mask_Data_Check[6]) ? Segment_Vector[69:68] : 2'bxx;
									
	// == mask vector 8
	assign o_Mask_Vect[77:70]	= (!Mask_Data_Check[7] | Mask_Data_Check[5]) ? Segment_Vector[77:70] : 8'bxx;
	assign o_Mask_Vect[79:78]	= (Mask_Data_Check[7]) ? 2'b11 : 
								  (!Mask_Data_Check[7]) ? Segment_Vector[79:78] : 2'bxx;	

	// == mask vector 9
	assign o_Mask_Vect[87:80]	= (!Mask_Data_Check[8] | Mask_Data_Check[8]) ? Segment_Vector[87:80] : 8'bxx;
	assign o_Mask_Vect[89:88]	= (Mask_Data_Check[8]) ? 2'b11 : 
								  (!Mask_Data_Check[8]) ? Segment_Vector[89:88] : 2'bxx;
								  
	// == mask vector 10
	assign o_Mask_Vect[97:90]	= (!Mask_Data_Check[9] | Mask_Data_Check[9]) ? Segment_Vector[97:90] : 8'bxx;
	assign o_Mask_Vect[99:98]	= (Mask_Data_Check[9]) ? 2'b11 : 
								  (!Mask_Data_Check[9]) ? Segment_Vector[99:98] : 2'bxx;
								  
	// == mask vector 11
	assign o_Mask_Vect[107:100]	= (!Mask_Data_Check[10] | Mask_Data_Check[10]) ? Segment_Vector[107:100] : 8'bxx;
	assign o_Mask_Vect[109:108]	= (Mask_Data_Check[10]) ? 2'b11 : 
								  (!Mask_Data_Check[10]) ? Segment_Vector[109:108] : 2'bxx;
	
	// == mask vector 12
	assign o_Mask_Vect[117:110]	= (!Mask_Data_Check[11] | Mask_Data_Check[11]) ? Segment_Vector[117:110] : 8'bxx;
	assign o_Mask_Vect[119:118]	= (Mask_Data_Check[11]) ? 2'b11 : 
								  (!Mask_Data_Check[11]) ? Segment_Vector[119:118] : 2'bxx;
								  
	// == mask vector 13
	assign o_Mask_Vect[127:120]	= (!Mask_Data_Check[12] | Mask_Data_Check[12]) ? Segment_Vector[127:120] : 8'bxx;
	assign o_Mask_Vect[129:128]	= (Mask_Data_Check[12]) ? 2'b11 : 
								  (!Mask_Data_Check[12]) ? Segment_Vector[129:128] : 2'bxx;
endmodule