%Main code to detect eyebrows,eyes and lips form the image

%detect Eyes
clear all;
EyeDetect = vision.CascadeObjectDetector('EyePairBig');

%Read the input Image
% path='G:\fyproject\jaffeimages\jaffecrop\79.tiff';
path='G:\fyproject\test_images_output\test_img2.tif';
I = imread(path);
I_double=double(I);
BB=step(EyeDetect,I);
% figure,imshow(I);
% rectangle('Position',BB,'LineWidth',4,'LineStyle','-','EdgeColor','b');
% title('Eyes Detection');
Eyes=imcrop(I,BB);
% figure,imshow(Eyes);

%To detect Mouth
k=1;
l=1;
if(size(I,3)>1)
    I1=rgb2gray(I);
else
    I1=I;
end
% imshow(I1);
for i=floor(7*(size(I1,1))/12):size(I1,1)
    for j=1:size(I1,2)
        i_crop(k,l)=I1(i,j);
        l=l+1;
    end
    k=k+1;
    l=1;
end
% imshow(i_crop);
MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',30);
BB_mouth=step(MouthDetect,i_crop);
% figure,
% imshow(i_crop); hold on
for i = 1:size(BB_mouth,1)
rectangle('Position',BB_mouth(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
end
% title('Mouth Detection');
% hold off;

% calculating threshold
sum_thres=zeros(1,255);
for a=1:size(I1,1)
    for b=1:size(I1,2)
        c=I1(a,b);
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
thres_img = zeros(size(I1,1),size(I1,2));
for i=1:size(I1,1)
    for j=1:size(I1,2)
        if(I1(i,j)>=105)
            thres_img(i,j)=0;
        else
            thres_img(i,j)=255;
        end
    end
end
% figure(1)
% imshow(thres_img);
img_eyebrow=crop_eyebrow(thres_img,BB);
% figure(2)
% imshow(img_eyebrow);
% % img_eyebrow= bwmorph(img_eyebrow,'remove');
% % imshow(img_eyebrow);
[col1,col2]=histogram_columns(img_eyebrow);
row=histogram_rows(img_eyebrow);
[plotx,ploty]=cal_points(thres_img,col1,col2,row);
plot_template(plotx,ploty,path);



% %Morphology on the image
thres_img = morph_four_neigh(thres_img);
% figure(1);
% imshow(thres_img);

x_e=1;
y_e=1; 
for a_e=BB(2):BB(2)+BB(4)
    for b_e=BB(1):BB(1)+BB(3)
        img_e(x_e,y_e)=thres_img(a_e,b_e);
        y_e=y_e+1;
    end
    x_e=x_e+1;
    y_e=1;
end
%  figure(2),imshow(img_e);


% %Histogram of the eyes along columns

sum_h_e_c=zeros(1,size(img_e,2));
for a_h_c=1:size(img_e,2)
    for b_h_c=1:size(img_e,1)
        if(img_e(b_h_c,a_h_c)>=255)
        sum_h_e_c(a_h_c)=sum_h_e_c(a_h_c)+img_e(b_h_c,a_h_c);
        end
    end
end
%left eye
wide_col=size(sum_h_e_c,2);
for l_p=1:floor((wide_col)/2)
    left_h_c(l_p)=sum_h_e_c(l_p);
end
%Extracting points on the left eye
[l_e_val(2),l_e(2)] = max(left_h_c);

l_e(1)=l_e(2);
for x_l_l=1:l_e(2)
    ycor=left_h_c(x_l_l);
    if(ycor<left_h_c(l_e(1)))
        l_e(1)=x_l_l;
    end
end
l_e(3)=l_e(2);
for x_l_r=l_e(2)+1:size(left_h_c,2)
    ycor=left_h_c(x_l_r);
    if(ycor<left_h_c(l_e(3)))
        l_e(3)=x_l_r;
    end
end
l_e(2)=floor((l_e(3)+l_e(1))/2);

r_p_in=1;
for r_p=floor((wide_col)/2)+1:wide_col
    right_h_c(r_p_in)=sum_h_e_c(r_p);
    r_p_in=r_p_in+1;
end

%Extracting points on the right eye
[r_e_val(2),r_e(2)] = max(right_h_c);
r_e(1)=r_e(2);
for x_r_l=r_e(2):-1:1
    ycor=right_h_c(x_r_l);
    if(ycor<right_h_c(r_e(1)))
        r_e(1)=x_r_l;
        if(ycor==0)
            break;
        end
    end
end

r_e(3)=r_e(2);

for x_r_r=r_e(2)+1:size(right_h_c,2)
    ycor=right_h_c(x_r_r);
   
    if(ycor<right_h_c(r_e(3)))
        r_e(3)=x_r_r;
        if(ycor==0)
            break;
        end
    end
end
r_e(2)= r_e(2) + floor(wide_col/2)+1;
r_e(1)= r_e(1) + floor(wide_col/2)+1;
r_e(3)= r_e(3) + floor(wide_col/2)+1;

r_e(2)=floor((r_e(1)+r_e(3))/2);

% %histogram of the eyes along rows


sum_h_e_r=zeros(1,size(img_e,1));
for a_h_r=1:size(img_e,1)
    for b_h_r=1:size(img_e,2)
        if(img_e(a_h_r,b_h_r)>=255)
            sum_h_e_r(a_h_r)=sum_h_e_r(a_h_r)+img_e(a_h_r,b_h_r);
        end
    end
end

%Extracting points on along rows
[e_r_val,e_r(2)]=max(sum_h_e_r);

e_r(1)=e_r(2);
for x_u=1:e_r(2)
    ycor=sum_h_e_r(x_u);
    if(ycor<sum_h_e_r(e_r(1)))
        e_r(1)=x_u;
    end
end

e_r(3)=e_r(2);

for x_d=e_r(2)+1:size(sum_h_e_r,2)
    ycor=sum_h_e_r(x_d);
    if(ycor<sum_h_e_r(e_r(3)))
        e_r(3)=x_d;
    end
end
e_x(1)=l_e(1)+BB(1);
e_y(1)=e_r(2)+BB(2);

e_x(2)=l_e(2)+BB(1);
e_y(2)=e_r(1)+BB(2);

e_x(3)=l_e(3)+BB(1);
e_y(3)=e_r(2)+BB(2);

e_x(4)=l_e(2)+BB(1);
e_y(4)=e_r(3)+BB(2);

e_x(5)=r_e(1)+BB(1);
e_y(5)=e_r(2)+BB(2);

e_x(6)=r_e(2)+BB(1);
e_y(6)=e_r(1)+BB(2);

e_x(7)=r_e(3)+BB(1);
e_y(7)=e_r(2)+BB(2);

e_x(8)=r_e(2)+BB(1);
e_y(8)=e_r(3)+BB(2);

figure(7);
plot_template(e_x,e_y,path);

%Thresholding on the crop part 
for i=1:size(i_crop,1)
    for j=1:size(i_crop,2)
        if(i_crop(i,j)>=105)
            thres_img_l(i,j)=0;
        else
            thres_img_l(i,j)=255;
        end
    end
end

% thres_img_l = bwareaopen(thres_img_l,3);
imshow(thres_img_l);
thres_img_l = morph_four_neigh(thres_img_l);

figure(3);
imshow(thres_img_l);
%Cropping the lips parts

x_l=1;
y_l=1;
BB_mouth(2)
BB_mouth(2)+BB_mouth(4)
BB_mouth(1)
BB_mouth(1)+BB_mouth(3)
for a_l=BB_mouth(2):BB_mouth(2)+BB_mouth(4)
    for b_l=BB_mouth(1):BB_mouth(1)+BB_mouth(3)
        img_l(x_l,y_l)=thres_img_l(a_l,b_l);
        y_l=y_l+1;
    end
    x_l=x_l+1;
    y_l=1;
end

% figure(4);
% imshow(img_l);


% %Preprocessing on lips
% mid_lip= floor(size(img_l,2)/2);
% for y_lip=1:size(img_l,1)


% %Histogram of the lips along columns
sum_h_l_c=zeros(1,size(img_l,2));
for a_h_c_l=1:size(img_l,2)
    for b_h_c_l=1:size(img_l,1)
        if(img_l(b_h_c_l,a_h_c_l)>=255)
        sum_h_l_c(a_h_c_l)=sum_h_l_c(a_h_c_l)+img_l(b_h_c_l,a_h_c_l);
        end
    end
end
p=1;
size(sum_h_l_c,2)/2
%Extracting points on the lips along cloumns
for a=1:(size(sum_h_l_c,2)/2)
    sum_h_l_c_temp(p)=sum_h_l_c(a);
    p=p+1;
end
for a=1:5
    [lip_ma(a),lip_ma_index(a)]=max(sum_h_l_c_temp);
    sum_h_l_c_temp(lip_ma_index(a))=0;
end

for a=1:5
    diff(a)=lip_ma(1)-lip_ma(a);
end
    
[l_c_val(2),l_c(2)] = max(sum_h_l_c);
    
l_c(1)=l_c(2);
for x_lip=1:l_c(2)
    ycor=sum_h_l_c(x_lip);
    if(ycor<sum_h_l_c(l_c(1)))
        l_c(1)=x_lip;
    end
end

l_c(3)=l_c(2);

for x_lip=l_c(2)+1:size(sum_h_l_c,2)
    ycor=sum_h_l_c(x_lip);
    if(ycor<sum_h_l_c(l_c(3)))
        l_c(3)=x_lip;
    end
end

l_c(2)=(l_c(1)+l_c(3))/2;

%Histogram of the lips along rows
sum_h_l_r=zeros(1,size(img_l,1));
for a_h_r_l=1:size(img_l,1)
    for b_h_r_l=1:size(img_l,2)
        if(img_l(a_h_r_l,b_h_r_l)>=255)
            sum_h_l_r(a_h_r_l)=sum_h_l_r(a_h_r_l)+img_l(a_h_r_l,b_h_r_l);
        end
    end
end


%Extracting points along the rows 

%Extracting points global maximum and global minimum
[l_r_val(2),l_r(2)] = max(sum_h_l_r);

l_r(1)=l_r(2);
for x_lip=1:l_r(2)
    ycor=sum_h_l_r(x_lip);
    if(ycor<sum_h_l_r(l_r(1)))
        l_r(1)=x_lip;
    end
end

l_r(3)=l_r(2);
count=1;

for x_lip=l_r(2)+1:size(sum_h_l_c,2)
    ycor=sum_h_l_r(x_lip);
    if(ycor<sum_h_l_r(l_r(3)))
        l_r(3)=x_lip;
    else
        count=count+1;
    end
    if(count>1)
        break;
    end
end
l_r(3)=x_lip-1;

%Extracting another set of global minimum and maximum
temp=1;
for x_mod=l_r(3)+1:size(sum_h_l_r,2)
    sum_h_l_r_mod(temp)=sum_h_l_r(x_mod);
    temp=temp+1;
end

[l_r_val(5),l_r(5)] = max(sum_h_l_r_mod);


l_r(4)=l_r(5);
for x_lip=1:l_r(5)
    ycor=sum_h_l_r_mod(x_lip);
    if(ycor<sum_h_l_r_mod(l_r(4)))
        l_r(4)=x_lip;
    end
end

l_r(6)=l_r(5);
% count=1;

for x_lip=l_r(5)+1:size(sum_h_l_r_mod,2)
    ycor=sum_h_l_r_mod(x_lip);
    if(ycor<sum_h_l_r_mod(l_r(6)))
        l_r(6)=x_lip;
%     else
%         count=count+1;
    end
%     if(count>1)
%         break;
%     end
end


l_r(5)=l_r(5)+l_r(3);
l_r(4)=l_r(4)+l_r(3);
l_r(6)=l_r(6)+l_r(3);
% 
if(l_r(5)>floor((l_r(1)+l_r(6))/2))
else
l_r(5)=l_r(6)-l_r(2);
end


% l_x(1)=BB_mouth(1)+l_c(1);
% l_y(1)=floor(size(I,1)/2)+BB_mouth(2)+l_r(3);
% 
% l_x(2)=BB_mouth(1)+l_c(2);
% l_y(2)=floor(size(I,1)/2)+BB_mouth(2)+l_r(1);
% 
% l_x(3)=BB_mouth(1)+l_c(2);
% l_y(3)=floor(size(I,1)/2)+BB_mouth(2)+l_r(2);
% 
% l_x(4)=BB_mouth(1)+l_c(3);
% l_y(4)=floor(size(I,1)/2)+BB_mouth(2)+l_r(3);
% 
% p55x=BB_mouth(1)+l_c(1);
% p55y=floor(size(I,1)/2)+BB_mouth(2)+l_r(4);
% 
% p66x=BB_mouth(1)+l_c(2);
% p66y=floor(size(I,1)/2)+BB_mouth(2)+l_r(6);
% 
% p77x=BB_mouth(1)+l_c(2);
% p77y=floor(size(I,1)/2)+BB_mouth(2)+l_r(5);
% 
% p88x=BB_mouth(1)+l_c(3);
% p88y=floor(size(I,1)/2)+BB_mouth(2)+l_r(6);


l_x(1)=BB_mouth(1)+l_c(1);
l_y(1)=floor(7*(size(I1,1)/12))+BB_mouth(2)+l_r(2);

l_x(2)=BB_mouth(1)+l_c(2);
l_y(2)=floor(7*(size(I1,1)/12))+BB_mouth(2)+l_r(2);

l_x(3)=BB_mouth(1)+l_c(2);
l_y(3)=floor(7*(size(I1,1)/12))+BB_mouth(2)+l_r(5);

l_x(4)=BB_mouth(1)+l_c(3);
l_y(4)=floor(7*(size(I1,1)/12))+BB_mouth(2)+l_r(2);

figure(3)
plot_template(l_x,l_y,path)

figure(4)
subplot(2,2,1)
plot(1:size(img_e,2),sum_h_e_c);
subplot(2,2,2)
plot(1:size(img_e,1),sum_h_e_r);


subplot(2,2,3)
plot(1:size(img_l,2),sum_h_l_c);
subplot(2,2,4)
plot(1:size(img_l,1),sum_h_l_r);
distance=zeros(8);
distance= feature_dist(plotx,ploty,e_x,e_y,l_x,l_y);
