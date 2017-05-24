function contour = manual_contour_selection (image,plot_name,patter_contour_data)


%### manualy select contour ###
figure
imshow(image,[]);
title(plot_name)
answer='No';

if ~isempty(patter_contour_data)
    patter_contour=patter_contour_data.coordinates;
    hold on, plot(patter_contour(:,1),patter_contour(:,2),'g--');
    
    center=patter_contour_data.geometry_characteristics.centroid;
    area=patter_contour_data.geometry_characteristics.area;
    
    max_length=1.3*sqrt(area);

    xlim([center(1)-max_length center(1)+max_length]);
    ylim([center(2)-max_length center(2)+max_length]);
    
    answer = questdlg('Is this contour fit your data?', ...
        'Contour manual selection', ...
        'Yes','No','Yes');

    
end;

if strcmp(answer,'No')
    
    
    
while strcmp(answer,'No')
    
    
    
    hROI = imfreehand('Closed',true);
    contour_coordinates = getPosition(hROI);

    %B = roipoly(image);

    % %convex hull of set manual selected points
    % convex_hull_coordinates_indexes=convhull(contour_coordinates(:,1), contour_coordinates(:,2));
    % 
    % %envelope building
    % count_of_points = 100;
    % contour = interparc(count_of_points, contour_coordinates(convex_hull_coordinates_indexes,1),... 
    %                     contour_coordinates(convex_hull_coordinates_indexes,2),'csape'); %csape!!!!





    %close contour. Add first point to contour coordinates array as last one
    contour=points2closed_contour(contour_coordinates(:,1),contour_coordinates(:,2));



    % contour scaling
    count_of_points = 50;

    %resclaling by count of points
    contour_resized_by_count_points=curve_to_equals_lines(contour,count_of_points);


    %envelope building
    count_of_points = 100;
    contour = interparc(count_of_points, contour_resized_by_count_points(:,1), contour_resized_by_count_points(:,2),'csape');


    hold on, plot(contour(:,1),contour(:,2),'r') ;
    
    % Construct a questdlg 
    answer = questdlg('Would you like result?', ...
        'Contour manual selection', ...
        'Yes','No','Yes');
    
    if strcmp(answer,'No')
        imshow(image,[]);
        if ~isempty(patter_contour_data)
            patter_contour=patter_contour_data.coordinates;
            hold on, plot(patter_contour(:,1),patter_contour(:,2),'g--');
        end;
    end;
    
    delete(hROI)
   
end;  

else
    contour=patter_contour;
end;


  
