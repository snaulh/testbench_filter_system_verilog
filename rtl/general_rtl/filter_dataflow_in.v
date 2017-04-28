module filter_dataflow_in #(
  parameter DATA_WIDTH = 8,
  parameter WIDTH_IMG = 255
  )
  (
  output    wire   [DATA_WIDTH-1:0]    data_out,
  input     wire   [DATA_WIDTH-1:0]    data_in,
  input     wire            sel_line1,
  input     wire            sel_line2,
  input     wire            clk,
  input     wire            rst,
  input     wire            enable,
  input     wire            data_valid_in
);

    wire [DATA_WIDTH-1:0] line1, line2, line3;
    wire [DATA_WIDTH-1:0] w1, w2, w3, w4, w5, w6, w7, w8, w9;
	wire [DATA_WIDTH-1:0] mux1, mux2;
	reg [15:0]           enable_buffer;
	assign line1 = data_in;
	mux_2to1 #(.DATA_WIDTH(DATA_WIDTH)) mux_inst0 (.out(mux1), .sel(sel_line1), .in1(line1), .in2(line2));
	mux_2to1 #(.DATA_WIDTH(DATA_WIDTH)) mux_inst1 (.out(mux2), .sel(sel_line2), .in1(data_in), .in2(line2));


line_buffer #(.WIDTH_IMG(WIDTH_IMG)) line_buffer_inst0 (.clk(clk), .rst(rst), .enable(|enable_buffer), .d(data_in), .q(line2));

line_buffer #(.WIDTH_IMG(WIDTH_IMG)) line_buffer_inst1 (.clk(clk), .rst(rst), .enable(|enable_buffer),	.d(mux2), .q(line3));

window_scan #(.DATA_WIDTH(DATA_WIDTH))window_scan_inst (
        .clk(clk),     .rst(rst),      .enable(enable), 
        .in1(mux1),   .in2(line2),    .in3(line3), 
        .out1(w1),     .out2(w2),      .out3(w3),
        .out4(w4),     .out5(w5),      .out6(w6), 
        .out7(w7),     .out8(w8),      .out9(w9));			

`ifdef PREWITT_FUNC
prewitt_func prewitt_func_inst (.clk(clk), .rst(rst), .enable(enable), 
		.in1(w9), .in2(w8), .in3(w7), 
		.in4(w6), .in5(w5), .in6(w4), 
		.in7(w3), .in8(w2), .in9(w1), .data_out(data_out));		
`else `ifdef MEAN_FUNC
mean_func mean_func_inst (.clk(clk), .rst(rst), .enable(enable), 
		.in1(w9), .in2(w8), .in3(w7), 
		.in4(w6), .in5(w5), .in6(w4), 
		.in7(w3), .in8(w2), .in9(w1), .data_out(data_out));
`else `ifdef GAUSSIAN_FUNC
gaussian_func gaussian_func_inst (.clk(clk), .rst(rst), .enable(enable), 
		.in1(w9), .in2(w8), .in3(w7), 
		.in4(w6), .in5(w5), .in6(w4), 
		.in7(w3), .in8(w2), .in9(w1), .data_out(data_out));
`else
sobel_func sobel_func_inst (.clk(clk), .rst(rst), .enable(enable), 
		.in1(w9), .in2(w8), .in3(w7), 
		.in4(w6), .in5(w5), .in6(w4), 
		.in7(w3), .in8(w2), .in9(w1), .data_out(data_out));
`endif
`endif
`endif
always @(posedge clk or posedge rst) begin
		if(rst) enable_buffer = 1'b0;
		else if(data_valid_in) enable_buffer = WIDTH_IMG;
		else enable_buffer = enable_buffer - 1'b1;
	end
endmodule

