function [dist] = feature_dist(plotx,ploty,e_x,e_y,l_x,l_y)
%Distace from the various feature points 
%   Detailed explanation goes here
%     Calculating 8 feature point distances using
%     eyebrows, eyes and lips
8888888888888888888888888888888888888888888
    dist(1)=sqrt((plotx(2)-e_x(2))^2+(ploty(2)-e_y(2))^2);
    dist(2)=sqrt((plotx(3)-e_x(3))^2+(ploty(3)-e_y(3))^2);
    dist(3)=sqrt((plotx(4)-e_x(5))^2+(ploty(4)-e_y(5))^2);
    dist(4)=sqrt((plotx(5)-e_x(6))^2+(ploty(5)-e_y(6))^2);
    
    dist(5)=sqrt((e_x(2)-e_x(4))^2+(e_y(2)-e_y(4))^2);
    dist(6)=sqrt((e_x(6)-e_x(8))^2+(e_y(6)-e_y(8))^2);
    
    dist(7)=sqrt((l_x(2)-l_x(4))^2+(l_y(2)-l_y(4))^2); 
    dist(8)=sqrt((l_x(1)-l_x(3))^2+(l_y(1)-l_y(3))^2);

end

