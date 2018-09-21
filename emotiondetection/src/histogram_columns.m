function [ col_l,col_r ] = histogram_columns(img_input)
%Histogram along the columns
% %   Detailed explanation goes here
%     Summing up the values along the columns 
%     and finding the max and minimum values of the 
%     Histogram

% %Declaring the array having maximum and minimum
% col_l=zeros(3);
% col_r=zeros(3);
% 
% 
% %Declaring the array having the values of the maximum and minimum
% col_value_l=zeros(3);
% col_value_r=zeros(3);

sum_h_e_c=zeros(size(img_input,2));

for a=1:size(img_input,2)
    for b=1:size(img_input,1)
        if(img_input(b,a)>=255)
        sum_h_e_c(a)=sum_h_e_c(a)+img_input(b,a);
        end
    end
end
%Splitting into two half left one

wide_col=size(sum_h_e_c,2);
for a=1:floor((wide_col)/2)
    left_h_c(a)=sum_h_e_c(a);
end

for a=1:floor((wide_col)/2)
    left_h_mod(floor((wide_col)/2)+1-a)=left_h_c(a)
end
[val(1),ind(1)]=max(left_h_c);
[col_value_l(2),col_l(2)] = max(left_h_mod);
col_l(2)=floor((wide_col)/2)-col_l(2);
if(val(1)==col_value_l(2))
col_l(1)=col_l(2);
else
col_l(1)=ind(1);
for a=1:ind(1)
    ycor=left_h_c(a);
    if(ycor<left_h_c(col_l(1)))
        col_l(1)=a;
    end
end
end
% col_l(1)
col_l(3)=ind(1);
for a=ind(1)+1:size(left_h_c,2)
    ycor=left_h_c(a);
    if(ycor<left_h_c(col_l(3)))
        col_l(3)=a;
    end
end
col_l(2)=floor((col_l(1)+col_l(3))/2);

b=1;
for a=floor((wide_col)/2)+1:wide_col
    right_h_c(b)=sum_h_e_c(a);
    b=b+1;
end

for a=1:size(right_h_c,2)
    right_h_mod(size(right_h_c,2)+1-a)=right_h_c(a)
end
[val_r(2),ind_r(2)]=max(right_h_mod);
% [col_value_r(2),col_r(2)] 
ind_r(2)=size(right_h_c,2)-ind_r(2);

%Extracting points on the right eye

[col_value_r(2),col_r(2)] = max(right_h_c);
col_r(1)=col_r(2);
for a=col_r(2):-1:1
    ycor=right_h_c(a);
    if(ycor<right_h_c(col_r(1)))
        col_r(1)=a;
        if(ycor==0)
            break;
        end
    end
end

if(val_r(2)==col_value_r(2))
col_r(3)=col_r(2);
else
col_r(3)=col_r(2);
for a=col_r(2)+1:size(right_h_c,2)
    ycor=right_h_c(a);
    if(ycor<right_h_c(col_r(3)))
        col_r(3)=a;
        if(ycor==0)
            break;
        end
    end
end
end
% col_r(2)= col_r(2) + floor(wide_col/2)+1;
col_r(1)= col_r(1) + floor(wide_col/2)+1;
col_r(3)= col_r(3) + floor(wide_col/2)+1;

col_r(2)=floor((col_r(1)+col_r(3))/2);

%Plotting the histogram
size(img_input,2)

% plot(1:size(img_input,2),sum_h_e_c);

end



