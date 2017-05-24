function [image,series_number_str,instance_number_str,slice_location_str,time_str]=slices_dataset_dicom_data_extraction_labels(slices_dataset,index)


 %slices_dataset(i)=struct('image',image,'dicom_info',dicom_info,'contour_data',contour_data)    ;


current_slice=slices_dataset(index);

dicom_info = current_slice.dicom_info;
image = current_slice.image;

series_number = dicom_info.SeriesNumber;             
instance_number = dicom_info.InstanceNumber;
slice_location = round(dicom_info.SliceLocation,2);
time=dicom_info.TriggerTime;


series_number_str = strcat('Series Number:',num2str(series_number));             
instance_number_str = strcat('Instance Number:',num2str(instance_number,'%05u'));
slice_location_str = strcat('Slice Location:',num2str(slice_location,4));
time_str=strcat('Trigger Time:',num2str(time));

