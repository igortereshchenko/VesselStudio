function [image,series_number,instance_number,slice_location,time]=dicom_data_extraction(dicom_dataset,index)

dicom_info = dicom_dataset.dicom_images_info(index);
image = dicom_dataset.images(:,:,index);

series_number = dicom_info.SeriesNumber;             
instance_number = dicom_info.InstanceNumber;
slice_location = round(dicom_info.SliceLocation,2);
time=dicom_info.TriggerTime;

