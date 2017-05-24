function  [vessel_contour_coordinates]  = contour_recognition( dicom_image, initial_vessel_block_boundary, initial_vessel_countour_coordinates,contour_recognition_parameters)


% struct initial_vessel_block_boundary{
%     int begin_point(x,y)
%     int end_point(x,y)
% } 




%% parameter setting
    timestep=contour_recognition_parameters.time_step;  % time step
    mu=0.2/timestep;  % coefficient of the distance regularization term R(phi)
    iter_inner=contour_recognition_parameters.count_of_inner_iteration;
    iter_outer=contour_recognition_parameters.count_of_outer_itereation;
    lambda=contour_recognition_parameters.lambda; % coefficient of the weighted length term L(phi)
    alfa=contour_recognition_parameters.alfa;  % coefficient of the weighted area term A(phi)
    epsilon=contour_recognition_parameters.epsilon; % papramater that specifies the width of the DiracDelta function
    sigma=contour_recognition_parameters.sigma;    % scale parameter in Gaussian kernel

    scale_level=contour_recognition_parameters.scale_level;
    vessel_boundary=contour_recognition_parameters.vessel_thickness;
    count_of_envelope_points=contour_recognition_parameters.count_of_envelope_points;
    

 
image=dicom_image(initial_vessel_block_boundary.begin_point(2):initial_vessel_block_boundary.end_point(2),initial_vessel_block_boundary.begin_point(1):initial_vessel_block_boundary.end_point(1));

temp=imresize(image,scale_level);
Img=double(temp(:,:,1));


% generate the initial region using initial_vessel_countour_coordinates

[initial_vessel_points_x,initial_vessel_points_y] = meshgrid(initial_vessel_block_boundary.begin_point(1):initial_vessel_block_boundary.end_point(1),initial_vessel_block_boundary.begin_point(2):initial_vessel_block_boundary.end_point(2));
[height,width]=size(initial_vessel_points_x);
initial_vessel_points_x = reshape( initial_vessel_points_x.' ,1,numel(initial_vessel_points_x));
initial_vessel_points_y = reshape( initial_vessel_points_y.' ,1,numel(initial_vessel_points_y));
initial_vessel_points = inpolygon(initial_vessel_points_x,initial_vessel_points_y,initial_vessel_countour_coordinates(:,1),initial_vessel_countour_coordinates(:,2));


% initialize LSF as binary step function
c0=2;
initialLSF=reshape(initial_vessel_points,[width,height]);
initialLSF=imresize(transpose(initialLSF),scale_level);

%filtering corners of mask

edges = edge(double(initialLSF),'canny');
smoothed_edges = imdilate(edges,strel('disk',round(scale_level*0.25)));
initialLSF=(smoothed_edges+initialLSF)>0.1;


initialLSF=initialLSF.*-c0;
initialLSF=(c0*ones(size(initialLSF))+initialLSF)+initialLSF;

phi=initialLSF;


G=fspecial('gaussian',15,sigma); % Caussian kernel
Img_smooth=conv2(Img,G,'same');  % smooth image by Gaussiin convolution
[Ix,Iy]=gradient(Img_smooth);
f=Ix.^2+Iy.^2;
g=1./(1+f);  % edge indicator function.



%potentialFunction = 'single-well';  % use single well potential p1(s)=0.5*(s-1)^2, which is good for region-based model 
potentialFunction = 'double-well';  % use double-well potential in Eq. (16), which is good for both edge and region based models

% start level set evolution
for n=1:iter_outer
    phi = drlse_edge(phi, g, lambda, mu, alfa, epsilon, timestep, iter_inner, potentialFunction);    
end

% refine the zero level contour by further level set evolution with alfa=0
alfa=0;
phi = drlse_edge(phi, g, lambda, mu, alfa, epsilon, timestep, iter_inner, potentialFunction);

contour_coordinates_scale=contourc(phi,[vessel_boundary,vessel_boundary]);



%resize coordinates back according to scale_level
contour_coordinates=contour_coordinates_scale(:,2:size(contour_coordinates_scale,2))/scale_level;



%resclaling by count of points
vessel_contour_coordinates=curve_to_equals_lines(transpose(contour_coordinates),count_of_envelope_points);

vessel_contour_coordinates(:,1)=vessel_contour_coordinates(:,1)+initial_vessel_block_boundary.begin_point(1)-1;
vessel_contour_coordinates(:,2)=vessel_contour_coordinates(:,2)+initial_vessel_block_boundary.begin_point(2)-1;



end

