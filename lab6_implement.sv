// Top-level module that defines the I/Os for the DE-1 SoC board
// Specifically implements tug of war for lab 6

module lab6_implement (clk, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 output logic [9:0] LEDR;
 input logic [3:0] KEY;
 input logic [9:0] SW;
 input logic 		 clk;

// Default values, turns off the HEX displays
// assign HEX0 = 7'b1111111;
 assign HEX1 = 7'b1111111;
 assign HEX2 = 7'b1111111;
 assign HEX3 = 7'b1111111;
 assign HEX4 = 7'b1111111;
 assign HEX5 = 7'b1111111;

// Implement lab 6 tug of war
// KEY[0] -> flipflop 
// 	-> flipflop 
//			-> button_press 
//				-> p1 input to tug_display
//					-> LEDR[9:1], HEX0 on board
// KEY[3] -> flipflop 
// 	-> flipflop 
//			-> button_press 
//				-> p2 input to tug_display
//					-> LEDR[9:1], HEX0 on board

	logic reset;
	assign reset = SW[9];

	// Hook up player inputs
	logic p1_first_dff;
	logic p1_second_dff;
	logic p1_to_game;
	flipflop p1_raw(.clk(clk), .reset(reset), .D(~KEY[0]), .Q(p1_first_dff));
	flipflop p1_stable(.clk(clk), .reset(reset), .D(p1_first_dff), .Q(p1_second_dff));
	button_press p1_input(.clk(clk), .reset(reset), .in(p1_second_dff), .out(p1_to_game));
	
	logic p2_first_dff;
	logic p2_second_dff;
	logic p2_to_game;
	flipflop p2_raw(.clk(clk), .reset(reset), .D(~KEY[3]), .Q(p2_first_dff));
	flipflop p2_stable(.clk(clk), .reset(reset), .D(p2_first_dff), .Q(p2_second_dff));
	button_press p2_input(.clk(clk), .reset(reset), .in(p2_second_dff), .out(p2_to_game));
	
	// Send player inputs to game tracker, hook up displays
	logic [3:0] in_7seg;
	tug_display game(.clk(clk), .reset(reset), .p1(p1_to_game), .p2(p2_to_game), .lights(LEDR[9:1]), .bcd(in_7seg));
	seg7 hex_driver(.bcd(in_7seg), .leds(HEX0));
 
endmodule


module lab6_implement_testbench();
 logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 logic [9:0] LEDR;
 logic [3:0] KEY;
 logic [9:0] SW;
 logic clk;

 lab6_implement dut (.clk, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR,
.SW);
logic reset;

 // Set up the clock.
 parameter CLOCK_PERIOD=100;
 initial begin
 clk <= 0;
 forever #(CLOCK_PERIOD/2) clk <= ~clk;
 end 


 initial begin
												@(posedge clk);
		reset <= 1; 						@(posedge clk);
		reset <= 0; KEY[0] <= 0; KEY[3] <= 0; 	@(posedge clk);
		// First test: P1 wins
												@(posedge clk);
		KEY[0] <= 1;								@(posedge clk);
														@(posedge clk);
														@(posedge clk);
		KEY[0] <= 0;								@(posedge clk);
		KEY[0] <= 1;	 							@(posedge clk);
		@(posedge clk);
		KEY[0] <= 0;								@(posedge clk);
		KEY[3] <= 1;								@(posedge clk);
		KEY[3] <= 0;								@(posedge clk);
		KEY[0] <= 1;								@(posedge clk);
		KEY[0] <= 0;								@(posedge clk);
		KEY[0] <= 1;								@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		KEY[0] <= 0;								@(posedge clk);
		KEY[0] <= 1;								@(posedge clk);
		KEY[0] <= 0;								@(posedge clk);
		KEY[0] <= 1;								@(posedge clk);
		KEY[0] <= 0;								@(posedge clk);
		// P1 should now win
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		reset <= 1;							@(posedge clk);
		// Second test: KEY[3] wins
		KEY[3] <= 1;								@(posedge clk);
		KEY[3] <= 0;								@(posedge clk);
		KEY[3] <= 1;	 							@(posedge clk);
		KEY[3] <= 0;								@(posedge clk);
		KEY[0] <= 1;								@(posedge clk);
		KEY[0] <= 0;								@(posedge clk);
		KEY[3] <= 1;								@(posedge clk);
		KEY[3] <= 0;								@(posedge clk);
		KEY[3] <= 1;								@(posedge clk);
		KEY[3] <= 0;								@(posedge clk);
		KEY[3] <= 1;								@(posedge clk);
		KEY[3] <= 0;								@(posedge clk);
		KEY[3] <= 1;								@(posedge clk);
		KEY[3] <= 0;								@(posedge clk);
		// P2 should now win
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		reset <= 1;							@(posedge clk);
		// Test both players pressing at same time
		KEY[0] <= 1; KEY[3] <= 1;					@(posedge clk);
		KEY[0] <= 0; KEY[3] <= 0;					@(posedge clk);
		KEY[0] <= 1; KEY[3] <= 1;					@(posedge clk);
		KEY[0] <= 0; KEY[3] <= 0;					@(posedge clk);
		$stop; // End the simulation.
 end



endmodule 
