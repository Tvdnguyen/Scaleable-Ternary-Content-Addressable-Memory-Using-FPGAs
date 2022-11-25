module segvecteng 
	(
		clk,
		rst,
		
		// for searching 
		i_Key,					// input data
		o_Segment_Vector,		// output 
		
		o_Mask_Data1,
		o_Mask_Data2,
		o_Mask_Data3,
		o_Mask_Data4,
		o_Mask_Data5,
		o_Mask_Data6,
		o_Mask_Data7,
		o_Mask_Data8,
		o_Mask_Data9,
		o_Mask_Data10,
		o_Mask_Data11,
		o_Mask_Data12,
		o_Mask_Data13,
		
		// for setting
		o_Set_Done,
		i_Set_Data,
		i_Set_ID,
		i_Set_Segment_Enable
	 );

// =============================================================================
// == Parameter declarations
// =============================================================================
	parameter KWID 	= 104; //Key width
	parameter SEGWID = 10; //Segment width IDwid+2stt
	parameter MASKWID = KWID/8; //13
	parameter DATA = SEGWID+MASKWID;
	parameter VTDAT = DATA*(KWID/8);
	parameter VTWID = SEGWID*(KWID/8); //segmem width
	parameter AWID = 8; //address width
	parameter IDWID = 8;
	
// =============================================================================
// == Port Declarations
// =============================================================================
	input clk;
	input rst;
	
	// for searching purpose
	input [KWID-1:0] 		i_Key;		
	output [VTWID-1:0] 		o_Segment_Vector;
	
	output [MASKWID-1:0]	o_Mask_Data1;
	output [MASKWID-1:0]	o_Mask_Data2;
	output [MASKWID-1:0]	o_Mask_Data3;
	output [MASKWID-1:0]	o_Mask_Data4;
	output [MASKWID-1:0]	o_Mask_Data5;
	output [MASKWID-1:0]	o_Mask_Data6;
	output [MASKWID-1:0]	o_Mask_Data7;
	output [MASKWID-1:0]	o_Mask_Data8;
	output [MASKWID-1:0]	o_Mask_Data9;
	output [MASKWID-1:0]	o_Mask_Data10;
	output [MASKWID-1:0]	o_Mask_Data11;
	output [MASKWID-1:0]	o_Mask_Data12;
	output [MASKWID-1:0]	o_Mask_Data13;

	// for setting purpose
	output 						o_Set_Done;
	input [KWID+MASKWID-1:0] 	i_Set_Data;  
	input [IDWID-1:0] 			i_Set_ID;	
	input 						i_Set_Segment_Enable;	

// =============================================================================
// == Signal Declarations
// =============================================================================
	wire [KWID-1:0] Set_Key;
	assign Set_Key = i_Set_Data[103:0];
	
	wire [MASKWID-1:0] Set_Mask;
	assign Set_Mask = i_Set_Data[116:104];
	
	wire [VTDAT-1:0] rdo;
	wire [KWID-1:0] ra;
	wire [VTDAT-1:0] wdi;
	wire [KWID-1:0] wa;
	wire we;
	
	wire Done1;
	wire Done2;
	wire Done3;
	wire Done4;
	wire Done5;
	wire Done6;
	wire Done7;
	wire Done8;
	wire Done9;
	wire Done10;
	wire Done11;
	wire Done12;
	wire Done13;
	
// =============================================================================
// == Assignments
// =============================================================================		 
	assign wa = we ? Set_Key : i_Key;		// MUX 2-to-1
	assign ra = i_Set_Segment_Enable ? Set_Key : i_Key;		// MUX 2-to-1
	
	assign we = Done1 &
	           Done2 & 
	           Done3 & 
	           Done4 & 
	           Done5 & 
	           Done6 & 
	           Done7 & 
	           Done8 & 
	           Done9 & 
	           Done10 & 
	           Done11 & 
	           Done12 & 
	           Done13; 	
	
