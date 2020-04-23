// Top-level module that defines the I/Os for the DE-1 SoC board
// Specifically implements tug of war for lab 7

module lab7_implement_test (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
 input logic        CLOCK_50; // 50MHz clock
 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 output logic [9:0] LEDR;
 input logic [3:0] KEY;
 input logic [9:0] SW;

// Default values, turns off the HEX displays
// assign HEX0 = 7'b1111111;
 assign HEX1 = 7'b1111111;
 assign HEX2 = 7'b1111111;
 assign HEX3 = 7'b1111111;
 assign HEX4 = 7'b1111111;
// assign HEX5 = 7'b1111111;

// Implement lab 6 tug of war
// KEY[0] -> flipflop 
// 	-> flipflop 
//			-> button_press 
//				-> p1 input to tug_display
//					-> LEDR[9:1]
//						-> wincounter for p1
//							-> 7seg
//								-> HEX1
//	LSFR & SW[8:0] -> comparator
// 	-> p2 input to tug_display
//			-> LEDR[9:1]
//				-> wincounter for robot
//					-> 7seg
//						-> HEX5

//	logic [31:0] clk;
//	parameter whichClock = 23;
//	clock_divider cdiv (.clock(CLOCK_50),
//                      .reset(reset),
//                      .divided_clocks(clk));


	logic reset;
	assign reset = SW[9];
	logic [9:0] comp10_sw ;
	assign comp10_sw[9] = 0;
	assign comp10_sw[8:0] = SW[8:0];
	

	// Hook up player inputs
	logic p1_first_dff;
	logic p1_second_dff;
	logic p1_to_game;
	flipflop p1_raw(.clk(CLOCK_50), .reset(reset), .D(~KEY[0]), .Q(p1_first_dff));
	flipflop p1_stable(.clk(CLOCK_50), .reset(reset), .D(p1_first_dff), .Q(p1_second_dff));
	button_press p1_input(.clk(CLOCK_50), .reset(reset), .in(p1_second_dff), .out(p1_to_game));
	
	logic [9:0] comp10_robo;
	logic robo_to_button;
	logic robo_to_game;
	LFSR_10 rng_gen(.clk(CLOCK_50), .reset(reset), .out(comp10_robo));
	comparator_10 comp(.clk(CLOCK_50), .reset(reset), .a(comp10_sw), .b(comp10_robo), .out(robo_to_button));
	button_press robo_input(.clk(CLOCK_50), .reset(reset), .in(robo_to_button), .out(robo_to_game));
	
	// Send player inputs to game tracker, hook up displays
	logic [3:0] p1_7seg;
	logic [3:0] probot_7seg;
	logic [1:0] wincounters;
	logic [3:0] p1win_7seg;
	logic [3:0] robowin_7seg;
	tug_display7 game(.clk(CLOCK_50), .reset(reset), .p1(p1_to_game), .p2(robo_to_game), .lights(LEDR[9:1]), .wincounts(wincounters));
	count_3 p1_count(.clk(CLOCK_50), .reset(reset), .in(wincounters[0]), .bcd(p1win_7seg));
	count_3 robo_count(.clk(CLOCK_50), .reset(reset), .in(wincounters[1]), .bcd(robowin_7seg));
	seg7 p1_driver(.bcd(p1win_7seg), .leds(HEX0));
	seg7 robo_driver(.bcd(robowin_7seg), .leds(HEX5));
 
endmodule


module lab7_implement_test_testbench();
 logic CLOCK_50;
 logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 logic [9:0] LEDR;
 logic [3:0] KEY;
 logic [9:0] SW;
 
 logic reset;

 lab7_implement_test dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR,
.SW);

 // Set up the clock.
 parameter CLOCK_PERIOD=100;
 initial begin
 CLOCK_50 <= 0;
 forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
 end 


 initial begin
 
//		reset <= 1; 				@(posedge CLOCK_50);
//		reset <= 0;  	@(posedge CLOCK_50);
		SW[9] <= 1; 				@(posedge CLOCK_50);
		SW[9] <= 0;  	@(posedge CLOCK_50);
 
		SW[0] = 0; @(posedge CLOCK_50);
		SW[1] = 0; @(posedge CLOCK_50);
		SW[2] = 0; @(posedge CLOCK_50);
		SW[3] = 0; @(posedge CLOCK_50);
		SW[4] = 0; @(posedge CLOCK_50);
		SW[5] = 0; @(posedge CLOCK_50);
		SW[6] = 0; @(posedge CLOCK_50);
		SW[7] = 0; @(posedge CLOCK_50);
		SW[8] = 0; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 1; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 0; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 1; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 0; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 1; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 0; @(posedge CLOCK_50);
		KEY[0] <= 1; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 0; @(posedge CLOCK_50);
		KEY[0] <= 1; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 0; @(posedge CLOCK_50);
		KEY[0] <= 1; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 0; @(posedge CLOCK_50);
		
		SW[0] = 1; @(posedge CLOCK_50);
		SW[1] = 1; @(posedge CLOCK_50);
		SW[2] = 1; @(posedge CLOCK_50);
		SW[3] = 1; @(posedge CLOCK_50);
		SW[4] = 1; @(posedge CLOCK_50);
		SW[5] = 1; @(posedge CLOCK_50);
		SW[6] = 1; @(posedge CLOCK_50);
		SW[7] = 1; @(posedge CLOCK_50);
		SW[8] = 1; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 1; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 0; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 1; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 0; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 1; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 0; @(posedge CLOCK_50);
		KEY[0] <= 1; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 0; @(posedge CLOCK_50);
		KEY[0] <= 1; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 0; @(posedge CLOCK_50);
		KEY[0] <= 1; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
		KEY[0] <= 0; @(posedge CLOCK_50);
		

		$stop; // End the simulation.
 end



endmodule 
