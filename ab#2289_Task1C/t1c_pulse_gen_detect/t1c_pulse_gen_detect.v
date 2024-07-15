// AstroTinker Bot : Task 1C : Pulse Generator and Detector
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.

This file is used to design a module which will generate a 10us pulse and detect incoming pulse signal.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

// t1c_pulse_gen_detect
//Inputs : clk_50M, reset, echo_rx
//Output : trigger, distance, pulses, state

// module declaration
module t1c_pulse_gen_detect (
    input clk_50M, reset, echo_rx,
    output reg trigger, out,
    output reg [21:0] pulses,
    output reg [1:0] state
);

initial begin
    trigger = 0; out = 0; pulses = 0; state = 0;
end


//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////
parameter WARM_UP = 2'b00, TRIGGER = 2'b01, READ = 2'b10, CREATE = 2'b11;

reg [5:0] counter_1us = 0;
reg [8:0] counter_10us = 0;
reg [15:0] counter_1ms = 0;
reg [15:0] period = 0;
reg clk_1us = 0;
reg clk_10us = 0;
reg clk_1ms = 0;

always @ (posedge clk_50M) begin
	
	if (reset) begin
		counter_1ms = 0;
		counter_1us = 0;
		counter_10us = 0;
		period = 0;
		clk_1us = 0;
		clk_10us = 0;
		clk_1ms = 0;
		pulses = 0;
		state = WARM_UP;
		trigger = 0;
		out = 0;
	end
	else begin
		if(counter_1us == 6'b110010) begin
			clk_1us = ~clk_1us;
			counter_1us = 0;
		end
		else
			counter_1us = counter_1us + 1'b1;
			
		if(counter_10us == 9'b111110100) begin
			clk_10us = ~clk_10us;
			counter_10us = 0;
		end
		else
			counter_10us = counter_10us + 1'b1;
			
		if(counter_1ms == 16'b1100001101010000) begin
			clk_1ms = ~clk_1ms;
			counter_1ms = 0;
		end
		else
			counter_1ms = counter_1ms + 1'b1;
			
		case(state)
			WARM_UP: begin
				if(counter_1us == 6'b110010) begin
					state = TRIGGER;
					counter_10us = 0;
				end
				else
					state = WARM_UP;
			end
			TRIGGER: begin
				if(counter_10us == 9'b111110100) begin
					state = READ;
					counter_1ms = 0;
				end
				else begin
					trigger = 1;
					state = TRIGGER;
				end
			end
			READ: begin
				trigger = 0;
				if(counter_1ms == 16'b1100001101010000) begin
					state = CREATE;
				end
				else begin
					if (echo_rx == 1)
						pulses = pulses + 1'b1;
				end				
			end
			CREATE: begin
				if (pulses == 22'b0000000111001011100010)
					out = 1;
				state = WARM_UP;
				pulses = 0;
				counter_1us = 0;
			end
			default: state = WARM_UP;
	endcase
	end
end 

/*
Add your logic here
*/

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule
