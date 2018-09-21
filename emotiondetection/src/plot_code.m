%Function of ploting plots on the image
function[]=plot_code(p1x,p1y,p2x,p2y,p3x,p3y,p4x,p4y,p5x,p5y,p6x,p6y,p7x,p7y,p8x,p8y,path)

plot_img=imread(path);
plot_img_mod=rgb2gray(plot_img);
imshow(plot_img_mod);hold on
plot(p1x,p1y,'r.-'),hold on
plot(p2x,p2y,'r.-'),hold on
plot(p3x,p3y,'r.-'),hold on
plot(p4x,p4y,'r.-'),hold on
plot(p5x,p5y,'r.-'),hold on
plot(p6x,p6y,'r.-'),hold on
plot(p7x,p7y,'r.-'),hold on
plot(p8x,p8y,'r.-'),hold on

end
% [I, map] =  imread('G:\fyproject\jaffeimages\jaffecrop\13.tiff');
% axis image;
% image (I);
% colormap(map);
% hold on;
% x1 =16,
% y1 = 1;
% figure(2);
% plot(x1,y1,'r.-');