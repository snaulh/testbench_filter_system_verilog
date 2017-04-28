////////////////////////////////////////////
//  MODULE: D_FLIPFLOP
//  AUTHOR: VirosTeam
//  Created on Mar 15, 2017
////////////////////////////////////////////
module D_FF #(
	parameter DATA_WIDTH = 8
	)
    (
        output    reg   [DATA_WIDTH-1:0]    q,
		input     wire  [DATA_WIDTH-1:0]    d,
		input     wire                      clk,
		input     wire                      rst,
		input     wire                      enable
);

    always@(posedge clk or posedge rst)
        begin
            if (rst==1)
                q = 0;
            else if(enable==1)
                q = d;
        end
endmodule
