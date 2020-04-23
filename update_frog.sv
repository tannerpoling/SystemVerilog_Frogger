module update_frog (clk, new_game, reset, gameover, player_input, frog_x, frog_y);
	input  logic clk, new_game, reset, gameover;
	input  logic [3:0] player_input;
	output logic [3:0] frog_x, frog_y; // 4 bits bc we need range of 0-16 for each coord
			 
	
	always_ff @(posedge clk) begin
		if (reset || new_game) begin
			frog_y <= 8;
			frog_x <= 0;
		end
		else if (gameover == 0) begin
			if (player_input[3]) // move up
				if (frog_y < 15)
					frog_y <= frog_y + 1;
			if (player_input[2]) // move down
				if (frog_y > 0)
					frog_y <= frog_y - 1;
			if (player_input[1]) // move left
				if (frog_x > 0)
					frog_x <= frog_x - 1;
			if (player_input[0]) // move right
				if (frog_x < 15)
					frog_x <= frog_x + 1;
		end
		if (frog_x == 15)
			frog_x <= 0;
			
	
	end
	
endmodule

module update_frog_testbench();
	logic clk, new_game, reset, gameover;
	logic [3:0] player_input;
	logic [3:0] frog_x, frog_y;

	update_frog dut(clk, new_game, reset, gameover, player_input, frog_x, frog_y);
	
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
		player_input <= 0;				@(posedge clk);
		gameover <= 0;						@(posedge clk);
		// pass through some basic player inputs, during game and gameover										
												@(posedge clk);
												@(posedge clk);
		player_input[0] <= 1;			@(posedge clk);
		player_input[0] <= 0;			@(posedge clk);
		player_input[0] <= 1;			@(posedge clk);
		player_input[0] <= 0;			@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		player_input[1] <= 1;			@(posedge clk);
		player_input[1] <= 0;			@(posedge clk);
		player_input[1] <= 1;			@(posedge clk);
		player_input[1] <= 0;			@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		player_input[2] <= 1;			@(posedge clk);
		player_input[2] <= 0;			@(posedge clk);
		player_input[2] <= 1;			@(posedge clk);
		player_input[2] <= 0;			@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		player_input[3] <= 1;			@(posedge clk);
		player_input[3] <= 0;			@(posedge clk);
		player_input[3] <= 1;			@(posedge clk);
		player_input[3] <= 0;			@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		gameover <= 1;						@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		player_input[0] <= 1;			@(posedge clk);
		player_input[0] <= 0;			@(posedge clk);
		player_input[0] <= 1;			@(posedge clk);
		player_input[0] <= 0;			@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		player_input[1] <= 1;			@(posedge clk);
		player_input[1] <= 0;			@(posedge clk);
		player_input[1] <= 1;			@(posedge clk);
		player_input[1] <= 0;			@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		player_input[2] <= 1;			@(posedge clk);
		player_input[2] <= 0;			@(posedge clk);
		player_input[2] <= 1;			@(posedge clk);
		player_input[2] <= 0;			@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		player_input[3] <= 1;			@(posedge clk);
		player_input[3] <= 0;			@(posedge clk);
		player_input[3] <= 1;			@(posedge clk);
		player_input[3] <= 0;			@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);

		$stop; // End the simulation.
	end
	
endmodule
