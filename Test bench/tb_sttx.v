module tb_sttx;
// ==========================================================================
// == Parameters
// ==========================================================================
	parameter KWID 	 = 104; // Key width
	parameter DWID	 = 8;  // Data bits
	parameter SEGWID = DWID+2; // Segment width + status bit - 4 bits (user predefined)
	parameter VTWID  = SEGWID*(KWID/DWID); //segmem width

// ==========================================================================
// == Local Parameters
// ==========================================================================
	localparam AWID = 8;
	localparam DEP = 1 << AWID; 

// ==========================================================================
// == Port Declarations
// ==========================================================================
	reg clk;
	reg rst;
	
	reg	[VTWID-1:0] i_SET_ID;
	reg 			i_Status_En;
	reg	[VTWID-1:0] i_RAM_Data;	
	
	wire [VTWID-1:0]	o_SETID_MOD;
	wire 				o_Done;

// ==========================================================================
// == Component Instatiation : Device Under Test (DUT)
// ==========================================================================
	Status_Engine_FSM 	DUT
		(
			.clk(clk),
			.rst(rst),
			
			// input(s)
			.i_SET_ID(i_SET_ID),
			.i_Status_En(i_Status_En),
			.i_RAM_Data(i_RAM_Data),	
			
			// output(s)
			.o_SETID_MOD(o_SETID_MOD),
			.o_Done(o_Done)
		);

// ==========================================================================
// == Signal Declarations
// ==========================================================================
	reg [VTWID-1:0] ID [12:0];
	reg [VTWID-1:0] RAM_DATA [12:0];
	
	// -- loop index
	integer i;
	
// ==========================================================================
// == Architecture of Testbench
// ==========================================================================
	initial
	begin
		// ID for input
		ID[0] = 130'b
		ID[1] = 130'b
		ID[2] = 130'b
		ID[3] = 130'b
		ID[4] = 130'b
		ID[5] = 130'b
		ID[6] = 130'b
		ID[7] = 130'b
		ID[8] = 130'b
		ID[9] = 130'b
		ID[10] = 130'b
		ID[11] = 130'b
		ID[12] = 130'b
		
		// Data in RAM 
		RAM_DATA[0] = 130'b
		RAM_DATA[1] = 130'b
		RAM_DATA[2] = 130'b
		RAM_DATA[3] = 130'b
		RAM_DATA[4] = 130'b
		RAM_DATA[5] = 130'b
		RAM_DATA[6] = 130'b
		RAM_DATA[7] = 130'b
		RAM_DATA[8] = 130'b
		RAM_DATA[9] = 130'b
		RAM_DATA[10] = 130'b
		RAM_DATA[11] = 130'b
		RAM_DATA[12] = 130'b
	end
	
	// -- Generate clock
	always #10 clk = ~clk;
	
	initial
	begin
		clk = 0;
		
		// -- write into Status Engine 
		for (i = 0; i < DEP; i = i + 1) 
			generate_ID(ID[i], RAM_DATA[i]);
		
	
	end 
	
// ==========================================================================
// == Tasks & Functions
// ==========================================================================
	task generate_ID;
		input [VTWID-1:0] id; 
		input [VTWID-1:0] rdat;
		begin
			i_Status_En = 1'b1;
			i_SET_ID = id;
			i_RAM_Data = rdat;
			
			@(negedge clk);
			
			i_Status_En = 1'b0;
		end 
	endtask
	
	task check_result;
		input [VTWID-1:0] Generated_ID;
		input [VTWID-1:0] Expected_ID;
		begin
			if (Generated_ID != Expected_ID) 
				$display("%t : expected 0x%04x, generated 0x%04x", $time, Generated_ID, Expected_ID);
			else 
				$display("%t : correct ID", $time);
		end 
	endtask
endmodule
	