function [interpolated_coordinates] = spline_interpolation3D(line_coordinates, count_of_points)

    x=line_coordinates(:,1);
    y=line_coordinates(:,2);
    z=line_coordinates(:,3);    
    t=(1:size(z,1));
    
    contour(:,1)=t;
    
    contour(:,2)=x;    
    xi=spline_interpolation1D(contour,size(contour,1));
    xi__ = interpolate_points_to_curve(count_of_points, xi(:,1), xi(:,2),'spline');
    
    contour(:,2)=y;     
    yi=spline_interpolation1D(contour,size(contour,1)) ; 
    yi__ = interpolate_points_to_curve(count_of_points, yi(:,1), yi(:,2),'spline'); 
    
    contour(:,2)=z;   
    zi=spline_interpolation1D(contour,size(contour,1));
    zi__ = interpolate_points_to_curve(count_of_points, zi(:,1), zi(:,2),'spline');     
    
%     ti = linspace(1,size(z,1),count_of_points); % The interpolated values of t
%     xi = interp1(t,x,ti,'spline'); % Interpolated values of xi at ti.
%     yi = interp1(t,y,ti,'spline');
%     zi = interp1(t,z,ti,'spline');
    
interpolated_coordinates(:,1)=xi__(:,2);
interpolated_coordinates(:,2)=yi__(:,2);
interpolated_coordinates(:,3)=zi__(:,2);
% 

% figure
% hold on
% plot(t,xi(:,2),'r')
% hold on
% plot(t,xi__(:,2),'r')
% 
% figure
% hold on
% plot(t,yi(:,2),'r')
% hold on
% plot(t,yi__(:,2),'r')
% 
% figure
% hold on
% plot(t,zi(:,2),'r')
% hold on
% plot(t,zi__(:,2),'r')

