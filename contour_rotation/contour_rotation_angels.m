function [angles]=contour_rotation_angels(contour_angle_parameters,method)


slice_dataset=contour_angle_parameters.slice_dataset;
count_of_points=contour_angle_parameters.count_of_similarity_points;
angle_range=contour_angle_parameters.angle_range;
angle_scale=contour_angle_parameters.angle_scale;


slice_dataset(1).contour_data.geometry_characteristics.angle=0;
angles(1)=0;

pattern_contour_data=slice_dataset(1).contour_data;
h = waitbar(0,'Angles of relative contour rotation is calculating now. Please wait...');
for i=1:size(slice_dataset,2)-1
    
    pattern_contour_data=slice_dataset(i).contour_data;
    contour_data=slice_dataset(i+1).contour_data;


    angle = angle_of_relative_contour_rotation(pattern_contour_data, contour_data,count_of_points,angle_range,angle_scale,method);
    
   
    angles(i+1)=angles(i)+angle;
    
        waitbar(i / (size(slice_dataset,2)-1));
end;
close(h)
