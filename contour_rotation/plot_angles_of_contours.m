function [angles]= plot_angles_of_contours (contour_dataset,plot_name,current_axes)

if isempty(contour_dataset)

        questdlg('Build contour motion first. No data to plot', ...
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



count_of_points=size(contour_dataset,2);
for i=1:count_of_points
    angles(i)=contour_dataset(i).characteristics_points_data.angle;
    time(i)=contour_dataset(i).time;
end;

% plot trajectories of each point----------------------------------
    if  (nargin<3)
        figure
    else
        axes(current_axes);
    end;
        title(plot_name)    ;
        view([0 90]);    
        
    plot(time, angles,'b') ;

%------------------------------------------------------------------


