function go_segmentImage


global f       
global hImage  
global hNoEdges
global hWindows
global hThreshold
global hEstimated


image = get(hImage, 'String');
no_edges = str2num(get(hNoEdges, 'String'));
windows = get(hWindows, 'Value');
threshold = str2double(get(hThreshold, 'String'));
etimated = get(hEstimated, 'Value');

if etimated
	Algo=0;
else
	Algo=1;
end


sizeNomImg=size(image,2);
i=1;i2=1;j=1;
for i=1:sizeNomImg
    if (image(1,i)==';')
         j=j+1;
         i2=1;
    else
         ArrayImg(j,i2)=image(1,i);
         i2=i2+1;
     end
end

for i=1:j
    image = ArrayImg(i,:);
    strcat('Results of l image : ' ,  image)
    figure,
    M = SegmentImage(image,no_edges,windows,threshold,Algo)



    if ~windows
            image_origine=imread(image);
            image_squares = imcrop(image_origine,[0 0 size(image_origine,2) (size(image_origine,1)-120)]);
        nX = floor(size(image_squares,2)/no_edges)-1;
            nY = floor(size(image_squares,1)/no_edges)-1;
        for x=0:nX
                for y=0:nY          

                  if  M(1+y,1+x) > threshold
               		 image_squares( 1+y*no_edges:2+y*no_edges , (1+x*no_edges):(x+1)*no_edges )=255;
              		  image_squares( (1+y)*no_edges:1+(1+y)*no_edges , (1+x*no_edges):(x+1)*no_edges )=255;
              		  image_squares( (1+y*no_edges):(y+1)*no_edges , 1+x*no_edges:2+x*no_edges )=255;
              		  image_squares( (1+y*no_edges):(y+1)*no_edges , (x+1)*no_edges: 1+(x+1)*no_edges )=255;
                 end

                end
            end
        imshow(image_squares);
    end

end
