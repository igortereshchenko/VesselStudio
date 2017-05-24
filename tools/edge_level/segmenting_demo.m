clear all;
close all;
Img = imread('Capture.JPG'); 
imshow(Img);
Img=double(Img(:,:,1));
%% Начальные параметры
timestep=5;  
mu=0.2/timestep;  
iter_inner=5;
iter_outer=40;
lambda=5; 
alfa=1.5; 
epsilon=1.5; 
sigma=1.5;  
G=fspecial('gaussian',15,sigma);
Img_smooth=conv2(Img,G,'same'); 
[Ix,Iy]=gradient(Img_smooth);
f=Ix.^2+Iy.^2;
g=1./(1+f);  
c0=2;
initialLSF=c0*ones(size(Img));
initialLSF(10:55, 10:75)=-c0;  
phi=initialLSF;
%figure(1);
%mesh(-phi);   % for a better view, the LSF is displayed upside down
%hold on;  contour(phi, [0,0], 'r','LineWidth',2);
%title('Begin level set function');
%view([-80 35]);

%figure(2);
%imagesc(Img,[0, 255]); axis off; axis equal; colormap(gray); hold on;  contour(phi, [0,0], 'r');
%title('Begin zero level contour');
%pause(0.5);
potential=2;  
if potential ==1
    potentialFunction = 'single-well'; 
elseif potential == 2
    potentialFunction = 'double-well';  
else
    potentialFunction = 'double-well';  
end
% начало level set evolution
for n=1:iter_outer
    phi = level_set_edge(phi, g, lambda, mu, alfa, epsilon, timestep, iter_inner, potentialFunction);
    if mod(n,2)==0
        figure(2);
        imagesc(Img,[0, 255]); axis off; axis equal; colormap(gray); hold on;  contour(phi, [0,0], 'r');
    end
end
% Переопределяем контур приняв alpha = 0
alfa=0;
iter_refine = 10;
phi = level_set_edge(phi, g, lambda, mu, alfa, epsilon, timestep, iter_inner, potentialFunction);
finalLSF=phi;
figure(2);
imagesc(Img,[0, 255]); axis off; axis equal; colormap(gray); hold on;  contour(phi, [0,0], 'r');
hold on;  contour(phi, [0,0], 'r');
%str=['Final zero level contour, ', num2str(iter_outer*iter_inner+iter_refine), ' iterations'];
%title(str);
[x,y] = contour(phi, [0,0], 'r');
x
figure;
mesh(-finalLSF); 
hold on;  contour(phi, [0,0], 'r','LineWidth',2);
str=['Final level set function, ', num2str(iter_outer*iter_inner+iter_refine), ' iterations'];
title(str);
axis on;


