module segment_decode(
	input clk, reset,
	input [3:0] data,
	output reg [7:0] seg_data
);

	
	always@(posedge clk or negedge reset) begin
		if(~reset) begin
			seg_data<=0;
		end
		else begin
			case(data)
				4'd0 : seg_data<=8'b0011_1111; // dp g f e d c b a 
				4'd1 : seg_data<=8'b0000_0110;
				4'd2 : seg_data<=8'b0101_1011;
				4'd3 : seg_data<=8'b0100_1111;
				4'd4 : seg_data<=8'b0110_0110;
				4'd5 : seg_data<=8'b0110_1101;
				4'd6 : seg_data<=8'b0111_1101;
				4'd7 : seg_data<=8'b0010_0111;
				4'd8 : seg_data<=8'b0111_1111;
				4'd9 : seg_data<=8'b0110_0111;
				default: seg_data<=seg_data;
			endcase
		end
	end
		
endmodule