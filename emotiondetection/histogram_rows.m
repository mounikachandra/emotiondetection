function [ row ] = histogram_rows( img_input )
%Histogram along the rows
% %   Detailed explanation goes here
%     Summing up the values along the rows 
%     and finding the max and minimum values of the 
%     Histogram

% Histogram of the eyes along rows
sum_h_e_r=zeros(1,size(img_input,1));
2222222222222222222222222222222222222222222222
for a=1:size(img_input,1)
    for b=1:size(img_input,2)
        if(img_e(a,b)>=255)
            sum_h_e_r(a)=sum_h_e_r(a)+img_e(a,b);
        end
    end
end
%Declaration of number of minimum and maximum
row=zeros(3);

%Declaration of number of minimum and maximum value
row_val=zeros(3);

%Extracting points on along rows
[row_val(2),row(2)]=max(sum_h_e_r);

row(1)=row(2);
for a=1:row(2)
    ycor=sum_h_e_r(a);
    if(ycor<sum_h_e_r(row(1)))
        row(1)=a;
    end
end

row(3)=row(2);

for a=row(2)+1:size(sum_h_e_r,2)
    ycor=sum_h_e_r(a);
    if(ycor<sum_h_e_r(row(3)))
        row(3)=a;
    end
end
%Plotting the histogram
% plot(1:size(img_input,2),sum_h_e_r);


end

