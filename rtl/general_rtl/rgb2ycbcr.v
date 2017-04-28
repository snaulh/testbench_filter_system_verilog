////////////////////////////////////////////
//  MODULE: RGB2YCBCR
//  AUTHOR: VirosTeam
//  Created on Mar 18, 2017
////////////////////////////////////////////
module rgb2ycbcr #(
	parameter DATA_WIDTH = 8
	)
	(
    output    reg   [DATA_WIDTH*3-1:0]    ycbcr_data,
	input     wire  [DATA_WIDTH*3-1:0]    rgb_data,
	input     wire            clk,
	input     wire            rst,
	input     wire            enable
);

    wire [DATA_WIDTH-1:0] y,cb,cr;

    assign y = (0.257*rgb_data[DATA_WIDTH-1:0])+(0.504*rgb_data[DATA_WIDTH*2-1:DATA_WIDTH])+(0.098*rgb_data[DATA_WIDTH*3-1:DATA_WIDTH*2])+16;
    assign cb = (0.439*rgb_data[DATA_WIDTH*3-1:DATA_WIDTH*2])-(0.148*rgb_data[DATA_WIDTH-1:0]) - (0.291*rgb_data[DATA_WIDTH*2-1:DATA_WIDTH])+128;
    assign cr = (0.439*rgb_data[DATA_WIDTH-1:0])-(0.368*rgb_data[DATA_WIDTH*2-1:DATA_WIDTH])-(0.071*rgb_data[DATA_WIDTH*3-1:DATA_WIDTH*2])+128;		
	 
    always@(posedge clk or posedge rst) begin	
		if (!(rst)==0)
			begin			
			ycbcr_data = 23'b0;
			end		
		else if (enable && rgb_data) 	
			begin		
            ycbcr_data[DATA_WIDTH-1:0]     <= y;
            ycbcr_data[DATA_WIDTH*2-1:DATA_WIDTH]    <= cb;
            ycbcr_data[DATA_WIDTH*3-1:DATA_WIDTH*2]   <= cr;			
			end					
end

endmodule
