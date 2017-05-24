function [contour_interpolated] = spline_interpolation1D(contour,count_of_points)


x=contour(:,1);
y=contour(:,2);

spline=splinefit(x,y,round(count_of_points/5),3);
spline_y=ppval(spline,x);


contour_interpolated(:,1)=x;
contour_interpolated(:,2)=spline_y;