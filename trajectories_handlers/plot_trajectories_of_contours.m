function [trajectories_set]= plot_trajectories_of_contours (contour_dataset,plot_name,current_axes)

if isempty(contour_dataset)

        questdlg('Build all trajectory first. No data to plot', ...
        'Contour Builder', ...
        'Ok','Ok');
        return
end;




count_of_contours=size(contour_dataset,2);

if count_of_contours<2

        questdlg('There are less than two contours in contour_dataset', ...
        'Contour Builder', ...
        'Ok','Ok');
        return
end;



% trajectory of each point motion in 3D [ x,y,time]
count_of_trajectories=size(contour_dataset(1).characteristics_points_data.coordinates,1); % count of coordinates of contour
trajectory_count_of_points=size(contour_dataset,2); % equals to count_of_contours 


% trajectory_count_of_points=3;

trajectories_set=[];


for number_of_trajectory=1:count_of_trajectories; % = index in characteristics_points_data.coordinates
    
    current_trajectory_time_point=1; % = index in contour_dataset

    current_trajectory_coordinates=[];
    for current_trajectory_time_point=1:trajectory_count_of_points
        
        current_trajectory_time=contour_dataset(current_trajectory_time_point).time;
        current_trajectory_coordinates=vertcat(current_trajectory_coordinates,[contour_dataset(current_trajectory_time_point).characteristics_points_data.coordinates(number_of_trajectory,:),current_trajectory_time]);

    end;
    
trajectories_set(:,:,:,number_of_trajectory)=current_trajectory_coordinates;
end


% plot trajectories of each point----------------------------------
    if  (nargin<3)
        figure
    else
        axes(current_axes);
    end;
        title(plot_name)    ;
        view([45 45]);    
        
        for number_of_trajectory=1:count_of_trajectories; % = index in characteristics_points_data.coordinates

            current_trajectory_coordinates=trajectories_set(:,:,:,number_of_trajectory);
            plot3(current_trajectory_coordinates(:,1),current_trajectory_coordinates(:,2),current_trajectory_coordinates(:,3),'g') ;

            hold on
        end
%------------------------------------------------------------------




% plot contours--------------------------------------------------

    n=size(contour_dataset,2);
%     n=3;
    
        for i=1:n
        title(plot_name);
            contour_coordinates_2D=contour_dataset(i).coordinates;
            characteristics_contour_coordinates_2D=contour_dataset(i).characteristics_points_data.coordinates;
            
            z(1:size(contour_coordinates_2D,1)) = contour_dataset(i).time;

            p1=plot3(contour_coordinates_2D(:,1),contour_coordinates_2D(:,2),z,'r') ;
            
            z2(1:size(characteristics_contour_coordinates_2D,1)) = contour_dataset(i).time;
            p2=plot3(characteristics_contour_coordinates_2D(:,1),characteristics_contour_coordinates_2D(:,2),z2,'b.') ;
            
            hold on
            pause(0.1);
%             delete(p1);
%             delete(p2);

        end;

%------------------------------------------------------------------

