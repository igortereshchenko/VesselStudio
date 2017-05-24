function [contour_character_points_data] = contour_characteristics_points_data(contour_data, count_of_points,initial_angle)

epsilon=0.00001;

centroid=contour_data.geometry_characteristics.centroid;
coordinates=contour_data.coordinates;

contour_character_points=[];


for d_angle=initial_angle:2*pi/(count_of_points):2*pi+initial_angle
    
    x(1)=centroid(1);
    y(1)=centroid(2);
    
    if abs(d_angle-pi/2)<epsilon
        x(2)=centroid(1);
        y(2)=300;
        
    elseif abs(d_angle+pi/2)<epsilon
        x(2)=centroid(1);
        y(2)=0;
    else
        k=tan(d_angle);    

        if (d_angle>=0)
            if (d_angle>(3*pi/2)) || (d_angle<pi/2)
                x(2)=300; %max image coordinate
            else
                x(2)=0; %min image coordinate
            end;

        else % d_angle<0
            if (d_angle>(-3*pi/2)) && (d_angle<-pi/2)
                  x(2)=0; %min image coordinate
            else
                x(2)=300; %max image coordinate
            end;

        end;

        y(2)=k*(x(2)-centroid(1))+centroid(2);
    end;

    [xi,yi] = polyxpoly(coordinates(:,1),coordinates(:,2),x,y,'unique');
    
    contour_character_points=vertcat( contour_character_points,[xi,yi]);
end;


contour_character_points_data=struct ('coordinates',contour_character_points,'angle',initial_angle);