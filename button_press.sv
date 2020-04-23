module button_press (clk, reset, in, out);
	
	// Takes in a "button press", where 1 will only be output once
	// despite the actual input being on for many clock cycles
	
	input	 logic clk, reset, in;
	output logic out;
	
	enum { NONE, WAITOFF } ps, ns;
	
	// NS logic + output
	always_comb begin
		case (ps)
		
			NONE: 	begin
							if (in)	begin
								ns = WAITOFF; 	
								out = 1'b1;
							end
							else		begin
								ns = NONE;		
								out = 1'b0;
							end
						end
					
			WAITOFF: begin
							if (in)	begin
								ns = WAITOFF;	
								out = 1'b0;
							end
							else		begin
								ns = NONE;		
								out = 1'b0;
							end
						end
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= NONE;
		else
			ps <= ns;
	end
endmodule
	
	
module button_press_testbench();
	logic clk, reset, in, out;
	
	button_press dut (clk, reset, in, out);
	// Set up the clock.
   parameter CLOCK_PERIOD=100;
   initial begin
   clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
										@(posedge clk);
		reset <= 1; 				@(posedge clk);
		reset <= 0; in <= 0; 	@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		in <= 1;	 					@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		in <= 0;						@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		$stop; // End the simulation.
	end
endmodule
	