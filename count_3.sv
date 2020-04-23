module count_3(clk, reset, in, bcd);
	input  logic clk, reset, in;
	output logic [3:0] bcd;

		// counts to 7 and drives a 7seg display
		
		always_ff @(posedge clk) begin
			if (reset)
				bcd = 0;
			else
				if (in)
					if (bcd <= 7)
						bcd++;
		end
	

endmodule

module count_3_testbench();
	logic clk, reset, in;
	logic [3:0] bcd;
	
	count_3 dut(clk, reset, in, bcd);
	
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
												@(posedge clk);
		in <= 1;								@(posedge clk);
												@(posedge clk);
		in <= 0;
												@(posedge clk);
												@(posedge clk);
		in <= 1;								@(posedge clk);
						

		in <= 0;						@(posedge clk);
		in <= 1;								@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		in <= 1;								@(posedge clk);
		in <= 1;								@(posedge clk);
		in <= 1;								@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		in <= 1;								@(posedge clk);
		in <= 1;								@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		in <= 1;								@(posedge clk);
												@(posedge clk);
		in <= 1;								@(posedge clk);
												@(posedge clk);
		in <= 1;								@(posedge clk);

		$stop; // End the simulation.
	end
	
endmodule
