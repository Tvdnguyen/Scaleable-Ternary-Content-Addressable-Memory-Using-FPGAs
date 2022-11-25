module alram1x
    (
     clk,//clock
     rst,
     
     rdo,//data from ram
     ra,//read address
     
     wdi,//data to ram
     wa,//write address
     we //write enable
     );
// =============================================================================
// == Parameter declarations
// =============================================================================
	parameter WID = 4;				// 10-bit long data
	parameter AWID = 2;				// 2-bit long address (4 addresses)
	parameter DEP = 1<<AWID;		// DEP = 2**AWID

// ==========================================================================
// == Port Declarations
// ==========================================================================
	input clk;
	input rst;
	
	output reg [WID-1:0] rdo;
	input [AWID-1:0] ra;
	
	input [WID-1:0]  wdi;
	input [AWID-1:0] wa;
	input            we;

// ==========================================================================
// == Signal Declarations
// ==========================================================================
	// force M10K ram style
	reg [WID-1:0]   mem [DEP-1:0] /* synthesis ramstyle = "no_rw_check, M10K" */;   // memory size	
	
	integer i;
// ==========================================================================
// == Architecture
// ==========================================================================
	always @(posedge clk)
	begin
		if (rst) begin 
			for (i = 0; i < DEP; i = i + 1) begin 
				mem[i] <= {WID{1'b0}};
			end 
		end 
		else if (we) begin
			mem[wa] <= wdi;
		end
		
		rdo <= mem[ra];		// delays 1 clock cycle
	end

endmodule 