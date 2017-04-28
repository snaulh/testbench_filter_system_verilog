module counter_control (
output reg out, //STOP SIGNAL
output reg data_valid_out, //WRITE SIGNAL
output reg sel_line1,
output reg sel_line2,
input wire [15:0] width,
input wire [15:0] high,
input wire [31:0] frames,
input wire clk,
input wire rst,
input wire enable
);
reg [63:0] counter=1'b0;
always @(posedge clk or posedge rst) begin
  if (rst) begin
   out = 1'b0; 
   counter = 1'b0;         
  end
  else if(enable) begin
   counter = counter + 1'b1;
    if(counter == width*high*frames + (width-1) + 9)
    out = 1'b1;
   end
 end
 
always @(posedge clk) begin
  if(counter < width*high + 3)
		sel_line1 = 1'b0;
	else sel_line1 = 1'b1;
end

always @(posedge clk) begin
  if(counter < width + 5)
		sel_line2 = 1'b0;
	else sel_line2 = 1'b1;
end


 
 always @(posedge clk) begin
	if(counter > (width-1) + 9) data_valid_out = 1'b1;
		else data_valid_out = 1'b0;
 
 end
  
endmodule