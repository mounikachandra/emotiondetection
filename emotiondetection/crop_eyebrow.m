function [ img_output ] = crop_eyebrow(img_input,BB_e )
%Cropping the image to extract eyebrows from the image 

% %   Detailed explanation goes here
%     Consider an image where the eyes are detected using 
%     Viola Jones algorithm, the BB box generated from the 
%     image containing eyes is used to extract the eyebrows.
%     By scanning the image input from the head to the BB box
%     you can always find the eyebrow region which can be 
%     cropped.
x=1;
y=1;
% floor(size(img_input,1)/6)
for a=floor(size(img_input,1)/6):BB_e(2)
    for b=1:size(img_input,2)
        img_output(x,y)=img_input(a,b);
        y=y+1;
    end
    x=x+1;
    y=1;

end

