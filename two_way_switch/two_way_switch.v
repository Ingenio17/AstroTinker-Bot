module two_way_switch(
	input s1, s2,
	output z
);

assign z = (s1^s2);

endmodule
