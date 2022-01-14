module piezo(
	input clk, reset,
	input [11:0] sw2,
	output reg W1_piezo
);

	reg [8:0] cnt1;

	wire [8:0] cnt;
	assign cnt =
		   (sw2==12'b000_000_000_010)? 171:
		   (sw2==12'b000_000_000_100)? 152:
		   (sw2==12'b000_000_001_000)? 143:
		   (sw2==12'b000_000_010_000)? 128:
		   (sw2==12'b000_000_100_000)? 114:
		   (sw2==12'b000_001_000_000)? 101:
		   (sw2==12'b000_010_000_000)? 96:
		   (sw2==12'b000_100_000_000)? 85:
		   (sw2==12'b001_000_000_000)? 76:
		   (sw2==12'b010_000_000_000)? 72:
		   (sw2==12'b100_000_000_000)? 64:0;

	always@(posedge clk or negedge reset) begin
		if(reset==1'b0) begin
			cnt1<=0;
			W1_piezo<=0;
		end
		else begin
			if(cnt1 >= cnt) begin
				W1_piezo <= ~W1_piezo;
				cnt1 <= 0;
			end
			else cnt1 <= cnt1+1;
		end
	end
endmodule
			
