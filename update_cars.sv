module update_cars (clk, reset, car2, car5, car7, car9, car11, car12);
	input logic clk, reset;
	output logic [15:0] car2, car5, car7, car9, car11, car12;

	/* 
	
		need to figure out how many cars we want to use / how to use them
		thinking a 2D array
		
		DEFAULT CAR LAYOUT
		_________________________________
	F	|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|
	E	|
	D	|
	C	|X X X     X X X X X X X     X
	B	|X X       X X X X X X       X X
	A	|
	9	|X X X X X           X X X   X X 
	8	|
	7	|  X X X X     X X X X   X     X
	6	|
	5	|X   X X X X     X X X X X     
	4	|
	3	|
	2	|X X X         X x     X X X X X
	1	|
	0	|
		 0 1 2 3 4 5 6 7 8 9 A B C D E F
		 
		 There are 6 lines with cars
		 Plan is to have a 6 x 16 array of 1s ad 0s
		 Rows 2, 7, 11 move LEFT
		 Rows 5, 9, 12 move RIGHT
		
	*/
	
	integer count;
	
	always_ff @(posedge clk) begin
	
		integer i;
		integer j;
		
		if (reset) begin
			count <= 0;
			car2  <= 16'b1110000110011111;
			car5  <= 16'b1011110011111000;
			car7  <= 16'b0111100111101001;
			car9  <= 16'b1111100000111011;
			car11 <= 16'b1100011111100011;
			car12 <= 16'b1110011111110000;
			end
		else begin
// need a counter in HERE, not draw_game		
			if (count == 3000) begin
			
				count <= 0;
				
				// update the cars
				// rows moving LEFT: 2, 7, 11
				for(i = 15; i > 0; i--) begin
					car2[i]  <= car2[i - 1];
					car7[i]  <= car7[i - 1];
					car11[i] <= car11[i - 1];
				end
						
				car2[0]  <=  car2[15];
				car7[0]  <=  car7[15];
				car11[0] <=  car11[15];
					
					
				// rows moving RIGHT: 5, 9, 12
				for (j = 0; j < 15; j++) begin
					car5[j]  <= car5[j + 1];
					car9[j]  <= car9[j + 1];
					car12[j] <= car12[j + 1];
				end
					
				car5[15]  <= car5[0];
				car9[15]  <= car9[0];
				car12[15] <= car12[0];
			end
			else begin
				count <= count + 1;
				car2 <= car2;
				car5 <= car5;
				car7 <= car7;
				car9 <= car9;
				car11 <= car11;
				car12 <= car12;
			end
		end
	end
endmodule

module update_cars_testbench();
	logic clk, reset;
	logic [15:0] car2, car5, car7, car9, car11, car12;
	
	update_cars dut(clk, reset, car2, car5, car7, car9, car11, car12);
	
	// Set up the clock.
   parameter CLOCK_PERIOD=100;
   initial begin
   clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
												@(posedge clk);
		reset <= 1; 						@(posedge clk);
		reset <= 0;							@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		// just let it run and generate car positions
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
