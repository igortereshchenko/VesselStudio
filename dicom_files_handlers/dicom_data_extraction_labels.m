function [image,series_number_str,instance_number_str,slice_location_str,time_str]=dicom_data_extraction_labels(dicom_dataset,index)



[image,series_number,instance_number,slice_location,time]=dicom_data_extraction(dicom_dataset,index);


series_number_str = strcat('Series Number:',num2str(series_number));             
instance_number_str = strcat('Instance Number:',num2str(instance_number,'%05u'));
slice_location_str = strcat('Slice Location:',num2str(slice_location,4));
time_str=strcat('Trigger Time:',num2str(time));

