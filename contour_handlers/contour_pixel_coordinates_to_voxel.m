
function contour_voxel =contour_pixel_coordinates_to_voxel(contour,dicom_info) 


vector(:,1)=[0,0,0,1];

M=dicom_coordinate_matrix(dicom_info);

dimenstion=size(contour,2);

for i=1:size(contour,1)
    
    point=contour(i,:);
    
    vector(1:dimenstion,1)=point;
    point_voxel=M*vector;
    contour_voxel(i,:)=point_voxel(1:dimenstion,1);
end


function M= dicom_coordinate_matrix(dicom_info)

info =dicom_info;
ipp=info.ImagePositionPatient;
iop=info.ImageOrientationPatient;
ps=info.PixelSpacing;
Tipp=[1 0 0 ipp(1); 0 1 0 ipp(2); 0 0 1 ipp(3); 0 0 0 1];
r=iop(1:3);  c=iop(4:6); s=cross(r',c');
R = [r(1) c(1) s(1) 0; r(2) c(2) s(2) 0; r(3) c(3) s(3) 0; 0 0 0 1];

if strcmp(info.MRAcquisitionType,'3D') % 3D turboflash
    S = [ps(2) 0 0 0; 0 ps(1) 0 0; 0 0 info.SliceThickness 0 ; 0 0 0 1];
else % 2D epi dti
    S = [ps(2) 0 0 0;0 ps(1) 0 0;0 0 info.SpacingBetweenSlices 0;0 0 0 1];
end

T0 = [ 1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
M = Tipp * R * S * T0;
