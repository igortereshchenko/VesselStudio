function plot_relative_contour_rotation(contour_data, contour_data_to_compare,angle,current_axes)    
    
    axes(current_axes);
    cla(current_axes);
    
    centroid=contour_data.geometry_characteristics.centroid;
    
    if ~isempty(contour_data_to_compare.coordinates)
        centroid_to_compare=contour_data_to_compare.geometry_characteristics.centroid;
    else
        centroid_to_compare=centroid;
    end
    
    characteristics_points=contour_data.characteristics_points_data;
    
    compared_characteristics_points_data=contour_data_to_compare.characteristics_points_data;
    
    
    displacement=centroid-centroid_to_compare;
    
    legend_text=[];

    %plot base contour
    contour=contour_data.coordinates;
    if ~isempty(contour)    
        contour(:,1)=contour(:,1)-displacement(1,1);
        contour(:,2)=contour(:,2)-displacement(1,2);            
        hold on;
        plot(contour(:,1),contour(:,2),'b');
        
        legend_text=char(legend_text,'base contour');
    end;
    
    %plot base contour characteristics points
    if ~isempty(characteristics_points)
        contour=characteristics_points.coordinates;
        if ~isempty(contour)
            contour(:,1)=contour(:,1)-displacement(1,1);
            contour(:,2)=contour(:,2)-displacement(1,2);            
            hold on
            plot(contour(:,1),contour(:,2),'b.');
            
            legend_text=char(legend_text,'base contour characteristics points');
        end;
    end;
    %plot contour to compare original
    contour=contour_data_to_compare.coordinates;
    if ~isempty(contour)    
        hold on;
        plot(contour(:,1),contour(:,2),'g')
        
        legend_text=char(legend_text,'original contour to compare');

        
    end;
    
    %plot compared characteristics points
    if ~isempty(compared_characteristics_points_data)
        contour=compared_characteristics_points_data.coordinates;
        if ~isempty(contour)    
            hold on;
            plot(contour(:,1),contour(:,2),'g.')    
            legend_text=char(legend_text,'compared characteristics points');            
        end;
    end
    
    %plot contour to compare rotated
    contour=contour_data_to_compare.coordinates;
    if ~isempty(contour)    
        plot_and_rotate_contour (contour,angle,centroid,centroid_to_compare,current_axes,'r');        
        legend_text=char(legend_text,'contour to compare rotated');
    end;

    
    if ~isempty(compared_characteristics_points_data)
        %plot rotated compared characteristics points
        contour=compared_characteristics_points_data.coordinates;
        if ~isempty(contour)
            plot_and_rotate_contour (contour,angle,centroid,centroid_to_compare,current_axes,'r.');                    
            legend_text=char(legend_text,'rotated compared characteristics points');
        end;
    end;  
    %skipp [] which is first
    if size(legend_text,1)>1
        legend(legend_text(2:size(legend_text,1),:));
    end;