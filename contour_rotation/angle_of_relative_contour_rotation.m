function [angle,max_similarity,distance_1,distance_2] = angle_of_relative_contour_rotation(contour_data, contour_data_to_compare,count_of_points,angle_range,angle_scale,method,current_axes)


initial_angle=0;

characteristics_points = contour_characteristics_points_data(contour_data,count_of_points,initial_angle);
centroid=contour_data.geometry_characteristics.centroid;

centroid_to_compare=contour_data_to_compare.geometry_characteristics.centroid;



angles=-angle_range:angle_scale:angle_range;
max_similarity=0;

%     figure;
%     plot(contour_data.coordinates(:,1),contour_data.coordinates(:,2),'g');
%     hold on;
%     plot(contour_data_to_compare.coordinates(:,1),contour_data_to_compare.coordinates(:,2),'r');


%     figure;
%     plot(contour_data.coordinates(:,1),contour_data.coordinates(:,2),'g');
%     axis equal;

    %contour=contour_data_to_compare.coordinates;
%     characteristics_points_data_to_compare = contour_characteristics_points_data(contour_data_to_compare, count_of_points,angles(1));
%     contour=characteristics_points_data_to_compare.coordinates;
%     
%     [theta,rho] = cart2pol(contour(:,1)-centroid_to_compare(1),contour(:,2)-centroid_to_compare(2));


for i=1:size(angles,2)
    
    characteristics_points_data_to_compare = contour_characteristics_points_data(contour_data_to_compare, count_of_points,angles(i));

   
    %(characteristics_points,centroid, characteristics_points_to_compare,centroid_to_compare)
    [contour_similarity,similarity_dr,current_r1,current_r2,current_dr1,current_dr2]= contour_similarity_by_characteristics_points(characteristics_points.coordinates, centroid,characteristics_points_data_to_compare.coordinates,centroid_to_compare);   
    
    r_similar(i)=contour_similarity;
    dr_similar(i)=similarity_dr;
    
    if strcmp(method,'distance')
        if contour_similarity>max_similarity
           max_similarity = contour_similarity;
           compared_characteristics_points_data=characteristics_points_data_to_compare;
           distance_1=current_r1;
           distance_2=current_r2;           
        end;
    else
        if similarity_dr>max_similarity
           max_similarity = similarity_dr;
           compared_characteristics_points_data=characteristics_points_data_to_compare;
           distance_1=current_dr1;
           distance_2=current_dr2;           
        end;
    end
    

%     %----test ploting
%         theta1=theta-characteristics_points_data_to_compare.angle;
%         theta2=theta-compared_characteristics_points_data.angle;
%         [contour2(:,1),contour2(:,2)] = pol2cart(theta1,rho);
%         [contour3(:,1),contour3(:,2)] = pol2cart(theta2,rho);
% 
%         contour2(:,1)=contour2(:,1)+centroid(1);
%         contour2(:,2)=contour2(:,2)+centroid(2);
% 
% 
%         contour3(:,1)=contour3(:,1)+centroid(1);
%         contour3(:,2)=contour3(:,2)+centroid(2);
% 
% 
%         hold on
%         h1=plot(contour2(:,1),contour2(:,2),'r');
% 
%         hold on
%         h2=plot(contour3(:,1),contour3(:,2),'b');
% 
%         pause(0.05);
%         delete(h1);   
%         delete(h2);   

end;

angle=compared_characteristics_points_data.angle;

if  (nargin==7)
   contour_data.characteristics_points_data=characteristics_points;
   contour_data_to_compare.characteristics_points_data=compared_characteristics_points_data;
   
   plot_relative_contour_rotation(contour_data, contour_data_to_compare,angle,current_axes)   
end;
    

