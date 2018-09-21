%Filling holes in the image
clear all;
image=imread('G:\fyproject\eye_images\eye1.jpg');
[X,map] = imread('G:\fyproject\eye_images\eye1.jpg');
info = imfinfo('G:\fyproject\eye_images\eye1.jpg')
% I = rgb2gray(X,map);
Ifill = imfill(image,'holes');

imshow(X);figure, imshow(Ifill)