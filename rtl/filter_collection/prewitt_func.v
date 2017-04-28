
////////////////////////////////////////////
//  MODULE: PREWITT_FILTER_FUNCTION
//  3x3 window
//  AUTHOR: VirosTeam
//  Created on Mar 15, 2017
////////////////////////////////////////////
module prewitt_func  #(
        parameter DATA_WIDTH=8
  )
  (
        output    reg    [DATA_WIDTH-1:0]    data_out,
        input     wire   [DATA_WIDTH-1:0]    in1,
        input     wire   [DATA_WIDTH-1:0]    in2,
        input     wire   [DATA_WIDTH-1:0]    in3,
        input     wire   [DATA_WIDTH-1:0]    in4,
        input     wire   [DATA_WIDTH-1:0]    in5,
        input     wire   [DATA_WIDTH-1:0]    in6,
        input     wire   [DATA_WIDTH-1:0]    in7,
        input     wire   [DATA_WIDTH-1:0]    in8,
        input     wire   [DATA_WIDTH-1:0]    in9,
        input     wire                       clk,
        input     wire                       rst,
        input     wire                       enable
);
	reg  [DATA_WIDTH+1:0] dout_abs;
	reg  [DATA_WIDTH+1:0] doutx;
	reg  [DATA_WIDTH+1:0] douty;
	wire [DATA_WIDTH+1:0] add1;
	wire [DATA_WIDTH+1:0] add2;
	wire [DATA_WIDTH+1:0] add3;
	wire [DATA_WIDTH+1:0] add4;
	assign add1 = in7+in8+in9;
	assign add2 = in1+in2+in3;
	assign add3 = in3+in6+in9;
	assign add4 = in1+in4+in7;
	always@(posedge clk or posedge rst)
	begin
	if (rst==1) 
        begin
        	doutx<=11'b0;
            douty<=11'b0;
        	dout_abs<=11'b0;
        	data_out<=9'b0;
        end
	else if(enable==1)
        begin        
        	doutx=(add1>add2)?add1-add2:add2-add1;        	
        	douty=(add3>add4)?add3-add4:add4-add3;
        	dout_abs <= (doutx+douty)/2;
        	data_out<=dout_abs[8:0];
        end
end
endmodule
