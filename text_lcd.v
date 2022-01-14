module text_lcd(
	input clk, reset,
	output lcd_en,
	output reg lcd_rs, lcd_rw,
	output reg [7:0] lcd_data
);

reg [9:0] count, shift_count;
reg [2:0] state;

parameter [2:0] delay		= 3'b000,
	        function_set		= 3'b001,
	        disp_on_off		= 3'b010,
	        entry_mode_set	= 3'b011,
	        Fline		= 3'b100,
	        Sline		= 3'b101;

assign lcd_en = clk;

always@(posedge clk or negedge reset) begin
	if(reset == 1'b0) begin
		state <= delay;
		count <= 0;
	end
	else
		case(state)
			delay		: if(count == 10'd70) begin
						state <= function_set;
						count <= 0;
					end
					else count <= count +1;

			function_set	: if(count == 10'd30) begin
						state <= disp_on_off;
						count <= 0;
					end
					else count <= count +1;

			disp_on_off	: if(count == 10'd30) begin
						state <= entry_mode_set;
						count <= 0;
					end
					else count <= count +1;

			entry_mode_set	: if(count == 10'd30) begin
						state <= Fline;
						count <= 0;
					end
					else count <= count +1;

			Fline		: if(count == 10'd16) begin
						state <= Sline;
						count <= 0;
					end
					else count <= count +1;

			Sline		: if(count == 10'd16) begin
						count <= 0;
					end
					else count <= count +1;
			default	: ;
			endcase
end

always@(posedge clk or negedge reset) begin
	if(reset == 1'b0) begin
		lcd_rs <= 1; lcd_rw <= 1;
		lcd_data <= 8'b0000_0000;
		shift_count <= 0;
	end
	else begin
		shift_count <= shift_count +1;
		case(state)
			delay		: begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0000; end
			function_set	: begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0011_1000; end
			disp_on_off	: begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_1111; end
			entry_mode_set	: begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0110; end
			Fline		: begin
				lcd_rw <= 0;
					case(count)
						0  : begin lcd_rs <= 0; lcd_data <= 8'd128; end	//DD RAM Address line 1

						1  : begin lcd_rs <= 1; lcd_data <= 8'd83; end	 //S
						2  : begin lcd_rs <= 1; lcd_data <= 8'd84; end	 //T
						3  : begin lcd_rs <= 1; lcd_data <= 8'd79; end	 //O
						4  : begin lcd_rs <= 1; lcd_data <= 8'd80; end	 //P
						5  : begin lcd_rs <= 1; lcd_data <= 8'd87; end	 //W
						6  : begin lcd_rs <= 1; lcd_data <= 8'd65; end	 //A		
						7  : begin lcd_rs <= 1; lcd_data <= 8'd84; end	 //T
						8  : begin lcd_rs <= 1; lcd_data <= 8'd67; end	 //C
						9  : begin lcd_rs <= 1; lcd_data <= 8'd72; end	 //H
						10 : begin lcd_rs <= 1; lcd_data <= 8'd32; end	 //space
						default	: ;
					endcase
				end

			Sline		: begin
				lcd_rw <= 0;
					case(count)
						0  : begin lcd_rs <= 0; lcd_data <= 8'd192; end	//DD RAM Address line 2

						1  : begin lcd_rs <= 1; lcd_data <= 8'd71; end	//G
						2  : begin lcd_rs <= 1; lcd_data <= 8'd65; end	//A
						3  : begin lcd_rs <= 1; lcd_data <= 8'd77; end	//M	
						4  : begin lcd_rs <= 1; lcd_data <= 8'd69; end	//E
						5 : begin lcd_rs <= 1; lcd_data <= 8'd32; end	 //space						
						default	: ;
					endcase
				end
		endcase
		
	end
end
endmodule
