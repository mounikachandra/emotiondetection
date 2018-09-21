function [input_img] = morph_four_neigh(input_img)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%Morphology on the image
for a= 2:size(input_img,1)-1
    for b= 2:size(input_img,2)-1
        if(input_img(a,b)>1)
            if(input_img(a,b-1)+input_img(a,b+1)+input_img(a-1,b)+input_img(a+1,b)==0)
                input_img(a,b)=0;
            end
        end
    end
end

end

