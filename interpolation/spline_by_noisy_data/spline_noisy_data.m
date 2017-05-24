function [spline_interpolation] = spline_noisy_data(data,number_of_splice_pieces,spline_order)



count_of_points=size(data,2);

x=(1:count_of_points);

%spline=splinefit(x,data,round(count_of_points/3),3);
  if  (nargin<2)
     number_of_splice_pieces=round(count_of_points/3);
     spline_order=3;
  end;
  
spline=splinefit(x,data,number_of_splice_pieces,spline_order);
spline_interpolation=ppval(spline,x);

% %testing
%     figure;
%     plot(x,spline_interpolation,'b--');
%     hold on
%     plot(x,data,'r');


