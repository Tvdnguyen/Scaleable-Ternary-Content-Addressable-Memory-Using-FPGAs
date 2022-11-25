module maskvecteng
	(
		clk,
		rst,
		
		// for searching purpose
		i_Segment_Vector,
		
		i_Mask_Data1,
		i_Mask_Data2,
		i_Mask_Data3,
		i_Mask_Data4,
		i_Mask_Data5,
		i_Mask_Data6,
		i_Mask_Data7,
		i_Mask_Data8,
		i_Mask_Data9,
		i_Mask_Data10,
		i_Mask_Data11,
		i_Mask_Data12,
		i_Mask_Data13,
		
		o_Mask_Vector1,
		o_Mask_Vector2,
		o_Mask_Vector3,
		o_Mask_Vector4,
		o_Mask_Vector5,
		o_Mask_Vector6,
		o_Mask_Vector7,
		o_Mask_Vector8,
		o_Mask_Vector9,
		o_Mask_Vector10,
		o_Mask_Vector11,
		o_Mask_Vector12,
		o_Mask_Vector13
	 );

// =============================================================================
// == Parameter declarations
// =============================================================================
	parameter KWID 	= 104; //Key width
	parameter SEGWID = 10; //Segment width IDwid+2stt
	parameter MASKWID = KWID/8; //13
	parameter DATA = SEGWID+MASKWID; // 23
	parameter VTDAT = DATA*(KWID/8); 
	parameter VTWID = SEGWID*(KWID/8); //segmem width
	parameter AWID = 8; //address width
	parameter IDWID = 8;

// ============================================================================
// == Port declarations
// ============================================================================
	input clk;
	input rst;
	
	input [VTWID-1:0]	i_Segment_Vector;		// 130 bit long
	
	input [MASKWID-1:0]	i_Mask_Data1;
	input [MASKWID-1:0]	i_Mask_Data2;
	input [MASKWID-1:0]	i_Mask_Data3;
	input [MASKWID-1:0]	i_Mask_Data4;
	input [MASKWID-1:0]	i_Mask_Data5;
	input [MASKWID-1:0]	i_Mask_Data6;
	input [MASKWID-1:0]	i_Mask_Data7;
	input [MASKWID-1:0]	i_Mask_Data8;
	input [MASKWID-1:0]	i_Mask_Data9;
	input [MASKWID-1:0]	i_Mask_Data10;
	input [MASKWID-1:0]	i_Mask_Data11;
	input [MASKWID-1:0]	i_Mask_Data12;
	input [MASKWID-1:0]	i_Mask_Data13;
	
	output [VTWID-1:0]	o_Mask_Vector1;		
	output [VTWID-1:0]	o_Mask_Vector2;
	output [VTWID-1:0]	o_Mask_Vector3;
	output [VTWID-1:0]	o_Mask_Vector4;
	output [VTWID-1:0]	o_Mask_Vector5;
	output [VTWID-1:0]	o_Mask_Vector6;
	output [VTWID-1:0]	o_Mask_Vector7;
	output [VTWID-1:0]	o_Mask_Vector8;
	output [VTWID-1:0]	o_Mask_Vector9;
	output [VTWID-1:0]	o_Mask_Vector10;
	output [VTWID-1:0]	o_Mask_Vector11;
	output [VTWID-1:0]	o_Mask_Vector12;
	output [VTWID-1:0]	o_Mask_Vector13;

