function []= plot_contour_dymanics (contour_dataset,plot_name,current_axes)

pause_time=1;

if  (nargin<3)
    figure
else
    axes(current_axes);
end;
    
title(plot_name)
    
    patter_contour_data=contour_dataset(1);
    center=patter_contour_data.geometry_characteristics.centroid;
    area=patter_contour_data.geometry_characteristics.area;
    
    max_length=1.1*sqrt(area);

    xlim([center(1)-max_length center(1)+max_length]);
    ylim([center(2)-max_length center(2)+max_length]);
    
% motions
count_of_contours=size(contour_dataset,2);
hold on;


for i=1:count_of_contours

    contour=contour_dataset(i).coordinates;
    
    if i<count_of_contours
        contour_next=contour_dataset(i+1).coordinates;
    end;

    
    
    if i==1 || i==count_of_contours
        contour_plot = plot(contour(:,1),contour(:,2),'r--');
        pause(pause_time);
        delete(contour_plot);        
    else
        contour_plot = plot(contour(:,1),contour(:,2),'g');
        pause(pause_time);
        contour_next_plot = plot(contour_next(:,1),contour_next(:,2),'r--');            
        pause(pause_time);
        delete(contour_plot);
        delete(contour_next_plot);
    end;
end