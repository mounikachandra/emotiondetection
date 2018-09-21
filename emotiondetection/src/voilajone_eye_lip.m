%Main code to detect eyebrows,eyes and lips form the image

%detect Eyes
clear all;
EyeDetect = vision.CascadeObjectDetector('EyePairBig');

%Read the input Image
path='G:\fyproject\jaffeimages\jaffecrop\13.tiff';
% path='G:\fyproject\test_images_output\test_img1.tif';
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
for i=floor((size(I1,1))/2):size(I1,1)
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
% rectangle('Position',BB_mouth(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
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
[l_max,l_max_index] = max(left_h_c);

l_min_index1=l_max_index;
for x_l_l=1:l_max_index
    ycor=left_h_c(x_l_l);
    if(ycor<left_h_c(l_min_index1))
        l_min_index1=x_l_l;
    end
end
l_min_index2=l_max_index;
for x_l_r=l_max_index+1:size(left_h_c,2)
    ycor=left_h_c(x_l_r);
    if(ycor<left_h_c(l_min_index2))
        l_min_index2=x_l_r;
    end
end
l_max_index=floor((l_min_index2+l_min_index1)/2);

r_p_in=1;
for r_p=floor((wide_col)/2)+1:wide_col
    right_h_c(r_p_in)=sum_h_e_c(r_p);
    r_p_in=r_p_in+1;
end

%Extracting points on the right eye
[r_max,r_max_index] = max(right_h_c);
r_min_index1=r_max_index;
for x_r_l=r_max_index:-1:1
    ycor=right_h_c(x_r_l);
    if(ycor<right_h_c(r_min_index1))
        r_min_index1=x_r_l;
        if(ycor==0)
            break;
        end
    end
end

r_min_index2=r_max_index;

for x_r_r=r_max_index+1:size(right_h_c,2)
    ycor=right_h_c(x_r_r);
   
    if(ycor<right_h_c(r_min_index2))
        r_min_index2=x_r_r;
        if(ycor==0)
            break;
        end
    end
end
r_max_index= r_max_index + floor(wide_col/2)+1;
r_min_index1= r_min_index1 + floor(wide_col/2)+1;
r_min_index2= r_min_index2 + floor(wide_col/2)+1;

r_max_index=floor((r_min_index1+r_min_index2)/2);

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
[e_max_r,e_max_index_r]=max(sum_h_e_r);

e_min_index1_r=e_max_index_r;
for x_u=1:e_max_index_r
    ycor=sum_h_e_r(x_u);
    if(ycor<sum_h_e_r(e_min_index1_r))
        e_min_index1_r=x_u;
    end
end

e_min_index2_r=e_max_index_r;

for x_d=e_max_index_r+1:size(sum_h_e_r,2)
    ycor=sum_h_e_r(x_d);
    if(ycor<sum_h_e_r(e_min_index2_r))
        e_min_index2_r=x_d;
    end
end
p1x=l_min_index1+BB(1);
p1y=e_max_index_r+BB(2);

p2x=l_max_index+BB(1);
p2y=e_min_index1_r+BB(2);

p3x=l_min_index2+BB(1);
p3y=e_max_index_r+BB(2);

p4x=l_max_index+BB(1);
p4y=e_min_index2_r+BB(2);

p5x=r_min_index1+BB(1);
p5y=e_max_index_r+BB(2);

p6x=r_max_index+BB(1);
p6y=e_min_index1_r+BB(2);

p7x=r_min_index2+BB(1);
p7y=e_max_index_r+BB(2);

p8x=r_max_index+BB(1);
p8y=e_min_index2_r+BB(2);

figure(10);
plot_code(p1x,p1y,p2x,p2y,p3x,p3y,p4x,p4y,p5x,p5y,p6x,p6y,p7x,p7y,p8x,p8y,path);

% %Thresholding on the crop part 
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
% imshow(thres_img_l);
thres_img_l = morph_four_neigh(thres_img_l);

% figure(3);
% imshow(thres_img_l);
% %Cropping the lips parts

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
    
[lip_max,lip_max_index] = max(sum_h_l_c);
    
lip_min_index1=lip_max_index;
for x_lip=1:lip_max_index
    ycor=sum_h_l_c(x_lip);
    if(ycor<sum_h_l_c(lip_min_index1))
        lip_min_index1=x_lip;
    end
end

lip_min_index2=lip_max_index;

for x_lip=lip_max_index+1:size(sum_h_l_c,2)
    ycor=sum_h_l_c(x_lip);
    if(ycor<sum_h_l_c(lip_min_index2))
        lip_min_index2=x_lip;
    end
end

lip_max_index=(lip_min_index1+lip_min_index2)/2;

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
[lip_max1_r,lip_max1_index_r] = max(sum_h_l_r);

lip_min_index1_r=lip_max1_index_r;
for x_lip=1:lip_max1_index_r
    ycor=sum_h_l_r(x_lip);
    if(ycor<sum_h_l_r(lip_min_index1_r))
        lip_min_index1_r=x_lip;
    end
end

lip_min_index2_r=lip_max1_index_r;
count=1;

for x_lip=lip_max1_index_r+1:size(sum_h_l_c,2)
    ycor=sum_h_l_r(x_lip);
    if(ycor<sum_h_l_r(lip_min_index2_r))
        lip_min_index2_r=x_lip;
    else
        count=count+1;
    end
    if(count>1)
        break;
    end
end
lip_min_index2_r=x_lip-1;

%Extracting another set of global minimum and maximum
temp=1;
for x_mod=lip_min_index2_r+1:size(sum_h_l_r,2)
    sum_h_l_r_mod(temp)=sum_h_l_r(x_mod);
    temp=temp+1;
end

[lip_max2_r,lip_max2_index_r] = max(sum_h_l_r_mod);


lip_min_index3_r=lip_max2_index_r;
for x_lip=1:lip_max2_index_r
    ycor=sum_h_l_r_mod(x_lip);
    if(ycor<sum_h_l_r_mod(lip_min_index3_r))
        lip_min_index3_r=x_lip;
    end
end

lip_min_index4_r=lip_max2_index_r;
% count=1;

for x_lip=lip_max2_index_r+1:size(sum_h_l_r_mod,2)
    ycor=sum_h_l_r_mod(x_lip);
    if(ycor<sum_h_l_r_mod(lip_min_index4_r))
        lip_min_index4_r=x_lip;
%     else
%         count=count+1;
    end
%     if(count>1)
%         break;
%     end
end


lip_max2_index_r=lip_max2_index_r+lip_min_index2_r;
lip_min_index3_r=lip_min_index3_r+lip_min_index2_r;
lip_min_index4_r=lip_min_index4_r+lip_min_index2_r;
% 
if(lip_max2_index_r>floor((lip_min_index1_r+lip_min_index4_r)/2))
else
lip_max2_index_r=lip_min_index4_r-lip_max1_index_r;
end


% p11x=BB_mouth(1)+lip_min_index1;
% p11y=floor(size(I,1)/2)+BB_mouth(2)+lip_min_index2_r;
% 
% p22x=BB_mouth(1)+lip_max_index;
% p22y=floor(size(I,1)/2)+BB_mouth(2)+lip_min_index1_r;
% 
% p33x=BB_mouth(1)+lip_max_index;
% p33y=floor(size(I,1)/2)+BB_mouth(2)+lip_max1_index_r;
% 
% p44x=BB_mouth(1)+lip_min_index2;
% p44y=floor(size(I,1)/2)+BB_mouth(2)+lip_min_index2_r;
% 
% p55x=BB_mouth(1)+lip_min_index1;
% p55y=floor(size(I,1)/2)+BB_mouth(2)+lip_min_index3_r;
% 
% p66x=BB_mouth(1)+lip_max_index;
% p66y=floor(size(I,1)/2)+BB_mouth(2)+lip_min_index4_r;
% 
% p77x=BB_mouth(1)+lip_max_index;
% p77y=floor(size(I,1)/2)+BB_mouth(2)+lip_max2_index_r;
% 
% p88x=BB_mouth(1)+lip_min_index2;
% p88y=floor(size(I,1)/2)+BB_mouth(2)+lip_min_index4_r;


p11x=BB_mouth(1)+lip_min_index1;
p11y=floor(size(I,1)/2)+BB_mouth(2)+lip_max1_index_r;

p22x=BB_mouth(1)+lip_max_index;
p22y=floor(size(I,1)/2)+BB_mouth(2)+lip_max1_index_r;

p33x=BB_mouth(1)+lip_max_index;
p33y=floor(size(I,1)/2)+BB_mouth(2)+lip_max2_index_r;

p44x=BB_mouth(1)+lip_min_index2;
p44y=floor(size(I,1)/2)+BB_mouth(2)+lip_max1_index_r;

figure(3)
plot_four(p11x,p11y,p22x,p22y,p33x,p33y,p44x,p44y,path)

figure(4)
subplot(2,2,1)
plot(1:size(img_e,2),sum_h_e_c);
subplot(2,2,2)
plot(1:size(img_e,1),sum_h_e_r);


subplot(2,2,3)
plot(1:size(img_l,2),sum_h_l_c);
subplot(2,2,4)
plot(1:size(img_l,1),sum_h_l_r);
