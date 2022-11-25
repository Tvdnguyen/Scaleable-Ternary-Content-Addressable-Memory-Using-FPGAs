module compr_datapath 
	(
		// -- inputs 
		i_Segment1,
		i_Segment2,
		
		// -- outputs 
		o_Segment_Result
	);
	
// =============================================================================
// == Parameter declarations
// =============================================================================
	parameter SEGWID = 10; //Segment width IDwid+2stt
	parameter IDWID = 8;
	
// ============================================================================
// == Port declarations
// ============================================================================
	input [SEGWID-1:0]	i_Segment1;
	input [SEGWID-1:0]	i_Segment2;
	
	output [SEGWID-1:0]	o_Segment_Result;

// ============================================================================
// == Architecture
// ============================================================================
	// -- Address
	wire [IDWID-1:0] ADDR_1;
	assign ADDR_1 = i_Segment1[7:0];
	
	wire [IDWID-1:0] ADDR_2;
	assign ADDR_2 = i_Segment2[7:0];
	
	// -- Check Valid
	wire SEGMENT_1_VALID;
	assign SEGMENT_1_VALID = (i_Segment1[9:8] == 2'b01);
	
	wire SEGMENT_2_VALID;	
	assign SEGMENT_2_VALID = (i_Segment2[9:8] == 2'b01);
	
	// -- Compare 
	// == ADDR_1 compare ADDR_2
	wire [1:0] Valid_Addr;
	assign Valid_Addr = (SEGMENT_2_VALID & SEGMENT_1_VALID) ? 2'b11 :
						(!SEGMENT_2_VALID & SEGMENT_1_VALID) ? 2'b01 :
						(SEGMENT_2_VALID & !SEGMENT_1_VALID) ? 2'b10 : 2'b00;
							
	wire Same_Addr;
	assign Same_Addr = (ADDR_1 == ADDR_2) ? 1'b1 : 1'b0;
	
	// -- Output Assignment
	assign o_Segment_Result[7:0] = ((Valid_Addr == 2'b11) & (Same_Addr == 1))	? ADDR_1 	:
									(Valid_Addr == 2'b01) 						? ADDR_1	:
									(Valid_Addr == 2'b10) 						? ADDR_2	:   8'b00;
									
	assign o_Segment_Result[9:8] = (Valid_Addr == 2'b00)	?	2'b00 :  2'b01;									
	
endmodule 