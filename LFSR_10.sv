module LFSR_10(clk, reset, out);

	input  logic clk, reset;
	output logic [10:1] out;
	logic bitsxnor;
	
	assign bitsxnor = out[10] ~^ out[7];
	
	always_ff @(posedge clk) begin
		if (reset) 
			begin
				out <= 0;
			end
		else 
			begin
				out[1] <= bitsxnor;
				out[2] <= out[1];
				out[3] <= out[2];
				out[4] <= out[3];
				out[5] <= out[4];
				out[6] <= out[5];
				out[7] <= out[6];
				out[8] <= out[7];
				out[9] <= out[8];
				out[10] <= out[9];
			end
	end
	
endmodule

module LFSR_10_testbench();
	logic clk, reset;
	logic [10:1] out;
	
	LFSR_10 dut(clk, reset, out);
	
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
