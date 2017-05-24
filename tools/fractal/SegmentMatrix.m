
function M = SegmentMatrix(Matrix,pas,Algo,DrawSquares,Threshold, FileName)


if nargin<2;pas=20;end 
if nargin<3;Algo=1;end 
if nargin<4;DrawSquares=false;end
if nargin<5;Threshold=1.3;end




    image_origine=Matrix;

    image_edge=edge(image_origine,'log');

    if( DrawSquares)
        image_squares = image_origine;
    end
    
color = 0; 
pas_step = pas;
            
for i=1:4
    
    MinSize=1/pas_step;
    MaxSize=1/2;
    NbBox=6;
    ShowInfos=0;
    DejaEdge=1;
    
    
    nX = floor(size(image_edge,2)/pas_step-1);
    nY = floor(size(image_edge,1)/pas_step-1);
    
    for x=0:nX
        for y=0:nY                
            if Algo
                averslope = BoxCountingFromImage(image_edge((1+y*pas_step):(y+1)*pas_step,(1+x*pas_step):(x+1)*pas_step),MinSize,MaxSize,NbBox,ShowInfos,DejaEdge);
            else
                averslope = hausdorff(image_edge((1+y*pas_step):(y+1)*pas_step,(1+x*pas_step):(x+1)*pas_step));
            end
            averslope = abs(averslope);
            M(1+y,1+x) = averslope;
            

            
                if DrawSquares && (M(1+y,1+x) > Threshold)
                    image_squares( 1+y*pas_step , (1+x*pas_step):(x+1)*pas_step )=color;
                    image_squares( (1+y)*pas_step , (1+x*pas_step):(x+1)*pas_step )=color;
                    image_squares( (1+y*pas_step):(y+1)*pas_step , 1+x*pas_step )=color;
                    image_squares( (1+y*pas_step):(y+1)*pas_step , (x+1)*pas_step )=color; 
                end;
            
        end
    end
    
    pas_step = pas_step-10;
    color = color + 60;
end
    
    if( DrawSquares)
        
        min_m=min(min(M));
        max_m=max(max(M));
        d=255.0/(max_m-min_m);
        M2=(floor((M-min_m)*d));
        
       
 imagesc(M2);
set(gca,'XTick',[]); % Remove the ticks in the x axis!
set(gca,'YTick',[]); % Remove the ticks in the y axis
set(gca,'Position',[0 0 1 1]) ;% Make the axes occupy the hole figure


for i=1:size(FileName,2)-4 
    grid_file(i)= FileName(i)
end;
grid_file=strcat(grid_file,'_grid.jpg');

saveas(gcf,grid_file);

    
        if Algo
               title('Fractals dimensions - Box Counting algorithm');     
        else
               title('Fractals dimensions - Hausdorff dimension ');  
        end
        
        
    
    end
    

        
    if( DrawSquares)
        figure;
        im1 = imshow(image_squares);  
        
       title('image_squares');
        
        
        figure;
        [mM,nM] = size(M);
        for i=1:mM
            yp(i)=22-i;
        end
        im2 = contour(1:nM,yp,M(1:mM,1:nM)); 
        title('contour');
        
        set(gca,'XTick',[]); % Remove the ticks in the x axis!
        set(gca,'YTick',[]); % Remove the ticks in the y axis
        set(gca,'Position',[0 0 1 1]) ;% Make the axes occupy the hole figure
        
        for i=1:size(FileName,2)-4 
            contour_file(i)=FileName(i);
        end
        contour_file=strcat(contour_file,'_contour.jpg');

        saveas(gcf,contour_file);

        
            
        grid_im = imread(grid_file);
        origine_im = imread (FileName);
        contour_im = imread(contour_file);
        
        n1 = size (grid_im,1);
        m1 = size (grid_im,2);
        n2 = size (origine_im,1);
        m2 = size (origine_im,2);
        n3 = size (contour_im,1);
        m3 = size (contour_im,2);
        
        n = min(n1,min(n2,n3));
        m = min (m1, min(m2,m3));
        
        grid = imresize(grid_im, [n m]);
        origine = imresize(origine_im, [n m]);
        cont = imresize(contour_im, [n m]);
        transparent=imlincomb(0.15, grid, 1, origine);
        figure;
        imshow(transparent) ;
        title('origine + colour grid');
        transparent2=imlincomb(0.3, cont, 1, transparent);
        figure;
        imshow(transparent2) ;
        title('origine + colour grid + contour');
        figure;
        transparent3=imlincomb(0.5, cont, 0.5, origine);
        imshow(transparent3) ;
        title('origine + contour');

    


    end
    

