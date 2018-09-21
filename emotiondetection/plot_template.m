function [ ] = plot_template(x,y,path)
%Plotting the feature point on the image 
%   Detailed explanation goes here
%     After extracting the points from the cal_points
%     you have to plot those extracted points on the 
%     image.
plot_img=imread(path);
plot_img_mod=rgb2gray(plot_img);
figure,imshow(plot_img_mod);hold on
for a=1:size(x,2)
   plot(x(a),y(a),'r.-'),hold on
end
end

