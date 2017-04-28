function im = RGB_t2i(text_name)
I = imread(text_name);
H = fspecial('average', [5 5]);
I = imfilter(I, H);
imshow(I);
title('Mean filter by using Matlab');