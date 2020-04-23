module draw_game (clk, reset, gameover, frog_x, frog_y, car2, car5, car7, car9, car11, car12, RedPixels, GrnPixels);
	input logic clk, reset, gameover;
	input logic [3:0] frog_x, frog_y;
	input logic [15:0] car2, car5, car7, car9, car11, car12;
	output logic [15:0][15:0] RedPixels; // 16x16 array of red LEDs
   output logic [15:0][15:0] GrnPixels; // 16x16 array of green LEDs

	always_ff @(posedge clk) begin		


		if (reset) begin
			RedPixels <= 0;
			GrnPixels <= 0;
		end
		
		RedPixels <= 0;
		RedPixels[2]  <= car2;
		RedPixels[5]  <= car5;
		RedPixels[7]  <= car7;
		RedPixels[9]  <= car9;
		RedPixels[11] <= car11;
		RedPixels[12] <= car12;
		
		// we update the cars no matter what, but only update GrnPixels if the game is still going
		// gameover will STAY set to 1 once player loses.
		if (gameover) begin
			RedPixels[frog_x][frog_y] <= 1'b1;
		end
		else begin
			GrnPixels <= 0;
			GrnPixels[frog_x][frog_y] <= 1'b1;
			RedPixels[frog_x][frog_y] <= 0;
		end;
	
	end
endmodule

module draw_game_testbench();
	logic clk, reset, gameover;
	logic [3:0] frog_x, frog_y;
	logic [15:0] car2, car5, car7, car9, car11, car12;
	logic [15:0][15:0] RedPixels; // 16x16 array of red LEDs
   logic [15:0][15:0] GrnPixels; // 16x16 array of green LEDs

	draw_game dut(clk, reset, gameover, frog_x, frog_y, car2, car5, car7, car9, car11, car12, RedPixels, GrnPixels);
	
	// Set up the clock.
   parameter CLOCK_PERIOD=100;
   initial begin
   clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
												@(posedge clk);
		reset <= 1; 						@(posedge clk);
		reset <= 0;							@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		// assign default values from start of game
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		frog_y <= 8; frog_x <= 0;		@(posedge clk);
												@(posedge clk);
		car2  <= 16'b1110000110011111;
		car5  <= 16'b1011110011111000;
		car7  <= 16'b0111100111101001;
		car9  <= 16'b1111100000111011;
		car11 <= 16'b1100011111100011;
		car12 <= 16'b1110011111110000;										@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);

		$stop; // End the simulation.
	end

endmodule
