%edge detection using sobel operator
phase2_img=imread('G:\fyproject\jaffeimages\jaffecrop\13.tiff');
phase2_img_mod=rgb2gray(phase2_img);
k=1;
l=1;
flag=0;
for i=1:size(phase2_img_mod,1)
    for j=1:size(phase2_img_mod,2)
        if(phase2_img_mod(i,j)~=255)
            phase2_temp_image(k,l)=phase2_img_mod(i,j);
            l=l+1;    
            flag=1;
        end
    end
    if(flag==1)
     k=k+1
    l=1;
    end
end
% imshow(temp_image);
% image_modify=rgb2gray(image);
% hist_image=histeq(image_modify);
% imshow(hist_image);
phase2_db_img=double(phase2_temp_image);

for i=1:size(phase2_db_img,1)-2
    for j=1:size(phase2_db_img,2)-2
        %Sobel mask for x-direction:
        Gx=((2*phase2_db_img(i+2,j+1)+phase2_db_img(i+2,j)+phase2_db_img(i+2,j+2))-(2*phase2_db_img(i,j+1)+phase2_db_img(i,j)+phase2_db_img(i,j+2)));
        %Sobel mask for y-direction:
        Gy=((2*phase2_db_img(i+1,j+2)+phase2_db_img(i,j+2)+phase2_db_img(i+2,j+2))-(2*phase2_db_img(i+1,j)+phase2_db_img(i,j)+phase2_db_img(i+2,j)));
      
        %The gradient of the image
        %B(i,j)=abs(Gx)+abs(Gy);
        phase2_temp_image(i,j)=sqrt(Gx.^2+Gy.^2);
      
    end
end


sum_thres=zeros(1,255);
for a=1:size(phase2_db_img,1)
    for b=1:size(phase2_db_img,2)
        c=phase2_db_img(a,b);
        if (c==0)
        sum_thres(c+1)=sum_thres(c+1)+1;
        else
        sum_thres(c)=sum_thres(c)+1;
        end    
    end
end
% Thresholding 
 T_max=max(sum_thres);
 T=find(sum_thres,T_max);
[T_val,T] = max(sum_thres);
thres_img = zeros(size(phase2_db_img,1),size(phase2_db_img,2));
for i=1:size(phase2_db_img,1)
    for j=1:size(phase2_db_img,2)
        if(I(i,j)>=T_val)
            thres_img(i,j)=0;
        else
            thres_img(i,j)=255;
        end
    end
end
figure(1)
imshow(thres_img);
% figure(2)
% figure,imshow(phase2_temp_image);

