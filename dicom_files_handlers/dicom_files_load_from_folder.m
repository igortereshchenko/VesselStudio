function dicom_data = dicom_files_load_from_folder(order_type ) 

% default ordering  - descending
if (nargin < 1) || isempty(order_type)
  order_type = 'descend';
end

%-------------------------------------------------------------------------------------

source_pathfiles = uigetdir;% must be ONLY dicom files in this folder and not anymore (files with non-dicom formats)

dicom_file_list = dir(source_pathfiles);
count_of_files=length(dicom_file_list)-2; % skip . and .. folder

for i=1:count_of_files 
    images_to_order(:,:,i) = dicomread(strcat(source_pathfiles,'\',dicom_file_list(i+2).name));
    dicom_images_info_to_order(i) = dicominfo(strcat(source_pathfiles,'\',dicom_file_list(i+2).name));
    
    slice_location(i) = dicom_images_info_to_order(i).SliceLocation;
end

    % slice_location_sorted unused, only indexes for images and dicom_infos sort
    [slice_location_sorted,indexes_sorted] = sort(slice_location,order_type); 

for i=1:count_of_files
    images(:,:,i) = images_to_order(:,:,indexes_sorted(i));  
    dicom_images_info(i) = dicom_images_info_to_order(indexes_sorted(i));
end


dicom_data.images=images;
dicom_data.dicom_images_info=dicom_images_info;