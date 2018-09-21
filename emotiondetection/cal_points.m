function [ point_x,point_y ] = cal_points( img_input,col_left,col_right,row )
%Feature points on the eyebrow
%   Detailed explanation goes here
%     Forming points from the maximum, minimum histogram
%     values along the rows and column. Combining this 
%     three sets you can find out 6 points on left and
%     right eyebrow
%Declaration of the array
% points_x=zeros(6);
% points_y=zeros(6);

%Plotting the left eyebrow
33333333333333333333333333333333333333
point_x(1)=col_left(1);
point_y(1)=row(3)+floor(size(img_input,1)/6);

point_x(2)=col_left(2);
point_y(2)=row(1)+floor(size(img_input,1)/6);

point_x(3)=col_left(3);
point_y(3)=row(3)+floor(size(img_input,1)/6);


%Plotting the right eyebrow
point_x(4)=col_right(1);
point_y(4)=row(3)+floor(size(img_input,1)/6);

point_x(5)=col_right(2);
point_y(5)=row(1)+floor(size(img_input,1)/6);

point_x(6)=col_right(3);
point_y(6)=row(3)+floor(size(img_input,1)/6);

end

