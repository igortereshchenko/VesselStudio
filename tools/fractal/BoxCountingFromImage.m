

function DimFrac = BoxCountingFromImage(Image,MinSize,MaxSize,NbBox,ShowInfos,DejaEdge)

if nargin<2;MinSize=1/256;end
if nargin<3;MaxSize=1/2;end
if nargin<4;NbBox=10;end
if nargin<5;ShowInfos=0;end
if nargin<6;DejaEdge=0;end
    image_origine=Image;

    Size_img=size(image_origine);
    Height=Size_img(1);
    Width=Size_img(2);
    
    if ~DejaEdge
        image_edge=edge(image_origine,'log');
    else
        image_edge=image_origine;
    end

    
    if(ShowInfos)
        subplot(1,2,1);
        imshow(image_origine);title('Original Image'); 
        subplot(1,2,2);
        imshow(image_edge);title('Edged Image');
    end

    Pas=double(MaxSize);
    Pas2=Pas;
    inc=1;
    NbBoxFull=0;
    CountBoxNotNull=0;

    if double(1.0/MinSize) > Height
        MinSize=double(1.0/Height);
    end
    if double(1.0/MinSize) > Width
        MinSize=double(1.0/Width);
    end
    if double(1.0/MaxSize) <  2
        MaxSize=0.5;
    end

    NbBox=NbBox-1;
    pas_NbBox=abs(((log2(MinSize)-log2(MaxSize))/NbBox));
    
    if(ShowInfos)
        fprintf('|');
    end
    
    while Pas2>MinSize 
        nXY=int32(1/Pas)-1;
        Pas2=(1.0/double(nXY+1));
        PasImg=ceil(Pas2*(double(min(Height-1-nXY,Width-1-nXY))));
        
        if(Pas2 >= MinSize)
        for Xcount = 0:nXY
            i=PasImg*(Xcount)+1;
            k=i+PasImg;
            for Ycount = 0:nXY
                j=PasImg*(Ycount)+1;
                l=j+PasImg;
                Icount=i;
                n=0;
                while n==0 & Icount<k
                    Jcount=j;
                    while n==0 & Jcount<l
                        if(image_edge(Icount,Jcount)>0)
                            n=1;
                        end
                        Jcount=Jcount+1;
                    end
                    Icount=Icount+1;
                end
                if(n)
                    NbBoxFull=NbBoxFull+1;
                end
            end
          
        end
            if(NbBoxFull~=0)
                DimFracLine(:,inc)=[log2(double(1.0/Pas2)) log2(double(NbBoxFull))];
                CountBoxNotNull=1;
            end
        end
        Pas=Pas/2.0;

        if(ShowInfos)
            fprintf(' %d |',inc);
        end
        inc=inc+1;
        NbBoxFull=0; 
    end
    if CountBoxNotNull
        p = polyfit(DimFracLine(1,:),  DimFracLine(2,:),  1);
        if(ShowInfos)
            fprintf('\n\r Fractal dimension : ');
            figure;
            hold on;
            maxp=max(DimFracLine(1,:));
            plot(DimFracLine(1,:),DimFracLine(2,:),'-*');           
            hold off;
        end
        DimFrac = p(1);
        if(ShowInfos)
            disp(DimFrac);
        end
    else
        DimFrac = 0;
    end
    
