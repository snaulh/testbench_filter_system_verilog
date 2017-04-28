////////////////////////////////////////////
//  MODULE: SOURCE
//  AUTHOR: VirosTeam
//  Created on Mar 18, 2017
////////////////////////////////////////////

module source #(
	parameter     DATA_WIDTH = 8		// 8 IS GREY_IMAGE || 24 IS RGB IMAGE
	)
	(	
	output   reg     [DATA_WIDTH*3-1:0]  data,               // Data per one pixel of image
	output   reg                         data_valid_in,      // That signal confirm that data output are valid
	output   reg     [15:0]              width,              // The width of image input
	output   reg     [15:0]              high,               // The high of image input
	output   reg     [31:0]              frames,             // Number of frames
	input    wire                        clk,                // Clock signal
	input    wire                        rst,                // Reset signal
	input    wire                        enable              // Enable signal
	);

	integer     data_file;               // Return value of file that open
	integer     counter=0;               // Counter
	reg    [31:0]   eor;                 // Define the value that end of reading file
	
	// Initial reading file text_image
	initial begin
		data_file = $fopen("text2img_source.txt", "r"); // Open file with read access
	    
	    // Check file is located or not
			if (data_file == 0)
				begin
						$display("File isnt found");	
						$finish;
				end
	 end
	 
	// Always procedural
	always @(posedge clk or posedge rst) begin
  // Reset signal
		if (rst) begin
			data = 0;
			data_valid_in = 0;
			width = 0;
			high = 0;
			frames = 0;
		end
  // Do if enable are high
		else if(enable) begin
			counter = counter + 1'b1;              // Inscrese Counter
			if (counter==1) begin                  // Reading width of image value
				$fscanf(data_file, "%d", width);     // Store width value into var "width"
				$display("WIDTH = %d", width);       // Display width to transcript
				eor = 1'b0;                          // Set eor = 0
				end
			else if (counter==2) begin             // Reading high of image value
				$fscanf(data_file, "%d", high);      // Store high value into var "high"
				$display("HIGH = %d", high);         // Display high to transcript
				eor = 1'b0;                          // Set eor = 0
				end
			else if (counter==3) begin             // Reading the number of frame of input
				$fscanf(data_file, "%d", frames);    // Store value into var "frames"
				$display("FRAMES = %d", frames);				 // Display frames to transcipt
				
	// Calculate End of Reading point (eor)			
				eor = width*high*frames+3;           // input are GREY_IMAGE 
			end
			// End of reading image's info
			
			// Starting reading pixel value
			else begin
			`ifdef GREY_IMAGE
				$fscanf(data_file, "%d", data);      // 8 bits per once reading (GREY_IMAGE)
			`else                                  // 8 bits per once reading (RGB_IMAGE)
				$fscanf(data_file, "%d", data[DATA_WIDTH-1:0]);     // 8 bit RED
				$fscanf(data_file, "%d", data[DATA_WIDTH*2-1:DATA_WIDTH]);    // 8 bit GREEN
				$fscanf(data_file, "%d", data[DATA_WIDTH*3-1:DATA_WIDTH*2]);   // 8 bit BLUE
			`endif
			end
			
			// Set the signal notify that data is valid for output
			data_valid_in = (counter > eor || (counter < 4)) ? 0 : 1 ;
		end
		
	end
	
endmodule
