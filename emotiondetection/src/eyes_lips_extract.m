%extraction of eyes and nose
clear all;
phase3_img=imread('G:\fyproject\sobel_img_13.tif');
phase3_img_mod=rgb2gray(phase3_img);

phase3_img_len=size(phase3_img_mod,1);
phase3_img_wid=size(phase3_img_mod,2);
k=1;
l=1;
for i=floor(((phase3_img_len)/6)):((phase3_img_len)/2)
    for j=1:phase3_img_wid
        phase3_eye_img(k,l)=phase3_img_mod(i,j);
        l=l+1;
    end
    k=k+1;
    l=1;
end

phase3_eye_img_len=size(phase3_eye_img,1);
phase3_eye_img_wid=size(phase3_eye_img,2);
rand_var=floor((phase3_eye_img_wid)/3);
p=1;
for a=rand_var:phase3_eye_img_wid-rand_var
    phase3_array(a)=sum(phase3_eye_img(:,a));
    phase3_sum(p)=phase3_array(a);
    p=p+1;
    
end
phase3_sum_min=min(phase3_sum);
col=find(phase3_array==phase3_sum_min);

for e_l=1:col
    phase3_left_eye(:,e_l)=phase3_eye_img(:,e_l);
end

for e_t=col:phase3_eye_img_wid
    phase3_right_eye_temp(:,e_t)=phase3_eye_img(:,e_t);
end

e_r=1;
for e_t=col:phase3_eye_img_wid
    phase3_right_eye(:,e_r)=phase3_right_eye_temp(:,e_t);
    e_r=e_r+1;
end


%Extraction of lips

l_temp_r=1;
l_temp_c=1;
for l_r=floor((phase3_img_len)/2):phase3_img_len
    for l_c=floor((phase3_img_wid)/4):floor(3*(phase3_img_wid)/4) % the column span can be varied from 1/3 to 2/3 also 
    phase3_lips_img(l_temp_r,l_temp_c)=phase3_img_mod(l_r,l_c);
    l_temp_c=l_temp_c+1;
    end
    l_temp_r=l_temp_r+1;
    l_temp_c=1;
end

% figure(1);
% imshow(phase3_left_eye);
% figure(2);
% imshow(phase3_right_eye);
% % figure(3);
% % imshow(phase3_eye_img);
% figure(3);
% imshow(phase3_lips_img);
% 
% se=strel('line',1,1);
% data=imdilate(phase3_left_eye,se);
% se=strel('square',1);
% data=imerode(data,se);
data_bg_l=im2bw(phase3_left_eye,0.65);
data_bg_r=im2bw(phase3_right_eye,0.65);
data_bg_lips=im2bw(phase3_lips_img,0.65);
% data_bg_l_temp=im2bw(phase3_left_eye_temp,0.65);

data_bg_l_save=figure(4);
imshow(data_bg_l);
options.Format = 'tiff';
hgexport(data_bg_l_save,'G:\fyproject\jaffeimages\left1.tiff',options);
data_bg_r_save=figure(5);
imshow(data_bg_r);
options.Format = 'tiff';
hgexport(data_bg_r_save,'G:\fyproject\jaffeimages\right1.tiff',options);
data_bg_lips_save=figure(6);
imshow(data_bg_lips);
options.Format = 'tiff';
hgexport(data_bg_lips_save,'G:\fyproject\jaffeimages\lips1.tiff',options);

% figure(7);
% imshow(data_bg_l_temp);


% [centers, radii, metric]=imfindcircles(data,[15 30])
% centersStrong2=centers(1:5,:);
% radii2=radii(1:5);
% metric2=metric(1:5);
% viscircles(centersStrong2,radii2,'EdgeColor','b');

% data_noise=imnoise(data,'gaussian',0,0.025);
% data_noise2=wiener2(data_noise,[5 5]);
% imshow(data_noise2);
% data_adjust=imadjust(data);
% figure(1);
% imshow(data_bg);
% figure(2);
% imshow(data);
% phase3_hist_eye=histeq(data)
% b=imcomplement(phase3_hist_eye);
% figure(2);
% imshow(b);
% figure(2);
% imshow(phase3_hist_eye);
% phase3_sharp_eye=imsharpen(uint8(phase3_eye_img));
% figure(3);
% imshow(phase3_sharp_eye);
%         
% sb_img=rgb2gray(sobel_image);
% k=1;
% l=1;
% flag=0;
% for i=1:size(sb_img,1)
%     for j=1:size(sb_img,2)
%         if(sb_img(i,j)~=255)
%             sb_temp(k,l)=sb_img(i,j);
%             l=l+1;    
%             flag=1;
%         end
%     end
%     if(flag==1)
%      k=k+1;
%     l=1;
%     end
% end

% imshow(phase3_img_mod);