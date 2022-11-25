module Status_Engine
	(
		clk,
		rst,
		
		// input(s)
		i_SET_ID,
		i_Status_En,
		i_RAM_Data,
		i_Mask_Data,
		
		// output(s)
		o_SETID_MOD,
		o_Done
	);

// ==========================================================================
// == Parameters
// ==========================================================================
	parameter KWID 	 = 104; // Key width
	parameter IDWID	 = 8;  // Data bits
	parameter SEGWID = IDWID+2; // Segment width + status bit - 10 bits (user predefined)
	parameter MASKWID = KWID/8;	// 13
	parameter DATA = SEGWID+MASKWID; // 23
	
// ==========================================================================
// == Local Parameters
// ==========================================================================
	localparam IDLE	= 1'b0;
	localparam ST1	= 1'b1;
	
// ==========================================================================
// == Port Declarations
// ==========================================================================
	input clk;
	input rst;
	
	input	[IDWID-1:0]		i_SET_ID;
	input 					i_Status_En;
	input	[DATA-1:0]		i_RAM_Data;
	input 	[MASKWID-1:0]	i_Mask_Data;
	
	output  [DATA-1:0]		o_SETID_MOD;
	output 					o_Done;

// ==========================================================================
// == Signal Declaraions
// ==========================================================================	
	reg PS, NS;
	reg Done;
	
	reg [DATA-1:0] Mod_ID;

// ==========================================================================
// == Architecture: FSM
// ==========================================================================
	// ====================
	// -- Cell_Empty
	wire Cell_Empty;
	assign Cell_Empty = (i_RAM_Data[22:21] == 2'b00);

	// ====================
	// == Current State : Synchronous Process
	always @(posedge clk or posedge rst)	// -- Async Reset
	begin
		if 		 	(rst)					PS <= IDLE;
		else if 	(i_Status_En == 0)		PS <= IDLE;
		else 								PS <= NS;
	end 

	// == Next State Logic : Combinational Process
	always @(PS, i_RAM_Data, i_SET_ID) 
	begin
		case (PS)
			IDLE:
			begin
				Done <= 1'b0;
				Mod_ID <= {2'b01, i_SET_ID, i_Mask_Data};
				NS <= ST1;
			end
			
			ST1: 
			begin 
				Done <= 1'b1;
				NS <= IDLE;
				if (!Cell_Empty)	Mod_ID <= {2'b11, i_RAM_Data[20:0]};
				else 				Mod_ID <= {2'b01, i_SET_ID, i_Mask_Data};
			end
			
			default:
			begin 
				NS <= IDLE;
				Done <= 1'b0;
			end
		endcase
	end

// ==========================================================================
// == Output Assignments
// ==========================================================================
	assign o_SETID_MOD = Mod_ID;
	assign o_Done = Done;
endmodule 