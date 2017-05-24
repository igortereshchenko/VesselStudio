function plot_and_rotate_contour (contour,angle,own_centroid,centroid,current_axes,color)

    if  (nargin<3)
        figure
    else
        axes(current_axes);
    end;
    
    if  (nargin<4)
        color='r';
    end;
    if isempty(own_centroid)
        geometry_characteristics = contour_geometry_characteristics( contour );
        own_centroid=geometry_characteristics.centroid;
    end;
    
    if isempty(centroid)
       centroid= own_centroid;
    end
    
    [theta,rho] = cart2pol(contour(:,1)-own_centroid(1),contour(:,2)-own_centroid(2));           
    theta=theta-angle;

    [contour(:,1),contour(:,2)] = pol2cart(theta,rho);    

    contour(:,1)=contour(:,1)+centroid(1);
    contour(:,2)=contour(:,2)+centroid(2);

    hold on;
    plot(contour(:,1),contour(:,2),color);
        
    