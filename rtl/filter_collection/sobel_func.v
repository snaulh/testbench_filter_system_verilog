
////////////////////////////////////////////
//  MODULE: SOBEL_FILTER_FUNCTION
//  3x3 window
//  AUTHOR: VirosTeam
//  Created on Mar 31, 2017
////////////////////////////////////////////
module sobel_func  #(
        parameter DATA_WIDTH=8
  )
  (
        output    wire    [DATA_WIDTH-1:0]    data_out,
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
	reg  [DATA_WIDTH+1:0] add1;
	reg  [DATA_WIDTH+1:0] add2;
	reg  [DATA_WIDTH+1:0] add3;
	reg  [DATA_WIDTH+1:0] add4;
	reg  [DATA_WIDTH+1:0] gx;
	reg  [DATA_WIDTH+1:0] gy;
	reg  [DATA_WIDTH+1:0] max;
	reg  [DATA_WIDTH+1:0] min;
	reg  [DATA_WIDTH+1:0] result;
	assign data_out = dout;
	always@(posedge clk or posedge rst)
	begin
	if (rst==1) 
        begin
        	dout<=11'b0;
        end
	else if(enable==1)
        begin        
			add1 <= in3 + 2*in6 + in9;
			add2 <= in1 + 2*in4 + in7;
			add3 <= in1 + 2*in2 + in3;
			add4 <= in7 + 2*in8 + in9;
        	gy <= (add1>add2)?add1-add2:add2-add1;
			gx <= (add3>add4)?add3-add4:add4-add3;
			if ( gx >= gy )
				begin	
					max <= gx - gx>>3;
					min <= gy>>1;
					result <= max + min;
				end
			else
				begin
					max <= gy - gy>>3;
					min <= gy>>1;
					result <= max + min;
				end
			if ( result >= max )
				begin
					dout <= result;
				end
			else
				begin
					dout <= max;
				end
        end
end
endmodule
