module mimas (
	input clock_100MHz,

	output [7:0] led
	//input [3:0] switch
);

reg leds;
assign led [7:0] = { 8 { leds } };

reg [31:0] counter = 0;

always @ (posedge clock_100MHz)
begin
	counter <= counter + 1;

	if (counter == 104857600)
	begin
		counter <= 0;
		leds <= ~leds;
	end
end

endmodule
