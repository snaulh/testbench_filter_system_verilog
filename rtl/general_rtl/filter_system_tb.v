   /*	DEFINE PARAGPARH */
   		//`define PREWITT_FUNC
		//`define MEAN_FUNC
		//`define GAUSSIAN_FUNC
		`define SOBEL_FUNC
	// INCLUDE GENERAL RTL CODE (FILTER SYSTEM CODE)
        `include "../rtl/general_rtl/counter_control.v"
        `include "../rtl/general_rtl/D_FF.v"
        `include "../rtl/general_rtl/line_buffer.v"
        `include "../rtl/general_rtl/filter_system.v"
        `include "../rtl/general_rtl/filter_dataflow_in.v"
        `include "../rtl/general_rtl/rgb2ycbcr.v"
        `include "../rtl/general_rtl/sink.v"
        `include "../rtl/general_rtl/source.v"
        `include "../rtl/general_rtl/window_scan.v"
		`include "../rtl/general_rtl/mux_2to1.v"
		
	// INCLUDE FILTER TYPE
		`include "../rtl/filter_collection/prewitt_func.v"
		`include "../rtl/filter_collection/mean_func.v"
		`include "../rtl/filter_collection/gaussian_func.v"
		`include "../rtl/filter_collection/sobel_func.v"
module filter_system_tb ();
	reg clk; 
	reg rst;
	reg enable;
	parameter DATA_WIDTH = 8;
filter_system 	#(
    .WIDTH_IMG(300),  
	.DATA_WIDTH(DATA_WIDTH)) prewitt_system_inst (
	                .clk(clk), 
					.rst(rst), 
					.enable(enable)
			);
			
			
always #1 clk = ~clk;
initial begin
		clk = 0;
		rst = 1;
	 	enable = 0;		
	#10	rst = 0;
		enable = 1;
end
endmodule
