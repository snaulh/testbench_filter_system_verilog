function im = RGB_t2i(text_name)
% Read a image_text file and convert to image file
fid = fopen(text_name,'r');

if (fid)    
        width = fscanf(fid,'%d',1); %WIDTH
        high = fscanf(fid,'%d',1); %HIGH
        frames = fscanf(fid,'%d',1); %FRAMES
        im = zeros(high,width,3);
        for i=1:high
            for j=1:width
                im(i,j,1) = uint8(fscanf(fid,'%d',1)); % R
                im(i,j,2) = uint8(fscanf(fid,'%d',1)); % G
                im(i,j,3) = uint8(fscanf(fid,'%d',1)); % B  
            end 
        end
        
        figure        
        imshow(uint8(im));
        title('Filter by using Verilog');
    
    fclose(fid);
    
end
end