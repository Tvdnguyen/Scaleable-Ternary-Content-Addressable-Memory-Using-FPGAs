////////////////////////////////////////////////////////////////////////////////
//
// Ho Chi Minh City University of Technology
//
// Filename		: segvectmemx (modified)
// Description	: Segment Vector Memory
//
// Author		: 
// Created On	: Sun Mar 21
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module segvectmem
	(
		clk,
		rst,
	
		rdo,
		ra,

		wdi,		// write data into RAM
		wa,		// write address into RAM
		we		// write enable
	 );

// =============================================================================
// == Parameter declarations
// =============================================================================
	parameter KWID 	= 104; //Key width
	parameter SEGWID = 10; //Segment width IDwid+2stt
	parameter MASKWID = KWID/8; //13
	parameter DATA = MASKWID+SEGWID;
	parameter VTWID = DATA*(KWID/8); //segmem width
	parameter AWID = 8; //address width
	
// ============================================================================
// == Port declarations
// ============================================================================
	input clk;
	input rst;	 
	
	output [VTWID-1:0] rdo;
	input [KWID-1:0] ra;		// 10-bit ra (key)
	input [KWID-1:0] wa;		// 10-bit wa (key)
	input [VTWID-1:0] wdi;		// 10-bit set of rule
	input we;

// ==========================================================================
// == Component Instatiation : Structural
// ==========================================================================
// RAM Blocks instantiation
	alram1x #(.WID(DATA), .AWID(AWID)) iram1  (clk, rst, rdo[22:0], ra[7:0], 		wdi[22:0], wa[7:0], we);	   			// use the same clock for r/w   1	
	alram1x #(.WID(DATA), .AWID(AWID)) iram2  (clk, rst, rdo[45:23], ra[15:8], 	wdi[45:23], wa[15: 8], we);     	// use the same clock for r/w   2
	alram1x #(.WID(DATA), .AWID(AWID)) iram3  (clk, rst, rdo[68:46], ra[23:16], 	wdi[68:46], wa[23:16], we);     	// use the same clock for r/w	3
	alram1x #(.WID(DATA), .AWID(AWID)) iram4  (clk, rst, rdo[91:69], ra[31:24], 	wdi[91:69], wa[31:24], we);     	// use the same clock for r/w   4	
	alram1x #(.WID(DATA), .AWID(AWID)) iram5  (clk, rst, rdo[114:92], ra[39:32], 	wdi[114:92], wa[39:32], we);     // use the same clock for r/w   5	
	alram1x #(.WID(DATA), .AWID(AWID)) iram6  (clk, rst, rdo[137:115], ra[47:40], wdi[137:115], wa[47:40], we);   // use the same clock for r/w   6	
	alram1x #(.WID(DATA), .AWID(AWID)) iram7  (clk, rst, rdo[160:138], ra[55:48], wdi[160:138], wa[55:48], we);   // use the same clock for r/w   7	
	alram1x #(.WID(DATA), .AWID(AWID)) iram8  (clk, rst, rdo[183:161], ra[63:56], wdi[183:161], wa[63:56], we);   // use the same clock for r/w   8	
	alram1x #(.WID(DATA), .AWID(AWID)) iram9  (clk, rst, rdo[206:184], ra[71:64], wdi[206:184], wa[71:64], we);   // use the same clock for r/w   9	
	alram1x #(.WID(DATA), .AWID(AWID)) iram10 (clk, rst, rdo[229:207], ra[79:72], wdi[229:207], wa[79:72], we);   // use the same clock for r/w   10	
	alram1x #(.WID(DATA), .AWID(AWID)) iram11 (clk, rst, rdo[252:230], ra[87:80], wdi[252:230], wa[87:80], we);   // use the same clock for r/w   11	
	alram1x #(.WID(DATA), .AWID(AWID)) iram12 (clk, rst, rdo[275:253], ra[95:88], wdi[275:253], wa[95:88], we);   // use the same clock for r/w   12	
	alram1x #(.WID(DATA), .AWID(AWID)) iram13 (clk, rst, rdo[298:276], ra[103:96],wdi[298:276], wa[103:96], we); // use the same clock for r/w   13	
	
	
	// ram2port_seg 	iram1	(clk, wdi[22:0], ra[7:0], wa[7:0], we, rdo[22:0]);
	// ram2port_seg 	iram2 	(clk, wdi[45:23], ra[15:8], wa[15:8], we, rdo[45:23]);
	// ram2port_seg 	iram3 	(clk, wdi[68:46], ra[23:16], wa[23:16], we, rdo[68:46]);
	// ram2port_seg 	iram4 	(clk, wdi[91:69], ra[31:24], wa[31:24], we, rdo[91:69]);
	// ram2port_seg 	iram5 	(clk, wdi[114:92], ra[39:32], wa[39:32], we, rdo[114:92]);
	// ram2port_seg 	iram6 	(clk, wdi[137:115], ra[47:40], wa[47:40], we, rdo[137:115]);
	// ram2port_seg 	iram7 	(clk, wdi[160:138], ra[55:48], wa[55:48], we, rdo[160:138]);
	// ram2port_seg 	iram8 	(clk, wdi[183:161], ra[63:56], wa[63:56], we, rdo[183:161]);
	// ram2port_seg 	iram9 	(clk, wdi[206:184], ra[71:64], wa[71:64], we, rdo[206:184]);
	// ram2port_seg 	iram10	(clk, wdi[229:207], ra[79:72], wa[79:72], we, rdo[229:207]);
	// ram2port_seg 	iram11	(clk, wdi[252:230], ra[87:80], wa[87:80], we, rdo[252:230]);
	// ram2port_seg 	iram12	(clk, wdi[275:253], ra[95:88], wa[95:88], we, rdo[275:253]);
	// ram2port_seg 	iram13	(clk, wdi[298:276], ra[103:96], wa[103:96], we, rdo[298:276]);
	
endmodule 

/*	- 2-bit width each 
*	- with 5 instantiations of alram1x => 5 RAM Blocks
*	- in order to store rule 
*
*/