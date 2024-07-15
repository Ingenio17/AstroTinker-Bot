// Verilog code for Traffic Light Controller
// Define traffic light controller module
module traffic_light_controller (
    input clock, // Define input ports clock,
    output reg red, yellow, green // Define output ports red, yellow, and green
);

// Defining State Machine Parameters
parameter ST_INIT=2'b00, ST_GREEN=2'b01, ST_YELLOW=2'b10, ST_RED=2'b11;

// defining 2-bit register
reg [1:0] state=ST_INIT;

  always @(posedge clock) begin
    case (state)
            ST_INIT: begin
                state = ST_GREEN; red = 0;
                yellow = 0; green = 0;
            end
            ST_GREEN: begin
                state = ST_YELLOW; red = 0;
                yellow = 0; green = 1;
            end
            ST_YELLOW: begin
                state = ST_RED; red = 0;
                yellow = 1; green = 0;
            end
            ST_RED: begin
                state = ST_GREEN; red= 1;
                yellow = 0; green = 0;
            end
            default: state = ST_INIT;
    endcase
end

endmodule
