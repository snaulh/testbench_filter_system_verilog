//Gaussian filter function
module gaussian_func
					#(
					parameter DATA_WIDTH=8
					)
					(
					input wire  clk, rst, enable, 
					input wire [DATA_WIDTH-1:0] in1, in2, in3, in4, in5, in6, in7, in8, in9, 
					output reg [DATA_WIDTH-1:0] data_out
					);

reg  [DATA_WIDTH-1+4:0] dout;
wire [DATA_WIDTH-1+4:0] t1, t2, t3, t4, t5, t6, t7, t8, t9;

assign t1 = {4'b0, in1}; 		//o1
assign t2 = {3'b0, in2,1'b0}; 	//o2
assign t3 = {4'b0, in3}; 		//o3
assign t4 = {3'b0, in4,1'b0}; 	//o4
assign t5 = {2'b0, in5,2'b0}; 	//o5
assign t6 = {3'b0, in6,1'b0}; 	//o6
assign t7 = {4'b0, in7};		//o7
assign t8 = {3'b0, in8,1'b0}; 	//o8
assign t9 = {4'b0, in9};		//o9

always@(posedge clk or posedge rst) begin
	if (rst==1'b1) begin
		dout <=0;
	end
	else begin
		if(enable==1'b1) begin
			dout <= t1 + t2 + t3 + t4 + t5 + t6 + t7 + t8 + t9;
			data_out = dout[DATA_WIDTH-1+4:4]; //dout/16
		end
	end
end
endmodule
