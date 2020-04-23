// Top-level module that defines the I/Os for the DE-1 SoC board

module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 output logic [9:0] LEDR;
 input logic [3:0] KEY;
 input logic [9:0] SW;

 // Default values, turns off the HEX displays
 assign HEX0 = 7'b1111111;
 assign HEX1 = 7'b1111111;
 assign HEX2 = 7'b1111111;
 assign HEX3 = 7'b1111111;
 assign HEX4 = 7'b1111111;
 assign HEX5 = 7'b1111111;

 // UPC logic
 // U -> 	SW[9]
 // P -> 	SW[8]
 // C -> 	SW[7]
 // Mark ->	SW[0]
 
 // Stolen -> 		LEDR[0]
 // Discount ->	LEDR[2]
 
 assign LEDR[0] = (SW[9] & ~SW[8] & ~SW[0]) | (~SW[8] & ~SW[7] & ~SW[0]);
 assign LEDR[2] = SW[8] | (SW[9] & SW[7]);
 
 
endmodule
module DE1_SoC_testbench();
 logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 logic [9:0] LEDR;
 logic [3:0] KEY;
 logic [9:0] SW;

 DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR,
.SW);

 // Try all combinations of inputs.
 integer i;
 initial begin
 // note: can test only the switches that matter using {SW[9], SW[8], SW[7], SW[0]}
 for(i = 0; i <1024; i++) begin
 SW[9:0] = i; #10;
 end
 end
endmodule 