

function M = SegmentImage(FileName,pas,DrawSquares,Threshold,Algo)


if nargin<2;pas=20;end 
if nargin<3;DrawSquares=false;end
if nargin<4;Threshold=1.3;end
if nargin<5;Algo=1;end 

    image_origine=imread(FileName);

    if (ndims(image_origine)==3)
        image_origine=rgb2gray(image_origine);
    end
    

M = SegmentMatrix(image_origine,pas,Algo,DrawSquares,Threshold, FileName);
    
