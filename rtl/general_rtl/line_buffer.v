////////////////////////////////////////////
//  MODULE: LINE_BUFFER_USING_SHIFT_REGISTER
//  AUTHOR: VirosTeam
//  Created on Mar 15, 2017
////////////////////////////////////////////
module line_buffer #(
	parameter DATA_WIDTH = 8,
    parameter WIDTH_IMG = 255
    )
    (
	output     wire     [DATA_WIDTH-1:0]    q,
	input      wire     [DATA_WIDTH-1:0]    d,
	input      wire                    clk,
	input      wire                    rst,
	input      wire                    enable
);
    
  wire [DATA_WIDTH-1:0] buffer [0:WIDTH_IMG];
  //generate function
  genvar i;
  generate
    for (i=0; i<WIDTH_IMG; i=i+1) 
    begin: DFF0
    D_FF DFF_inst
             (.clk(clk),
              .rst(rst),
              .enable(enable),
              .d(buffer[i]),
              .q(buffer[i+1])  
        );
    end
  endgenerate 
  //assignments
  assign buffer[0] = d;
  assign q = buffer[WIDTH_IMG];
endmodule


