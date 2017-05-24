function [contour,area_str,perimeter_str,angle_str,centroid_str]=slices_dataset_contour_data_extraction_labels(slices_dataset,index)


 %slices_dataset(i)=struct('image',image,'dicom_info',dicom_info,'contour_data',contour_data)    ;


current_slice=slices_dataset(index);

contour_data = current_slice.contour_data;

contour=contour_data.coordinates;

area_str = strcat('Area:',num2str(contour_data.geometry_characteristics.area));             
perimeter_str = strcat('Perimeter:',num2str(contour_data.geometry_characteristics.perimeter));
angle_str = strcat('Angle:',num2str(contour_data.geometry_characteristics.angle));
centroid_str=strcat('Centroid:[',num2str(contour_data.geometry_characteristics.centroid(1)),';'...
                ,num2str(contour_data.geometry_characteristics.centroid(2)),']');

