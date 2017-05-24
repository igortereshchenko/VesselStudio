% Divide series by time step in separate folder and collect dicom files in series


%selected_series=[22,17,18,24,19,25,20,26,21,32,23,11,16,10,15,9,8,13,14,5]; 

%selected_series=[9,10,11,14,15,16,17,18,19,20,22,23,24,25]; 

selected_series=9:1:68;

max_slice_location=42;
min_slice_location=-86;

% source folder must!!! have only dicom files
target_pathfile = uigetdir;
cd(target_pathfile)

dicom_file_list = dir(target_pathfile);


% Result folder

target_folder_name = uigetdir;


% common unique ID to collect series
uid = dicomuid;


% first element . second .. - file system folder
count_of_files=length(dicom_file_list);

w = waitbar(0,'This process may take a few minutes');

for i=3:count_of_files
    
    dicom_file = dicomread(dicom_file_list(i).name);
    dicom_info = dicominfo(dicom_file_list(i).name);
    
    
    if ~isempty(find(selected_series==round(dicom_info.SeriesNumber))) % choose series
    
         slice_location = dicom_info.SliceLocation; 
         
         if (slice_location>=min_slice_location)&&(slice_location<=max_slice_location)

         series_number_str = num2str(dicom_info.SeriesNumber,'%05u');             
         instance_number_str = num2str(dicom_info.InstanceNumber,'%05u');
         slice_location_str = num2str(round(slice_location,2),4);
 
    
         SliceLocation_i_folder = strcat('SliceLocation_',slice_location_str);
    
 
         dicom_file_name = strcat(series_number_str,'_',instance_number_str);
    
         dicom_file_path = strcat(target_folder_name,'\',SliceLocation_i_folder);
         dicom_file_path_full=strcat(dicom_file_path, '\',dicom_file_name);
    
    
         if ~exist(dicom_file_path,'dir')
             mkdir(dicom_file_path);
         end
    
   
%          dicom_info.SeriesInstanceUID = uid; % old series ID lost
%          dicom_info.SeriesNumber = 1; % 1 series per folder
%          
%          
%          slice_location = dicom_info.SliceLocation;
%          
%          %instance_number = strtoint(series_number);
%          instance_number = 100000+round(slice_location*100);
%          
%          dicom_info.InstanceNumber = instance_number;
         
         dicomwrite(dicom_file, dicom_file_path_full, dicom_info, 'CreateMode', 'copy');
        end;
    end
     waitbar((i-3)/count_of_files);
end

delete(w);
