function [similarity_r,similarity_dr,r1,r2,dr1,dr2] = contour_similarity_by_characteristics_points(characteristics_points,centroid, characteristics_points_to_compare,centroid_to_compare)

if size(characteristics_points,1)~=size(characteristics_points_to_compare,1)
    similarity=0; 
    return;
end;

sum=0;

for i=1: size(characteristics_points,1)
    
    r1(i)=distance_between_points(characteristics_points(i,:),centroid);
    r2(i)=distance_between_points(characteristics_points_to_compare(i,:),centroid_to_compare);
    sum = sum+ (  r1(i)- r2(i) )^2;
end;



sum_dr=0;
index_=[1:size(characteristics_points,1)];

dr1 = diff(r1(:))./diff(index_(:));
dr2 = diff(r2(:))./diff(index_(:));

for i=1: size(dr1,1)
 
    sum_dr = sum_dr+ (  dr1(i)- dr2(i) )^2;
end;




similarity_r=1/sum;
similarity_dr=1/sum_dr;
