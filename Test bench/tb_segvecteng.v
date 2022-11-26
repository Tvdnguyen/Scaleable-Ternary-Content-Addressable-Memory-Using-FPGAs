module tb_segvecteng();
// ==========================================================================
// == Parameters
// ==========================================================================
	parameter KWID 	 = 104; // Key width
	parameter IDWID	 = 8;  // Data bits
	parameter SEGWID = IDWID+2; // Segment width + status bit - 4 bits (user predefined)
	parameter VTWID  = SEGWID*(KWID/IDWID); //segmem width
	parameter MASKWID = 13;
	
// ==========================================================================
// == Local Parameters
// ==========================================================================
	localparam AWID = 8;
	localparam DEP = 1 << AWID; 
	localparam N = 10;
	
// ==========================================================================
// == Port Declarations
// ==========================================================================
	reg clk;
	reg rst;
	
	// for searching purpose
	reg [KWID-1:0] i_Key;		
	wire [VTWID-1:0] o_Segment_Vector;		
	
	wire [MASKWID-1:0]	o_Mask_Data1;
	wire [MASKWID-1:0]	o_Mask_Data2;
	wire [MASKWID-1:0]	o_Mask_Data3;
	wire [MASKWID-1:0]	o_Mask_Data4;
	wire [MASKWID-1:0]	o_Mask_Data5;
	wire [MASKWID-1:0]	o_Mask_Data6;
	wire [MASKWID-1:0]	o_Mask_Data7;
	wire [MASKWID-1:0]	o_Mask_Data8;
	wire [MASKWID-1:0]	o_Mask_Data9;
	wire [MASKWID-1:0]	o_Mask_Data10;
	wire [MASKWID-1:0]	o_Mask_Data11;
	wire [MASKWID-1:0]	o_Mask_Data12;
	wire [MASKWID-1:0]	o_Mask_Data13;
	
	// for setting purpose
	reg [KWID+MASKWID-1:0] i_Set_Data;  
	reg [IDWID-1:0] i_Set_ID;	
	reg i_Set_Segment_Enable;	
	
// ==========================================================================
// == Component Instatiation : Device Under Test (DUT)
// ==========================================================================
	segvecteng 	Segment_Vector_Engine_Inst
		(
			.clk(clk),
			.rst(rst),
			
			// for searching 
			.i_Key(i_Key),			// input data
			.o_Segment_Vector(o_Segment_Vector),	// output 
			
			.o_Mask_Data1(o_Mask_Data1),
			.o_Mask_Data2(o_Mask_Data2),
			.o_Mask_Data3(o_Mask_Data3),
			.o_Mask_Data4(o_Mask_Data4),
			.o_Mask_Data5(o_Mask_Data5),
			.o_Mask_Data6(o_Mask_Data6),
			.o_Mask_Data7(o_Mask_Data7),
			.o_Mask_Data8(o_Mask_Data8),
			.o_Mask_Data9(o_Mask_Data9),
			.o_Mask_Data10(o_Mask_Data10),
			.o_Mask_Data11(o_Mask_Data11),
			.o_Mask_Data12(o_Mask_Data12),
			.o_Mask_Data13(o_Mask_Data13),
			
			// for setting
			.i_Set_Data(i_Set_Data),
			.i_Set_ID(i_Set_ID),
			.i_Set_Segment_Enable(i_Set_Segment_Enable)
		);
		
// ==========================================================================
// == Architecture of Test Bench
// ==========================================================================
	reg [KWID+MASKWID-1:0] key_arr [9:0];
	reg [IDWID-1:0] rule_arr [9:0];
	reg [VTWID-1:0] Expected_Vector [9:0];
	integer i;	
