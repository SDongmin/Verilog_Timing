module dot_matrix(
	input clk, clk_1s, reset,
	output reg [13:0] dot_row,
	output reg [9:0] dot_col
);

	reg [3:0] sel_count;
	reg [3:0] count;
	reg [13:0] temp;
	reg [13:0] dot_data_0, dot_data_1, dot_data_2, dot_data_3, dot_data_4, dot_data_5, dot_data_6, dot_data_7, dot_data_8, dot_data_9;

always@(posedge clk or negedge reset) begin
	if(reset == 1'b0) begin
		dot_col <= 0;
		sel_count <= 0;
	end
	else begin
		if(sel_count >= 9)
			sel_count <= 0;
		else
			sel_count <= sel_count + 1;

		case(sel_count)
			4'd0 : dot_col<=10'b10_0000_0000;
			4'd1 : dot_col<=10'b01_0000_0000;
			4'd2 : dot_col<=10'b00_1000_0000;
			4'd3 : dot_col<=10'b00_0100_0000;
			4'd4 : dot_col<=10'b00_0010_0000;
			4'd5 : dot_col<=10'b00_0001_0000;
			4'd6 : dot_col<=10'b00_0000_1000;
			4'd7 : dot_col<=10'b00_0000_0100;
			4'd8 : dot_col<=10'b00_0000_0010;
			4'd9 : dot_col<=10'b00_0000_0001;
			default: dot_col<=0;
		endcase
	end
end

always@(posedge clk_1s or negedge reset) begin
	if(reset == 1'b0) begin
		dot_data_9 <= 14'b00_0000_0001_0000;	
		dot_data_8 <= 14'b00_0000_0001_1000;	
		dot_data_7 <= 14'b00_0000_0001_1100;	
		dot_data_6 <= 14'b11_1111_1111_1110;	
		dot_data_5 <= 14'b11_1111_1111_1111;	

		dot_data_4 <= 14'b11_1111_1111_1111;
		dot_data_3 <= 14'b11_1111_1111_1110;
		dot_data_2 <= 14'b00_0000_0001_1100;
		dot_data_1 <= 14'b00_0000_0001_1000;
		dot_data_0 <= 14'b00_0000_0001_0000;
		temp <= 0;
	end
	
end


always@(posedge clk or negedge reset) begin
	if(reset == 1'b0) begin
		dot_row <= 0;
	end
	else begin
		case(sel_count)
			4'd0 : dot_row <= dot_data_0;
			4'd1 : dot_row <= dot_data_1;
			4'd2 : dot_row <= dot_data_2;
			4'd3 : dot_row <= dot_data_3;
			4'd4 : dot_row <= dot_data_4;
			4'd5 : dot_row <= dot_data_5;
			4'd6 : dot_row <= dot_data_6;
			4'd7 : dot_row <= dot_data_7;
			4'd8 : dot_row <= dot_data_8;
			4'd9 : dot_row <= dot_data_9;
			default : dot_row <= 0;
		endcase
	end
end


endmodule

