module top(
	input clk, push_0, push_1, rst,
	input [3:0] key_pad_row,
	output [2:0] key_pad_col,
	output [7:0] seg_data, seg_com, lcd_data,
	output [9:0] dot_col,
	output [13:0] dot_row,
	output [3:0] step_motor,
	output [15:0] led,
	output W1_piezo,
	output lcd_rs, lcd_rw, lcd_en
);

	reg count;
	
	wire reset;
	assign reset = rst;

	wire clk_12_5M, clk_100k, clk_10k, clk_1k, clk_1s;

	wire [11:0] key;

	//clock_div
	clk_div u1(.clk_25M(clk), .reset(reset), .clk_12_5M(clk_12_5M), .clk_100k(clk_100k),
			.clk_10k(clk_10k), .clk_1k(clk_1k), .clk_1s(clk_1s), .clk_h(clk_h),
			.clk_step(clk_step), .clk_led(clk_led));

	//segment_clock
	segment_clock u2(.clk(clk_1s), .clk_1k(clk_1k), .reset(reset), .led(led), .key(key[0]),.key_1(key[1]), .key_2(key[4]), .key_3(key[7]), .key_4(key[10]), .seg_data(seg_data), .seg_com(seg_com));
	

	//dot_matrix
	dot_matrix u3(.clk(clk_1k), .clk_1s(clk_1s), .reset(reset), .dot_row(dot_row), .dot_col(dot_col));

	//step_motor
	step_motor u4(.clk(clk_step), .reset(reset), .sw(key[1]), .step_motor(step_motor));

	//text_lcd
	text_lcd u5(.clk(clk_1k), .reset(reset), .lcd_en(lcd_en), .lcd_rs(lcd_rs), .lcd_rw(lcd_rw), .lcd_data(lcd_data) );
	

	key_pad u7(.clk(clk_1k), .reset(reset), .key_pad_row(key_pad_row), .key_pad_col(key_pad_col), .key(key));

	piezo u8(.clk(clk_100k), .reset(reset), .sw2(key), .W1_piezo(W1_piezo));

endmodule
