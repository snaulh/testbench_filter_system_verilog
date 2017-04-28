
////////////////////////////////////////////
//  MODULE: MEAN_FILTER_FUNCTION
//  3x3 window
//  AUTHOR: VirosTeam
//  Created on Mar 15, 2017
////////////////////////////////////////////
module mean_func  #(
        parameter DATA_WIDTH=8
  )
  (
        output    wire   [DATA_WIDTH-1:0]    data_out,
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
	reg  [DATA_WIDTH+1:0] dout;
	assign data_out = dout;
	wire [DATA_WIDTH+1:0] w12, w34, w56, w78, w1234, w5678, w12345678;
	assign w12 = in1 + in2;
	assign w34 = in3 + in4;
	assign w56 = in5 + in6;
	assign w78 = in7 + in8;
	assign w1234 = w12 + w34;
	assign w5678 = w56 + w78;
	assign w1to8 = w1234 + w5678;
	assign w1to9 = w1to8 + in9;
	assign w_out = w1to9/9;
	always@(posedge clk or posedge rst)
	begin
	if (rst==1) 
        begin
        	dout<=9'b0;
        end
	else if(enable==1)
        begin      
        	dout <= w_out;
        end
end
endmodule
