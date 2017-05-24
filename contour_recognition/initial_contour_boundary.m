function boundary=initial_contour_boundary(contour, dicom_image, scale)

    [width,height]=size(dicom_image);
    geometry_characteristics=contour_geometry_characteristics( contour ) ;
    
    centroid=geometry_characteristics.centroid;
    avg_size=sqrt(geometry_characteristics.area);

    min_x=max(1,centroid(1)-avg_size-scale*width/2);
    max_x=min(width,centroid(1)+avg_size+scale*width/2);


    min_y=max(1,centroid(2)-avg_size-scale*height/2);
    max_y=min(width,centroid(2)+avg_size+scale*height/2);


    begin_point = 'begin_point'; begin_point_value=round([min_x,min_y]);
    end_point = 'end_point';  end_point_value=round([max_x,max_y]);
    
boundary = struct(begin_point,begin_point_value,end_point,end_point_value); 