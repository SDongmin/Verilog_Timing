module key_pad(
	input clk, reset,
	input [3:0] key_pad_row,
	output reg [2:0] key_pad_col,
	output reg [11:0] key	// 000_000_000_000
);

reg [1:0] count;

always@(posedge clk or negedge reset) begin
	if(reset == 1'b0) begin
		count <= 0;
		key_pad_col <= 0;
	end
	else begin
		if(count >= 2)
			count <= 0;
		else count <= count +1;

		case(count)
			2'd0	: key_pad_col <= 3'b001;
			2'd1	: key_pad_col <= 3'b010;
			2'd2	: key_pad_col <= 3'b100;
			default	: key_pad_col <= 3'b000;
		endcase

		case(key_pad_row)
			4'b0001 : begin
				if(count == 0) key[0] <= 1;
				else if (count == 1) key[1] <= 1;
				else if (count == 2) key[2] <= 1;
				else;
			end

			4'b0010 : begin
				if(count == 0) key[3] <= 1;
				else if (count == 1) key[4] <= 1;
				else if (count == 2) key[5] <= 1;
				else;
			end

			4'b0100 : begin
				if(count == 0) key[6] <= 1;
				else if (count == 1) key[7] <= 1;
				else if (count == 2) key[8] <= 1;
				else;
			end

			4'b1000 : begin
				if(count == 0) key[9] <= 1;
				else if (count == 1) key[10] <= 1;
				else if (count == 2) key[11] <= 1;
				else;
			end

			4'b0000 : begin
				if(count==0) begin key[0] <=0; key[3] <= 0; key[6] <= 0; key[9] <= 0; end
				else;
				if(count==1) begin key[1] <=0; key[4] <= 0; key[7] <= 0; key[10] <= 0; end
				else;
				if(count==2) begin key[2] <=0; key[5] <= 0; key[8] <= 0; key[11] <= 0; end
				else;
			end
			default	: ;
		endcase
	end
end

endmodule
				