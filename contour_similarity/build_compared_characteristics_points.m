function [compared_characteristics_points_data] = build_compared_characteristics_points(contour_data, pattern_contour_data,count_of_points,epsilon,angle,current_axes)


%count of point = count_of_points+1 closed contour
pattern_contour_character_points_data = pattern_contour_data.characteristics_points_data;
contour_character_points_data = contour_characteristics_points_data_by_pattern(contour_data, pattern_contour_data,angle);

pattern_centroid=pattern_contour_data.geometry_characteristics.centroid;
centroid=contour_data.geometry_characteristics.centroid;


index=[1:count_of_points];

for i=1:count_of_points+1
    pattern_r(i)=distance_between_points(pattern_centroid,pattern_contour_character_points_data.coordinates(i,:));
    
    r(i)=distance_between_points(centroid,contour_character_points_data.coordinates(i,:));
end;


%____________________________________________
% similarity by derivative

% index_=[1:count_of_points+1];
% dydx1 = diff(pattern_r(:))./diff(index_(:));
% dydx2 = diff(r(:))./diff(index_(:));

%____________________________________________

while(true)
    
index_of_common_intervals=[];


current_pos=1;
interval_open=false;

% index_of_common_intervals = { (begin_point, end_point),... }
% last interval can be described like (begin_point, count_of_points+1) -- overflow of indexes

for i=1:count_of_points
    if abs(pattern_r(i)-r(i))<epsilon %abs(dydx1(i)-dydx2(i))<0.06  
        if ~interval_open
            interval_open=true;
            index_of_common_intervals(current_pos)=i; %mark begin of interval
            current_pos=current_pos+1;            
        end;
    else
       if interval_open
            interval_open=false;
            index_of_common_intervals(current_pos)=i; %mark end of interval
            current_pos=current_pos+1;
       end;
        
       interval_open=false; 
    end;
end;

% close last interval if open
if interval_open
   index_of_common_intervals(current_pos)=count_of_points+1; 
end;


    if ~isempty(index_of_common_intervals)
        break; 
    end 
    epsilon=epsilon*1.1; % 10% epsilon  up
end


contour_character_points_data_interpolated=[];

%         % plot initial data
%         figure
%         plot(pattern_contour_data.coordinates(:,1),pattern_contour_data.coordinates(:,2));
%         hold on;
%         plot(contour_data.coordinates(:,1),contour_data.coordinates(:,2));
% 
%         hold on;
%         plot(pattern_contour_character_points_data.coordinates(:,1),pattern_contour_character_points_data.coordinates(:,2),'r*');
%         hold on;
%         plot(contour_character_points_data.coordinates(:,1),contour_character_points_data.coordinates(:,2),'b*');
% 
% 
%         %--------plot common points--------
%         
%         for k=1:size(index_of_common_intervals,2)/2
%             i=(k-1)*2+1;
%             index=index_of_common_intervals(i):index_of_common_intervals(i+1);
%             
%             hold on
%             plot(pattern_contour_character_points_data.coordinates(index,1),pattern_contour_character_points_data.coordinates(index,2),'g*');
%             
%             hold on
%             plot(contour_character_points_data.coordinates(index,1),contour_character_points_data.coordinates(index,2),'g*');
%             
%         end;


