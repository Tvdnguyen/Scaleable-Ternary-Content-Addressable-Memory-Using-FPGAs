module tb_segvectmem;
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
	
	wire [VTWID-1:0]  rdo;
	reg  [KWID-1:0]   ra;
	reg  [VTWID-1:0] wdi;		// set of rule (not just rule)
	reg  [KWID-1:0]   wa;
	reg we;

// ==========================================================================
// == Signal Declarations
// ==========================================================================
	reg [KWID-1:0] key [9:0];
	reg [VTWID-1:0] rule [9:0];
	
	integer i;
// ==========================================================================
// == Component Instatiation : Device Under Test (DUT)
// ==========================================================================
	segvectmemx isegvectmemx 
		(
			clk, 
			rst, 
			rdo, 
			ra, 
			wdi, 
			wa, 
			we
		);

// ==========================================================================
// == Architecture of Testbench
// ==========================================================================
	// Data table
	initial
	begin
		// key initialization
		key[0] = 104'h40_5B_6A_00_A4_68_00_00_FF_FF_FF_FF_FF;	// key at address (rule) R1
		key[1] = 104'h40_5B_6B_3A_40_5B_6C_00_FF_FF_FF_FF_FF;	// key at address (rule) R2
		key[2] = 104'h40_5B_6B_3C_FB_E2_E9_00_FF_FF_FF_FF_FF;	// key at address (rule) R3
		key[3] = 104'hC0_97_0B_00_00_00_00_00_FF_FF_FF_FF_FF;	// key at address (rule) R4
		key[4] = 104'hC0_97_0B_7F_D0_B8_BC_27_FF_FF_FF_FF_FF;	// key at address (rule) R5
		key[5] = 104'h5F_69_8F_26_0F_00_00_00_FF_FF_FF_FF_FF;	// key at address (rule) R6
		key[6] = 104'h5F_69_8F_38_AF_55_44_F5_FF_FF_FF_FF_FF;	// key at address (rule) R7
		key[7] = 104'h40_5B_6A_00_88_00_00_00_FF_FF_FF_FF_FF;	// key at address (rule) R8
		key[8] = 104'hC0_97_0B_36_00_00_00_00_FF_FF_FF_FF_FF;	// key at address (rule) R9
		key[9] = 104'hC0_97_0B_29_0F_00_78_04_FF_FF_FF_FF_FF;	// key at address (rule) R10
	
		// rule initialization
		rule[0] = 130'h100_100_100_100_100_100_100_100_100_100_100_100_100;	// rule R1
		rule[1] = 130'h101_101_101_101_101_101_101_101_101_101_101_101_101;	// rule R2
		rule[2] = 130'h102_102_102_102_102_102_102_102_102_102_102_102_102;	// rule R3
		rule[3] = 130'h103_103_103_103_103_103_103_103_103_103_103_103_103;	// rule R4
		rule[4] = 130'h104_104_104_104_104_104_104_104_104_104_104_104_104;	// rule R5
		rule[5] = 130'h105_105_105_105_105_105_105_105_105_105_105_105_105;	// rule R6
		rule[6] = 130'h106_106_106_106_106_106_106_106_106_106_106_106_106;	// rule R7
		rule[7] = 130'h107_107_107_107_107_107_107_107_107_107_107_107_107;	// rule R8
		rule[8] = 130'h108_108_108_108_108_108_108_108_108_108_108_108_108;	// rule R9
		rule[9] = 130'h109_109_109_109_109_109_109_109_109_109_109_109_109;	// rule R10
	end
	
	// -- Generate Clock
	always #10 clk = ~clk;
	
	initial
	begin
		{clk, rst, ra, wdi, wa, we} <= 0;
		
		@(negedge clk);
		
		// Setting rules
		for (i = 0; i < 2**AWID; i = i + 1) begin
			we <= 1'b1;	
			ra <= key[i];
			wa <= key[i];
			wdi <= rule[i];
			
			#(20);		// delay 2 clock cycles each time
		end
		
		repeat (1) @(posedge clk);		// delays 1 cycles 
		
		// Searching rules
		for (i = 0; i < DEP; i = i + 1) begin
			we <= 1'b0;
			ra <= key[i];
			wa <= key[i];
			
			#(20);		// delay 2 clock cycles each time
		end
	end

// ==========================================================================
// == Tasks & Functions
// ==========================================================================
	task check_result;
		input [VTWID-1:0] Written_Rule;
		input [VTWID-1:0] Expected_Rule;
		begin
			if (Generated_ID != Expected_ID) 
				$display("%t : expected 0x%04x, generated 0x%04x", $time, Written_Rule, Expected_Rule);
			else 
				$display("%t : correct ID", $time);
		end 
	endtask
endmodule