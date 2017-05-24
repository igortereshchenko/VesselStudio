function [contours_dataset]= trajectories_interpolation(trajectories_interpolation_parameters)


slice_dataset=trajectories_interpolation_parameters.slice_dataset;
count_of_interpolation_points_time=trajectories_interpolation_parameters.count_of_interpolation_points_time;

count_of_points_interpolation_contour=size(slice_dataset(1).contour_data.coordinates,1);




count_of_contours=size(slice_dataset,2);


if count_of_contours<2
    error('There are less than two contours in contour_dataset')
end;

% 
% temp=contour_rotation_angels(slice_dataset,count_of_similarity_points,angle_range,angle_scale);
% angles=spline_noisy_data(temp);
% 
% 
% slice_dataset(1).contour_data.characteristics_points_data=contour_characteristics_points_data(slice_dataset(1).contour_data, count_of_characteristics_points,angles(1));
% contour_dataset_with_characteristics_points(1)=slice_dataset(1).contour_data;
% 
% h = waitbar(0,'Ñompared characteristics points is calculating now. Please wait...');
% for i=2:size(angles,2)
%     slice_dataset(i).contour_data.characteristics_points_data=build_compared_characteristics_points(slice_dataset(i).contour_data, slice_dataset(i-1).contour_data,count_of_characteristics_points,epsilon_compared_characteristics_points,angles(i));
%     contour_dataset_with_characteristics_points(i)=slice_dataset(i).contour_data;
%     
%     waitbar(i / (size(angles,2)-1));
% end
% close(h);


% trajectory of each point motion in 3D [ x,y,time]
count_of_trajectories=size(slice_dataset(1).contour_data.characteristics_points_data.coordinates,1); % count of coordinates of contour
trajectory_count_of_points=size(slice_dataset,2); % equals to count_of_contours 
trajectories_set=[];


% h = waitbar(0,'Trajectories of characteristics points is calculating now. Please wait...');

for number_of_trajectory=1:count_of_trajectories; % = index in characteristics_points_data.coordinates
    
    current_trajectory_time_point=1; % = index in contour_dataset

    current_trajectory_coordinates=[];
    for current_trajectory_time_point=1:trajectory_count_of_points
        
        current_trajectory_time=slice_dataset(current_trajectory_time_point).contour_data.time;
        current_trajectory_coordinates=vertcat(current_trajectory_coordinates,[slice_dataset(current_trajectory_time_point).contour_data.characteristics_points_data.coordinates(number_of_trajectory,:),current_trajectory_time]);

    end;
    
    %interpolation of each trajectory, count_of_interpolation_points better
    %choose power of trajectory_count_of_points
    %count_of_interpolation_points_time=trajectory_count_of_points^2;
    
    trajectory_interpolation=spline_interpolation3D(current_trajectory_coordinates,count_of_interpolation_points_time);
    
    
    
trajectories_set(:,:,:,number_of_trajectory)=trajectory_interpolation;

%     waitbar(number_of_trajectory / count_of_trajectories);
        sb=statusbar(gcf,'Trajectories of characteristics points is calculating now. Processing %d of %d (%.1f%%)...',number_of_trajectory,count_of_trajectories,100*number_of_trajectory/count_of_trajectories); 
        set(sb.ProgressBar,'Visible',1,'Value',100*number_of_trajectory/count_of_trajectories);
end
% close(h)
set(sb.ProgressBar,'Visible',0);
statusbar(gcf,'Ready');

% % plot trajectories of each point----------------------------------
%         figure
%         for number_of_trajectory=1:count_of_trajectories; % = index in characteristics_points_data.coordinates
% 
%             current_trajectory_coordinates=trajectories_set(:,:,:,number_of_trajectory);
%             plot3(current_trajectory_coordinates(:,1),current_trajectory_coordinates(:,2),current_trajectory_coordinates(:,3),'g') ;
% 
%             hold on
%         end
% %------------------------------------------------------------------


% create interpolation contours
count_of_trajectory_coordinates=size(trajectories_set,1);
count_of_trajectories=size(trajectories_set,4);

%interpolation_contour_dataset=[]; error in initialization!!!!!!!!!!!!!!


% h = waitbar(0,'Interpolation of trajectories for each characteristics point is calculating now. Please wait...');

for point_level=1:count_of_trajectory_coordinates  % equals to position of point each in trajectory
    current_contour=[];
    for point_position=1:count_of_trajectories %equals to number of trajectory
        current_point=trajectories_set(point_level,1:2,:,point_position);
        current_contour=vertcat(current_contour,current_point);
    end;
    time=trajectories_set(point_level,3,:,point_position);
     
    
    %save characteristics point before rescale
    contour_character_points_data=struct ('coordinates',current_contour,'angle',[]);

    %rescave contour
    %count_of_points_interpolation_contour = 100;
    
    current_contour = interpolate_points_to_curve(count_of_points_interpolation_contour, current_contour(:,1),current_contour(:,2),'csape'); %csape!!!!

    
    contour_data = struct( 'time',time,'coordinates',current_contour,'geometry_characteristics', ...
        contour_geometry_characteristics(current_contour),'characteristics_points_data',contour_character_points_data);
    
    contours_dataset(point_level)=contour_data;
  
%     waitbar(point_level / count_of_trajectory_coordinates);
        sb=statusbar(gcf,'Trajectories of characteristics points is calculating now. Processing %d of %d (%.1f%%)...',point_level,count_of_trajectory_coordinates,100*point_level/count_of_trajectory_coordinates); 
        set(sb.ProgressBar,'Visible',1,'Value',100*point_level/count_of_trajectory_coordinates);

end;
% close(h)
set(sb.ProgressBar,'Visible',0);
statusbar(gcf,'Ready');

% %3D plot result--------------------------------------------------
%         for i=1:size(interpolation_contour_dataset,2)
% 
%             contour_coordinates_2D=interpolation_contour_dataset(i).coordinates;
%             characteristics_contour_coordinates_2D=interpolation_contour_dataset(i).characteristics_points_data.coordinates;
%             
%             z(1:size(contour_coordinates_2D,1)) = interpolation_contour_dataset(i).time;
% 
%             plot3(contour_coordinates_2D(:,1),contour_coordinates_2D(:,2),z,'r') ;
%             
%             z2(1:size(characteristics_contour_coordinates_2D,1)) = interpolation_contour_dataset(i).time;
%             plot3(characteristics_contour_coordinates_2D(:,1),characteristics_contour_coordinates_2D(:,2),z2,'b*') ;
%             
%             hold on
% 
%         end;
% 
% %------------------------------------------------------------------
% 
% 
% 
% % plot trajectories of each point----------------------------------
%         figure
%         for number_of_trajectory=1:count_of_trajectories; % = index in characteristics_points_data.coordinates
% 
%             current_trajectory_coordinates=trajectories_set(:,:,:,number_of_trajectory);
%             plot3(current_trajectory_coordinates(:,1),current_trajectory_coordinates(:,2),current_trajectory_coordinates(:,3),'g') ;
% 
%             hold on
%         end
% %------------------------------------------------------------------
% 
% 
%         for i=1:size(contour_dataset,2)
% 
% 
%             characteristics_contour_coordinates_2D=contour_dataset(i).characteristics_points_data.coordinates;
%             
%             z3(1:size(characteristics_contour_coordinates_2D,1)) = contour_dataset(i).time;
% 
%             plot3(characteristics_contour_coordinates_2D(:,1),characteristics_contour_coordinates_2D(:,2),z3,'b-') ;
%             
%             hold on
% 
%         end;
  