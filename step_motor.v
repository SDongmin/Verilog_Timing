module step_motor(
	input clk, reset, sw,
	output reg [3:0] step_motor
);

reg [2:0] count;
reg switch, temp;

always@(posedge clk or negedge reset) begin
	if(reset == 1'b0) begin
		count <= 0;
		step_motor <= 0;
		switch <= 0;
	end

	else begin
		
		if(switch == 0) begin
			count <= count +1;
		end
		
		else count <= count;

		case(count)
			3'd0 : step_motor <= 4'b1000;
			3'd1 : step_motor <= 4'b1100;
			3'd2 : step_motor <= 4'b0100;
			3'd3 : step_motor <= 4'b0110;
			3'd4 : step_motor <= 4'b0010;
			3'd5 : step_motor <= 4'b0011;
			3'd6 : step_motor <= 4'b0001;
			3'd7 : step_motor <= 4'b1001;
		endcase
	end
end

endmodule