img=imread('../data_inout/cameraman.jpg');
s=size(img);
img1=zeros(s);
output_img=zeros(s);
output_img_rgb=zeros(s);
for i=1:s(1)
    for j=1:s(2)
            img1(i,j,1)=(0.257*img(i,j,1))+(0.504*img(i,j,2))+(0.098*img(i,j,3))+16;
			img1(i,j,2)=(0.439*img(i,j,3))-(0.148*img(i,j,1))-(0.291*img(i,j,2))+128;
			img1(i,j,3)=(0.439*img(i,j,1))-(0.368*img(i,j,2))-(0.011*img(i,j,3))+128;
    end
end
for i=1:s(1)-2
    for j=1:s(2)-2
        w1=img1(i:i+2,j:j+2,1);
        w2=img1(i:i+2,j:j+2,2);
        w3=img1(i:i+2,j:j+2,3);
        datax1=0;
        datay1=0;
        datax2=0;
        datay2=0;
        datax3=0;
        datay3=0;
        if (w1(1,1)+w1(1,2)+w1(1,3))>(w1(3,1)+w1(3,2)+w1(3,3))
            datax1=(w1(1,1)+w1(1,2)+w1(1,3))-(w1(3,1)+w1(3,2)+w1(3,3));
        else
            datax1=(w1(3,1)+w1(3,2)+w1(3,3))-(w1(1,1)+w1(1,2)+w1(1,3));
        end
        if (w1(1,1)+w1(2,1)+w1(3,1))>(w1(1,3)+w1(2,3)+w1(3,3))
            datay1=(w1(1,1)+w1(2,1)+w1(3,1))-(w1(1,3)+w1(2,3)+w1(3,3));
        else
            datay1=(w1(1,3)+w1(2,3)+w1(3,3))-(w1(1,1)+w1(2,1)+w1(3,1));
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if (w2(1,1)+w2(1,2)+w2(1,3))>(w2(3,1)+w2(3,2)+w2(3,3))
            datax2=(w2(1,1)+w2(1,2)+w2(1,3))-(w2(3,1)+w2(3,2)+w2(3,3));
        else
            datax2=(w2(3,1)+w2(3,2)+w2(3,3))-(w2(1,1)+w2(1,2)+w2(1,3));
        end
        if (w2(1,1)+w2(2,1)+w2(3,1))>(w2(1,3)+w2(2,3)+w2(3,3))
            datay2=(w2(1,1)+w2(2,1)+w2(3,1))-(w2(1,3)+w2(2,3)+w2(3,3));
        else
            datay2=(w2(1,3)+w2(2,3)+w2(3,3))-(w2(1,1)+w2(2,1)+w2(3,1));
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if (w3(1,1)+w3(1,2)+w3(1,3))>(w3(3,1)+w3(3,2)+w3(3,3))
            datax3=(w3(1,1)+w3(1,2)+w3(1,3))-(w3(3,1)+w3(3,2)+w3(3,3));
        else
            datax3=(w3(3,1)+w3(3,2)+w3(3,3))-(w3(1,1)+w3(1,2)+w3(1,3));
        end
        if (w3(1,1)+w3(2,1)+w3(3,1))>(w3(1,3)+w3(2,3)+w3(3,3))
            datay3=(w3(1,1)+w3(2,1)+w3(3,1))-(w3(1,3)+w3(2,3)+w3(3,3));
        else
            datay3=(w3(1,3)+w3(2,3)+w3(3,3))-(w3(1,1)+w3(2,1)+w3(3,1));
        end
        
        output_img(i,j,1)=0.5*(abs(datax1)+abs(datay1));
        output_img(i,j,2)=0.5*(abs(datax2)+abs(datay2));
        output_img(i,j,3)=0.5*(abs(datax3)+abs(datay3));
        
    end
end    
    
img1=uint8(img1);
output_img=uint8(output_img);

figure
imshow(img);
title('Anh goc');

figure
imshow(img1);
title('Anh doi tu RGB sang YCbCr dung Matlab');

figure
imshow(output_img);
title('Anh Ycbcr loc prewitt dung Matlab');
