module tb_two_way_switch;

reg s1, s2;
wire z;

two_way_switch uut(.s1(s1), .s2(s2), .z(z));

initial begin
	s1 = 0; s2 = 0; #100;
	s1 = 0; s2 = 1; #100;
	s1 = 1; s2 = 0; #100;
	s1 = 1; s2 = 1; #100;
	#100;
end

endmodule
	
