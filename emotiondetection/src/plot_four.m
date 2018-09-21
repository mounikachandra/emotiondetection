function [] = plot_four(p_x,p_y,path)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
77777777777777777777777777777777777
plot_img=imread(path);
plot_img_mod=rgb2gray(plot_img);
imshow(plot_img_mod);hold on
for a=1:4
plot(p_x(1),p_y(1),'r.-'),hold on
end


end

