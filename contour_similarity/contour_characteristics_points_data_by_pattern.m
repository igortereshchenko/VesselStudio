function [contour_character_points_data] = contour_characteristics_points_data_by_pattern(contour_data, pattern_contour_data,initial_angle)


%calculate angle in polar coordinates for pattern contour

pattern_centroid=pattern_contour_data.geometry_characteristics.centroid;
pattern_contour=pattern_contour_data.characteristics_points_data.coordinates;

[theta,rho] = cart2pol(pattern_contour(:,1)-pattern_centroid(1),pattern_contour(:,2)-pattern_centroid(2));



epsilon=0.00001;

centroid=contour_data.geometry_characteristics.centroid;
coordinates=contour_data.coordinates;

contour_character_points=[];


for i=1:size(theta,1)
    
    d_angle=theta(i)+initial_angle;%!!!! attention
    
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