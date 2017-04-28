function im = RGB_t2i(text_name)
I = imread(text_name);
BW = edge(I,'sobel','vertical');
imshow(I);
title('Sobel filter by using Matlab');