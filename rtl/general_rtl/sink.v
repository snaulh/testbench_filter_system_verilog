////////////////////////////////////////////
//  MODULE: SINK
//  AUTHOR: VirosTeam
//  Created on Mar 18, 2017
////////////////////////////////////////////

module sink 
  #(
    parameter DATA_WIDTH = 8		// 8 IS GREY_IMAGE || 24 IS RGB IMAGE
  )
  (
 	input     wire    [DATA_WIDTH*3-1:0]  data,                // Data per one pixel of image
	input     wire    [15:0]            width,               // The width of image input
	input     wire    [15:0]            high,                // The high of image input
	input     wire    [15:0]            frames,              // Number of frames 
	input     wire                      data_valid_out,       // That signal confirm that data input are valid
	input     wire                      stop,                 // Stop transfer signal
    input     wire                      clk,
	input     wire                      rst,
	input     wire                      enable
  );
  
	integer data_file;             // Return value of file that open to write
	reg     write_info=1'b0;
	// Initial create file to write
	initial begin
      data_file = $fopen("text2img_sink.txt", "w");   //Create file for writing value
	 // Check progress is completed without errors
	 if (data_file == 0)
		begin
			$display("File isnt created!");	
		  $finish;     // Break if file cant be created
   	end 
   end
   
   // Always procedural
   // Writing value
  always @(posedge clk) begin
    // If data input is valid and data input isnt enough, write value
    if (data_valid_out) begin
		if (!write_info) begin
			$fwrite(data_file, "%d\n", width);
			$fwrite(data_file, "%d\n", high);
			$fwrite(data_file, "%d\n", frames);
			write_info = !write_info;
			end
		   `ifdef GREY_IMAGE
				 $fwrite(data_file, "%d\n", data);         // Write 8bit GREY_IMAGE for 1 pixel
			`else
				 $fwrite(data_file, "%d\n", data[DATA_WIDTH-1:0]);    // Write 8 bit RED
				 $fwrite(data_file, "%d\n", data[DATA_WIDTH*2-1:DATA_WIDTH]);   // Write 8 bit GREEN
				 $fwrite(data_file, "%d\n", data[DATA_WIDTH*3-1:DATA_WIDTH*2]);  // Write 8 bit BLUE
			`endif

		end
	if (stop) begin
			  $fclose	(data_file);
			  $finish;   // Finish process
				// End write and close file if data is enough
			end
	end
endmodule

