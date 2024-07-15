// Verilog code for Test bench
// Define module
module tb;
reg clock=0; // Define all I/O ports
wire red, yellow, green;

// Map all th I/O ports with DUT
traffic_light_controller uut (.clock(clock), .red(red), .yellow(yellow), .green(green));

always begin
    clock = ~clock; #10000;
end

endmodule
