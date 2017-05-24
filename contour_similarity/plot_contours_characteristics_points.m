function plot_contours_characteristics_points (slice_dataset,plot_name,current_axes,color)

    if  (nargin<3)
        figure
    else
        axes(current_axes);
    end;
    
    if  (nargin<4)
        color='r';
    end;
    
    
    n=size(slice_dataset,2);
%     n=3;
    
        for i=1:n

            contour_coordinates_2D=slice_dataset(i).contour_data.coordinates;
            z1(1:size(slice_dataset(i).contour_data.coordinates,1)) = slice_dataset(i).contour_data.time;
            hold on
            p1=plot3(contour_coordinates_2D(:,1),contour_coordinates_2D(:,2),z1,color) ;

            
            characteristics_contour_coordinates_2D=slice_dataset(i).contour_data.characteristics_points_data.coordinates;
            z2(1:size(slice_dataset(i).contour_data.characteristics_points_data.coordinates,1)) = slice_dataset(i).contour_data.time;            
            hold on
            p2=plot3(characteristics_contour_coordinates_2D(:,1),characteristics_contour_coordinates_2D(:,2),z2,strcat(color,'*')) ;
            

           pause(0.5);
%             delete(p1);
%             delete(p2);

        end;
        title(plot_name)
