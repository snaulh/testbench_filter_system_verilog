////////////////////////////////////////////
//  MODULE: PREWITT_FILTER_SYSTEM
//  3x3 window
//  AUTHOR: VirosTeam
//  Created on Mar 15, 2017
////////////////////////////////////////////
module filter_system #(
    parameter DATA_WIDTH = 8, 
    parameter WIDTH_IMG = 255
  )
  (
    input    wire    clk,
    input    wire    rst,
    input    wire    enable
);
    wire                        stop;
    wire    [15:0]              width;
    wire    [15:0]              high;
    wire    [31:0]              frames;
	wire                        sel;
    wire    [DATA_WIDTH*3-1:0]  rgb_data;
    wire    [DATA_WIDTH*3-1:0]  ycbcr_data;
    wire    [DATA_WIDTH*3-1:0]  ycbcr_data_filtered;
    wire                        data_valid_in, data_valid_out;

counter_control counter_inst (
                .clk            (clk),
                .rst            (rst),
                .enable         (enable),
                .out            (stop),
				.sel_line1      (sel_line1),
				.sel_line2      (sel_line2),
				.data_valid_out (data_valid_out),
                .width          (width), 
                .high           (high),
                .frames         (frames)
);

source    #(
    .DATA_WIDTH(DATA_WIDTH)
    )   source_inst (
                .clk            (clk),
                .rst            (rst),
                .enable         (enable),
                .data_valid_in  (data_valid_in),
                .data           (rgb_data),
                .width          (width), 
                .high           (high),
                .frames         (frames)
);
`ifdef PREWITT_FUNC
rgb2ycbcr  #(
    .DATA_WIDTH(DATA_WIDTH)
    ) rgb2ycbcr_inst (
                .clk            (clk), 
                .rst            (rst),
				.enable         (enable),
                .rgb_data       (rgb_data),
                .ycbcr_data     (ycbcr_data)
);
`else assign ycbcr_data = rgb_data;
`endif
filter_dataflow_in  #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH_IMG(WIDTH_IMG)
    )    filter_dataflow_in_inst0 (
                .clk            (clk), 
                .rst            (rst), 
                .enable         (enable),
				.sel_line1      (sel_line1),
				.sel_line2      (sel_line2),
				.data_valid_in  (data_valid_in),				
                .data_in        (ycbcr_data[7:0]), 
                .data_out       (ycbcr_data_filtered[7:0])
);

filter_dataflow_in  #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH_IMG(WIDTH_IMG)
    )    filter_dataflow_in_inst1 (
                .clk            (clk), 
                .rst            (rst), 
                .enable         (enable),
				.sel_line1      (sel_line1),
				.sel_line2      (sel_line2),
				.data_valid_in  (data_valid_in),
                .data_in        (ycbcr_data[15:8]), 
                .data_out       (ycbcr_data_filtered[15:8])
);

filter_dataflow_in  #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH_IMG(WIDTH_IMG)
    )    filter_dataflow_in_inst2 (
                .clk            (clk), 
                .rst            (rst), 
                .enable         (enable),
				.sel_line1      (sel_line1),
				.sel_line2      (sel_line2),				
				.data_valid_in  (data_valid_in),				
                .data_in        (ycbcr_data[23:16]), 
                .data_out       (ycbcr_data_filtered[23:16])
);

sink    #(
    .DATA_WIDTH(DATA_WIDTH)
    )    sink_inst (
                .clk            (clk), 
                .rst            (rst), 
                .enable         (enable), 
                .stop           (stop), 
                .data           (ycbcr_data_filtered),
                .data_valid_out (data_valid_out),
                .width          (width),
                .high           (high),
                .frames         (frames)    
);

endmodule

