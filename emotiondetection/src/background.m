%Preprocessing the image when saving
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
h=figure,imshow(phase2_temp_image);
saveas(h,'G:\fyproject\try.tiff');
