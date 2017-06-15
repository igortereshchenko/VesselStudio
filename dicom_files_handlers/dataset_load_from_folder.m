function slices_dataset = dataset_load_from_folder(order_type ) 

% default ordering  - descending
if (nargin < 1) || isempty(order_type)
  order_type = 'ascend';
end

%-------------------------------------------------------------------------------------

source_pathfiles = uigetdir;% must be ONLY dicom files in this folder and not anymore (files with non-dicom formats)

dicom_file_list = dir(source_pathfiles);
count_of_files=length(dicom_file_list)-2; % skip . and .. folder

for i=1:count_of_files 
    images_to_order(:,:,i) = dicomread(strcat(source_pathfiles,'\',dicom_file_list(i+2).name));
    dicom_images_info_to_order(i) = dicominfo(strcat(source_pathfiles,'\',dicom_file_list(i+2).name));
    
    slice_location(i) = dicom_images_info_to_order(i).TriggerTime;
end

    % slice_location_sorted unused, only indexes for images and dicom_infos sort
    [slice_location_sorted,indexes_sorted] = sort(slice_location,order_type); 

for i=1:count_of_files
    image = images_to_order(:,:,indexes_sorted(i));  
    dicom_info = dicom_images_info_to_order(indexes_sorted(i));

    time = dicom_images_info_to_order(indexes_sorted(i)).TriggerTime;

    %geometry_characteristics = struct('area',[], 'perimeter',[], 'centroid', [] ,'angle',[],'INER', [], 'CPMO', []);
    %characteristics_points_data = struct('coordinates',[], 'angle',[]);

    contour_data = struct('time',time, 'coordinates',[], 'geometry_characteristics', [] ,'characteristics_points_data', []);

    sclise = struct('image',image, 'dicom_info',dicom_info, 'contour_data', contour_data );
    
    slices_dataset(i)=sclise;
    
end