for k=1:(size(index_of_common_intervals,2)/2) % count of intervals which consists of 2 points
    
    i=(k-1)*2+1;  % matrix to vector { (begin_point, end_point),... (begin_point, end_point)}  
    
    interval_begin=index_of_common_intervals(i);
    interval_end=index_of_common_intervals(i+1)-1; %end of interval not fit condition of similarity
    

    
    interval=contour_character_points_data.coordinates(interval_begin:interval_end,:);
    contour_character_points_data_interpolated=vertcat(contour_character_points_data_interpolated,interval);    
    
    
    if i+2<=size(index_of_common_intervals,2)
    
        next_interval_begin=index_of_common_intervals(i+2);


        count_of_points_inverval_interpolated=next_interval_begin-interval_end-1+2; %count of coints inside interval + 2 boundary


        interval=contour_character_points_data.coordinates(interval_end:next_interval_begin,:);    
        interval_interpolated=curve_to_equals_lines(interval,count_of_points_inverval_interpolated);    
        
        %delete first and last point of interpolater interval as they are already included

        contour_character_points_data_interpolated=vertcat(contour_character_points_data_interpolated,interval_interpolated(2:size(interval_interpolated,1)-1,:));    
    else
        %first part of interval from frist point to first interval
        if index_of_common_intervals(1)~=1
            first_part_interval=contour_character_points_data.coordinates(1:index_of_common_intervals(1),:);
        else
            first_part_interval=[];    
        end
        
        %second part of interval from last point to last interval to first point
        if index_of_common_intervals(size(index_of_common_intervals,2))~=count_of_points+1
            second_part_interval=contour_character_points_data.coordinates(index_of_common_intervals(size(index_of_common_intervals,2))-1:count_of_points,:);
        else
            second_part_interval=[];
        end;
        
        interval=vertcat(second_part_interval,first_part_interval);
        if ~isempty(interval)
            interval_interpolated=curve_to_equals_lines(interval,size(interval,1));

            %get interpolated first part
            if ~isempty(first_part_interval)
                first_part_interval_interpolated=interval_interpolated(size(second_part_interval,1)+1:size(interval_interpolated,1)-1,:); % common first point as contour is closed
            else
                first_part_interval_interpolated=[];
            end;
            %get interpolated second part  
            if ~isempty(second_part_interval)            
                second_part_interval_interpolated=interval_interpolated(2:size(second_part_interval,1),:);
            else
                second_part_interval_interpolated=[];
            end;


            contour_character_points_data_interpolated=vertcat(first_part_interval_interpolated,contour_character_points_data_interpolated,second_part_interval_interpolated);    
        end;

        % close contour by first point
        contour_character_points_data_interpolated=vertcat(contour_character_points_data_interpolated,contour_character_points_data_interpolated(1,:));                

    end;
end;



if  (nargin==6)
    axes(current_axes);
    cla(current_axes);
        d_angle=-angle;%-(angle-pattern_contour_data.characteristics_points_data.angle);

        % rotate pattern
        plot_and_rotate_contour (pattern_contour_data.coordinates,d_angle,pattern_centroid,centroid,current_axes,'b');
        % rotate pattern contour character points
        hold on
        plot_and_rotate_contour (pattern_contour_character_points_data.coordinates,d_angle,pattern_centroid,centroid,current_axes,'b*');
        
        
        hold on;
        plot(contour_data.coordinates(:,1),contour_data.coordinates(:,2),'r');
        
%         hold on;
%         plot(contour_character_points_data.coordinates(:,1),contour_character_points_data.coordinates(:,2),'r*');


        %--------plot common points--------
        
        for k=1:size(index_of_common_intervals,2)/2
            i=(k-1)*2+1;
            index=index_of_common_intervals(i):index_of_common_intervals(i+1);
            
            hold on
            plot(contour_character_points_data.coordinates(index,1),contour_character_points_data.coordinates(index,2),'c*');


            %plot pattern rotated
            hold on
            plot_and_rotate_contour (pattern_contour_character_points_data.coordinates(index,:),d_angle,pattern_centroid,centroid,current_axes,'g*');            
            
        end;

        hold on;
        plot(contour_character_points_data_interpolated(:,1),contour_character_points_data_interpolated(:,2),'m+');   
        %legend('base contour','base contour points','current contour','current contour points','common points on base','common points on current');%,'Location','northoutside','Orientation','horizontal');        
        legend('base contour','base contour points','current contour','common points on base','common points on current');%,'Location','northoutside','Orientation','horizontal');                
        
end;

contour_character_points_data.coordinates=contour_character_points_data_interpolated;
contour_character_points_data.angle=pattern_contour_character_points_data.angle+angle;

compared_characteristics_points_data=contour_character_points_data;
