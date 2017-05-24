% polar_coordinates=[rho,theta]
function [polar_coordinates] = to_polar(coordinates, centroid)

if ~exist('center','var')
    centroid = [0,0];
end;
polar_coordinates=[];

for i=1:size(coordinates,1)
   rho = distance_between_points(coordinates(i,:),centroid);
   theta = atan2( (coordinates(i,2) - centroid(2)) , ( coordinates(i,1)- centroid(1)) );
   
   polar_coordinates=[polar_coordinates;[rho,theta]];
end;
