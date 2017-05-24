
image=0;
dicom_info=0;



geometry_characteristics = struct('area',0, 'perimeter',0, 'centroid', 0 ,'angle',0,'INER', 0, 'CPMO', 0);
characteristics_points_data = struct('coordinates',0, 'angle',0);

contour_data = struct('time',0, 'coordinates',0, 'geometry_characteristics', geometry_characteristics ,'characteristics_points_data', characteristics_points_data);

sclise = struct('image',image, 'dicom_info',dicom_info, 'contour_data', contour_data )