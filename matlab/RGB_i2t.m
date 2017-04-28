function t = RGB_i2t(image_name, text_name)
% Read a RGB image file and write to YCbCr text files
% for Y, Cb, and Cr channels
% ---------------------------
% The format of text file:
% W  ; Width size
% H  ; Height size
% N  ; number of frame
% XXXXXX ; YCbCr data in Hex
% XXXXXX
% .....
% ---------------------------
im = imread(image_name);
fid = fopen(text_name,'W'); 

imsize = size(im);
if (fid)     
   
        fprintf(fid,'%d\n', imsize(2));% write WIDTH value
        fprintf(fid,'%d\n', imsize(1));% write HEIGHT value
        fprintf(fid,'%d\n', 1);
        for i=1:imsize(1)
            for j=1:imsize(2)
                fprintf(fid,'%d\n',im(i,j,1));
                fprintf(fid,'%d\n',im(i,j,2));
                fprintf(fid,'%d\n',im(i,j,3));
            end    
        end  
   
    fclose(fid);
    t = 0; % successful
else
    t = 1; % error
end
end




    
    