// ============================================================================
// == Signal Declarations and Delays
// ============================================================================

	maskvectmem	 Mask_Memory_Inst1
		(
			.clk(clk),
			.rst(rst),
		
			.i_Segment(i_Segment_Vector[9:0]),
			.i_Segment_Vector(i_Segment_Vector),
			.i_Mask_Data(i_Mask_Data1),
			
			.o_Mask_Vect(o_Mask_Vector1)		
		);
	
	maskvectmem	 Mask_Memory_Inst2 	// each instantions create 1 RAM
		(
			.clk(clk),
			.rst(rst),
		
			.i_Segment(i_Segment_Vector[19:10]),
			.i_Segment_Vector(i_Segment_Vector),
			.i_Mask_Data(i_Mask_Data2),
			
			.o_Mask_Vect(o_Mask_Vector2)
		);
	
	maskvectmem	 Mask_Memory_Inst3
		(
			.clk(clk),
			.rst(rst),
		
			.i_Segment(i_Segment_Vector[29:20]),
			.i_Segment_Vector(i_Segment_Vector),
			.i_Mask_Data(i_Mask_Data3),
			
			.o_Mask_Vect(o_Mask_Vector3)
		);
	
	maskvectmem	 Mask_Memory_Inst4
		(
			.clk(clk),
			.rst(rst),
		
			.i_Segment(i_Segment_Vector[39:30]),
			.i_Segment_Vector(i_Segment_Vector),
			.i_Mask_Data(i_Mask_Data4),
			
			.o_Mask_Vect(o_Mask_Vector4)
		);
	
	maskvectmem	 Mask_Memory_Inst5
		(
			.clk(clk),
			.rst(rst),
		
			.i_Segment(i_Segment_Vector[49:40]),
			.i_Segment_Vector(i_Segment_Vector),
			.i_Mask_Data(i_Mask_Data5),
			
			.o_Mask_Vect(o_Mask_Vector5) 
		);
	
	maskvectmem	 Mask_Memory_Inst6
		(
			.clk(clk),
			.rst(rst),
		
			.i_Segment(i_Segment_Vector[59:50]),
			.i_Segment_Vector(i_Segment_Vector),
			.i_Mask_Data(i_Mask_Data6),
			
			.o_Mask_Vect(o_Mask_Vector6) 
		);
		
	maskvectmem	 Mask_Memory_Inst7
		(
			.clk(clk),
			.rst(rst),
		
			.i_Segment(i_Segment_Vector[69:60]),
			.i_Segment_Vector(i_Segment_Vector),
			.i_Mask_Data(i_Mask_Data7),
			
			.o_Mask_Vect(o_Mask_Vector7)
		);
		
	maskvectmem	 Mask_Memory_Inst8
		(
			.clk(clk),
			.rst(rst),
		
			.i_Segment(i_Segment_Vector[79:70]),
			.i_Segment_Vector(i_Segment_Vector),
			.i_Mask_Data(i_Mask_Data8),
			
			.o_Mask_Vect(o_Mask_Vector8)
		);	
	
	maskvectmem	 Mask_Memory_Inst9
		(
			.clk(clk),
			.rst(rst),
		
			.i_Segment(i_Segment_Vector[89:80]),
			.i_Segment_Vector(i_Segment_Vector),
			.i_Mask_Data(i_Mask_Data9),
			
			.o_Mask_Vect(o_Mask_Vector9)
		);
		
	maskvectmem	 Mask_Memory_Inst10
		(
			.clk(clk),
			.rst(rst),
		
			.i_Segment(i_Segment_Vector[99:90]),
			.i_Segment_Vector(i_Segment_Vector),
			.i_Mask_Data(i_Mask_Data10),
			
			.o_Mask_Vect(o_Mask_Vector10)
		);
		
	maskvectmem	 Mask_Memory_Inst11
		(
			.clk(clk),
			.rst(rst),
		
			.i_Segment(i_Segment_Vector[109:100]),
			.i_Segment_Vector(i_Segment_Vector),
			.i_Mask_Data(i_Mask_Data11),
			
			.o_Mask_Vect(o_Mask_Vector11)
		);	
	
	maskvectmem	 Mask_Memory_Inst12
		(
			.clk(clk),
			.rst(rst),
		
			.i_Segment(i_Segment_Vector[119:110]),
			.i_Segment_Vector(i_Segment_Vector),
			.i_Mask_Data(i_Mask_Data12),
			
			.o_Mask_Vect(o_Mask_Vector12)
		);
	
	maskvectmem	 Mask_Memory_Inst13
		(
			.clk(clk),
			.rst(rst),
		
			.i_Segment(i_Segment_Vector[129:120]),
			.i_Segment_Vector(i_Segment_Vector),
			.i_Mask_Data(i_Mask_Data13),
			
			.o_Mask_Vect(o_Mask_Vector13)
		);
	
endmodule 