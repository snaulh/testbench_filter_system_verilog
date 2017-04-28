
////////////////////////////////////////////
//  MODULE: WINDOW_SCAN
//  3x3 window
//  AUTHOR: VirosTeam
//  Created on Mar 15, 2017
////////////////////////////////////////////
module window_scan #(
    parameter DATA_WIDTH = 8
    )
        (
        output   wire   [DATA_WIDTH-1:0]  out1,
        output   wire   [DATA_WIDTH-1:0]  out2,
        output   wire   [DATA_WIDTH-1:0]  out3,
        output   wire   [DATA_WIDTH-1:0]  out4,
        output   wire   [DATA_WIDTH-1:0]  out5,
        output   wire   [DATA_WIDTH-1:0]  out6,
        output   wire   [DATA_WIDTH-1:0]  out7,
        output   wire   [DATA_WIDTH-1:0]  out8,
        output   wire   [DATA_WIDTH-1:0]  out9,         
        input    wire   [DATA_WIDTH-1:0]  in1,
        input    wire   [DATA_WIDTH-1:0]  in2,
        input    wire   [DATA_WIDTH-1:0]  in3,		
        input    wire                     clk, 
		input    wire                     rst, 
		input    wire                     enable
);
D_FF   D_FF_inst1 (.clk(clk), .rst(rst), .enable(enable), .d(in1), .q(out1));
D_FF   D_FF_inst2 (.clk(clk), .rst(rst), .enable(enable), .d(in2), .q(out4));
D_FF   D_FF_inst3 (.clk(clk), .rst(rst), .enable(enable), .d(in3), .q(out7));
                                                     
D_FF   D_FF_inst4 (.clk(clk), .rst(rst), .enable(enable), .d(out1), .q(out2));
D_FF   D_FF_inst5 (.clk(clk), .rst(rst), .enable(enable), .d(out4), .q(out5));
D_FF   D_FF_inst6 (.clk(clk), .rst(rst), .enable(enable), .d(out7), .q(out8));
                                                      
D_FF   D_FF_inst7 (.clk(clk), .rst(rst), .enable(enable), .d(out2), .q(out3));
D_FF   D_FF_inst8 (.clk(clk), .rst(rst), .enable(enable), .d(out5), .q(out6));
D_FF   D_FF_inst9 (.clk(clk), .rst(rst), .enable(enable), .d(out8), .q(out9));

endmodule
