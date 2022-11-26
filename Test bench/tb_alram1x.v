module tb_alram1x;

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter WID = 10;				// 10-bit long data
parameter AWID = 2;				// 2-bit long address (4 addresses)
parameter DEP = 1<<AWID;		// DEP = 2**AWID

////////////////////////////////////////////////////////////////////////////////
// Port declarations
reg clkw;
reg clkr;
reg clk;

reg rst;
 
wire  [WID-1:0] rdo;
reg [AWID-1:0] ra;
 
reg [WID-1:0]  wdi;
reg [AWID-1:0] wa;
reg            we;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

always #10 clk = ~clk;
//always #10 clkw = ~clkw;
//always #15 clkr = ~clkr;

integer i, j;

initial
begin
	{clk, clkw, clkr, rst, ra, wdi, wa, we} <= 0;
	
	repeat (1) @(posedge clk);
	
	// for writing purpose
	for (i = 0; i < 2**AWID; i = i + 1) begin
		for (j = 0; j < 2**AWID; j = j + 1) begin
			repeat (1) @(posedge clk) ra <= j; wa <= i; we <= 1'b1; wdi <= $random;
		end
	end
	
end

// DUT
alram1x u_alram1x (clk, clk, rst, rdo, ra, wdi, wa, we);

endmodule