// ==========================================================================
// == Architecture of Test Bench
// ==========================================================================
	initial
	begin	
		// key initialization
		key_arr[0] = {13'b0001001100000, 104'h40_5B_6A_00_A8_68_00_00_FF_FF_FF_FF_FF};	// key at address (rule) R1
		key_arr[1] = {13'b0000000100000, 104'h40_5B_6B_3A_40_5B_6C_00_FF_FF_FF_FF_FF};	// key at address (rule) R2
		key_arr[2] = {13'b0000000100000, 104'h40_5B_6B_3C_FB_E2_E9_00_FF_FF_FF_FF_FF};	// key at address (rule) R3
		key_arr[3] = {13'b0001011100000, 104'hC0_97_0B_00_00_00_00_00_FF_FF_FF_FF_FF};	// key at address (rule) R4
		key_arr[4] = {13'b0000000000000, 104'hC0_97_0B_7F_D0_B8_BC_27_FF_FF_FF_FF_FF};	// key at address (rule) R5
		key_arr[5] = {13'b0000011100000, 104'h5F_69_8F_26_0F_00_00_00_FF_FF_FF_FF_FF};	// key at address (rule) R6
		key_arr[6] = {13'b0000000000000, 104'h5F_69_8F_38_AF_55_44_F5_FF_FF_FF_FF_FF};	// key at address (rule) R7
		key_arr[7] = {13'b0001011100000, 104'h40_5B_6A_00_88_00_00_00_FF_FF_FF_FF_FF};	// key at address (rule) R8
		key_arr[8] = {13'b0000011100000, 104'hC0_97_0B_36_00_00_00_00_FF_FF_FF_FF_FF};	// key at address (rule) R9
		key_arr[9] = {13'b0000000000000, 104'hC0_97_0B_29_0F_00_78_04_FF_FF_FF_FF_FF};	// key at address (rule) R10
	
		// rule initialization
		rule_arr[0] = 8'h00;	// rule R1
		rule_arr[1] = 8'h01;	// rule R2
		rule_arr[2] = 8'h02;	// rule R3
		rule_arr[3] = 8'h03;	// rule R4
		rule_arr[4] = 8'h04;	// rule R5
		rule_arr[5] = 8'h05;	// rule R6
		rule_arr[6] = 8'h06;	// rule R7
		rule_arr[7] = 8'h07;	// rule R8
		rule_arr[8] = 8'h08;	// rule R9
		rule_arr[9] = 8'h09;	// rule R10
		
		// expected vector
		Expected_Vector[0] = {{2'b11,8'h00}, {2'b11,8'h00}, {2'b11,8'h00}, {2'b11,8'h00}, {2'b01,8'h00}, {2'b01,8'h00}, {2'b11,8'h00}, {2'b11,8'h00}, {5{2'b11,8'h00}}};
		Expected_Vector[1] = {{2'b11,8'h00}, {2'b11,8'h00}, {2'b11,8'h01}, {2'b01,8'h01}, {2'b01,8'h01}, {2'b01,8'h01}, {2'b01,8'h01}, {2'b11,8'h00}, {5{2'b11,8'h00}}};
		Expected_Vector[2] = {{2'b11,8'h00}, {2'b11,8'h00}, {2'b11,8'h01}, {2'b01,8'h02}, {2'b01,8'h02}, {2'b01,8'h02}, {2'b01,8'h02}, {2'b11,8'h00}, {5{2'b11,8'h00}}};
		Expected_Vector[3] = {{2'b11,8'h03}, {2'b11,8'h03}, {2'b11,8'h03}, {2'b11,8'h00}, {2'b11,8'h03}, {2'b11,8'h03}, {2'b11,8'h00}, {2'b11,8'h00}, {5{2'b11,8'h00}}};
		Expected_Vector[4] = {{2'b11,8'h03}, {2'b11,8'h03}, {2'b11,8'h03}, {2'b01,8'h04}, {2'b01,8'h04}, {2'b01,8'h04}, {2'b01,8'h04}, {2'b01,8'h04}, {5{2'b11,8'h00}}};
		Expected_Vector[5] = {{2'b11,8'h05}, {2'b11,8'h05}, {2'b11,8'h05}, {2'b01,8'h05}, {2'b11,8'h05}, {2'b11,8'h03}, {2'b11,8'h00}, {2'b11,8'h00}, {5{2'b11,8'h00}}};
		Expected_Vector[6] = {{2'b11,8'h05}, {2'b11,8'h05}, {2'b11,8'h05}, {2'b01,8'h06}, {2'b01,8'h06}, {2'b01,8'h06}, {2'b01,8'h06}, {2'b01,8'h06}, {5{2'b11,8'h00}}};
		Expected_Vector[7] = {{2'b11,8'h00}, {2'b11,8'h00}, {2'b11,8'h00}, {2'b11,8'h00}, {2'b01,8'h07}, {2'b11,8'h03}, {2'b11,8'h00}, {2'b11,8'h00}, {5{2'b11,8'h00}}};
		Expected_Vector[8] = {{2'b11,8'h03}, {2'b11,8'h03}, {2'b11,8'h03}, {2'b01,8'h08}, {2'b11,8'h03}, {2'b11,8'h03}, {2'b11,8'h00}, {2'b11,8'h00}, {5{2'b11,8'h00}}};
		Expected_Vector[9] = {{2'b11,8'h03}, {2'b11,8'h03}, {2'b11,8'h03}, {2'b01,8'h09}, {2'b11,8'h05}, {2'b11,8'h03}, {2'b01,8'h09}, {2'b01,8'h09}, {5{2'b11,8'h00}}};
	end
	
	always #10 clk = ~clk;
	
	initial
	begin
		clk = 0;
		
		@(negedge clk);
		
		// -- power up reset & deactivate the reset
		rst = 1;		
		repeat (2) @(negedge clk);		
		rst = 0;
		
		// -- Setting rules
		for (i = 0; i < N; i = i + 1)
			set_rule(key_arr[i], rule_arr[i]);
		
		// searching rule phase 
		for (i = 0; i < N; i = i + 1)
			search_rule(key_arr[i], Expected_Vector[i]);
	end

// ==========================================================================
// == Tasks & Functions
// ==========================================================================
	task set_rule;
		input [KWID+MASKWID-1:0] key;
		input [IDWID-1:0] rule;
		begin		
			repeat (2) @(negedge clk) 
			begin 
				i_Set_Segment_Enable = 1'b1;
				i_Set_Data = key;
				i_Set_ID = rule;
			end 
			
			i_Set_Segment_Enable = 1'b0;	
		end 
	endtask
	
	task search_rule;
		input [KWID-1:0] key;
		input [VTWID-1:0] expected;
		begin
			i_Set_Segment_Enable = 0;
			i_Key = key;
			
			@(negedge clk);
			
			// -- Check if the read data correspond to the expected
			// -- and print a message if not
			if (o_Segment_Vector != expected) 
				$display("%t : expected 0x%x, generated 0x%x", $time, expected, o_Segment_Vector);
			else 
				$display("%t : correct ID", $time);
		end 
	endtask
endmodule	// tb_segvecteng