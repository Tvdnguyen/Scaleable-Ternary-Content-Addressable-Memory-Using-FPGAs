////////////////////////////////////////////////////////////////////////////////
//
// Ho Chi Minh City University of Technology
//
// Filename     : ffxkclk.v
// Description  : .
//
// Author       : .
// Created On   : Tue Dec 15 08:15:08 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module ffxkclk
    (
     clk,
     rst,
     idat,
     odat
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter           K = 3;    //delay 3 clock cycle

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input               clk,
                    rst;
input               idat;
output              odat;
  
////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire                odat;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
reg [K-1:0]         shift_dat; // = {K{1'b0}};			// declaration of [2 : 0] shift data register, and initialized shift_dat = 000
wire [K:0]          shift_in;						// declaration of [3 : 0] shift input, and initialized shift_in = xxxx
assign              shift_in = {shift_dat,idat};	// shift_in = 000-idat (3 bit of shift data, 1 bit of input data)

always @ (posedge clk)
    begin
    shift_dat <= shift_in[K-1:0];	
    end
	
assign odat = shift_dat[K-1];

endmodule 

// This is procedural coding using always block
// There are totally 3 latches in a big latch
// It can be virtuallized as a big latch which is fetching the input data throughout 3 latches to the output data
// This is called a shift register