// =========================================================
// == Component Instatiations
// =========================================================
	// o_Set_Done 
	ffxkclkx #(1, 1) pp_set_done (clk, rst, we, o_Set_Done);
	
	// connecting segvectmemx block
	segvectmem  Segvect_Memory_Inst(clk, rst, rdo, ra, wdi, wa, we);
	
	// connecting status engine 
	Status_Engine	Engine_Inst1
		(
			.clk(clk),
			.rst(rst),
			
			// input(s)
			.i_SET_ID(i_Set_ID),
			.i_Status_En(i_Set_Segment_Enable),
			.i_RAM_Data(rdo[22:0]),	
			.i_Mask_Data(Set_Mask),
			
			// output(s)
			.o_SETID_MOD(wdi[22:0]),
			.o_Done(Done1)
		);

	Status_Engine	Engine_Inst2
		(
			.clk(clk),
			.rst(rst),
			
			// input(s)
			.i_SET_ID(i_Set_ID),
			.i_Status_En(i_Set_Segment_Enable),
			.i_RAM_Data(rdo[45:23]),
			.i_Mask_Data(Set_Mask),			
			
			// output(s)
			.o_SETID_MOD(wdi[45:23]),
			.o_Done(Done2)
		);
	
	Status_Engine	Engine_Inst3
		(
			.clk(clk),
			.rst(rst),
			
			// input(s)
			.i_SET_ID(i_Set_ID),
			.i_Status_En(i_Set_Segment_Enable),
			.i_RAM_Data(rdo[68:46]),
			.i_Mask_Data(Set_Mask),
			
			// output(s)
			.o_SETID_MOD(wdi[68:46]),
			.o_Done(Done3)
		);
		
	Status_Engine	Engine_Inst4
		(
			.clk(clk),
			.rst(rst),
			
			// input(s)
			.i_SET_ID(i_Set_ID),
			.i_Status_En(i_Set_Segment_Enable),
			.i_RAM_Data(rdo[91:69]),
			.i_Mask_Data(Set_Mask),
			
			// output(s)
			.o_SETID_MOD(wdi[91:69]),
			.o_Done(Done4)
		);
		
	Status_Engine	Engine_Inst5
		(
			.clk(clk),
			.rst(rst),
			
			// input(s)
			.i_SET_ID(i_Set_ID),
			.i_Status_En(i_Set_Segment_Enable),
			.i_RAM_Data(rdo[114:92]),
			.i_Mask_Data(Set_Mask),
			
			// output(s)
			.o_SETID_MOD(wdi[114:92]),
			.o_Done(Done5)
		);
		
	Status_Engine	Engine_Inst6
		(
			.clk(clk),
			.rst(rst),
			
			// input(s)
			.i_SET_ID(i_Set_ID),
			.i_Status_En(i_Set_Segment_Enable),
			.i_RAM_Data(rdo[137:115]),
			.i_Mask_Data(Set_Mask),
			
			// output(s)
			.o_SETID_MOD(wdi[137:115]),
			.o_Done(Done6)
		);
		
	Status_Engine	Engine_Inst7
		(
			.clk(clk),
			.rst(rst),
			
			// input(s)
			.i_SET_ID(i_Set_ID),
			.i_Status_En(i_Set_Segment_Enable),
			.i_RAM_Data(rdo[160:138]),
			.i_Mask_Data(Set_Mask),
			
			// output(s)
			.o_SETID_MOD(wdi[160:138]),
			.o_Done(Done7)
		);
	
	Status_Engine	Engine_Inst8
		(
			.clk(clk),
			.rst(rst),
			
			// input(s)
			.i_SET_ID(i_Set_ID),
			.i_Status_En(i_Set_Segment_Enable),
			.i_RAM_Data(rdo[183:161]),
			.i_Mask_Data(Set_Mask),
			
			// output(s)
			.o_SETID_MOD(wdi[183:161]),
			.o_Done(Done8)
		);
		
	Status_Engine	Engine_Inst9
		(
			.clk(clk),
			.rst(rst),
			
			// input(s)
			.i_SET_ID(i_Set_ID),
			.i_Status_En(i_Set_Segment_Enable),
			.i_RAM_Data(rdo[206:184]),
			.i_Mask_Data(Set_Mask),
			
			// output(s)
			.o_SETID_MOD(wdi[206:184]),
			.o_Done(Done9)
		);
		
	Status_Engine	Engine_Inst10
		(
			.clk(clk),
			.rst(rst),
			
			// input(s)
			.i_SET_ID(i_Set_ID),
			.i_Status_En(i_Set_Segment_Enable),
			.i_RAM_Data(rdo[229:207]),	
			.i_Mask_Data(Set_Mask),
			
			// output(s)
			.o_SETID_MOD(wdi[229:207]),
			.o_Done(Done10)
		);
		
	Status_Engine	Engine_Inst11
		(
			.clk(clk),
			.rst(rst),
			
			// input(s)
			.i_SET_ID(i_Set_ID),
			.i_Status_En(i_Set_Segment_Enable),
			.i_RAM_Data(rdo[252:230]),	
			.i_Mask_Data(Set_Mask),
			
			// output(s)
			.o_SETID_MOD(wdi[252:230]),
			.o_Done(Done11)
		);
		
	Status_Engine	Engine_Inst12
		(
			.clk(clk),
			.rst(rst),
			
			// input(s)
			.i_SET_ID(i_Set_ID),
			.i_Status_En(i_Set_Segment_Enable),
			.i_RAM_Data(rdo[275:253]),	
			.i_Mask_Data(Set_Mask),
			
			// output(s)
			.o_SETID_MOD(wdi[275:253]),
			.o_Done(Done12)
		);
		
	Status_Engine	Engine_Inst13
		(
			.clk(clk),
			.rst(rst),
			
			// input(s)
			.i_SET_ID(i_Set_ID),
			.i_Status_En(i_Set_Segment_Enable),
			.i_RAM_Data(rdo[298:276]),	
			.i_Mask_Data(Set_Mask),
			
			// output(s)
			.o_SETID_MOD(wdi[298:276]),
			.o_Done(Done13)
		);
// =============================================================================
// == Output Assignment:
// =============================================================================
	
	assign o_Segment_Vector = (!i_Set_Segment_Enable) ? { rdo[298:289], rdo[275:266], rdo[252:243], 
														  rdo[229:220], rdo[206:197], rdo[183:174], 
														  rdo[160:151], rdo[137:128], rdo[114:105], 
														  rdo[91:82], rdo[68:59], rdo[45:36], rdo[22:13]  													  			  
														 } : 'bx;
	assign o_Mask_Data1 = rdo[12:0];
	assign o_Mask_Data2 = rdo[35:23];
	assign o_Mask_Data3 = rdo[58:46];
	assign o_Mask_Data4 = rdo[81:69];
	assign o_Mask_Data5 = rdo[104:92];
	assign o_Mask_Data6 = rdo[127:115];
	assign o_Mask_Data7 = rdo[150:138];
	assign o_Mask_Data8 = rdo[173:161];
	assign o_Mask_Data9 = rdo[196:184];
	assign o_Mask_Data10 = rdo[219:207];
	assign o_Mask_Data11 = rdo[242:230];
	assign o_Mask_Data12 = rdo[265:253];
	assign o_Mask_Data13 = rdo[288:276];
	
endmodule 