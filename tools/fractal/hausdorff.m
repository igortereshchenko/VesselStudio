
function D=hausdorff(IMAGE)
[M,N]=size(IMAGE);

[i,j]=size(IMAGE);

if M > N
 r=M;
else
 r=N;
end

 
 D=log(sum(reshape(IMAGE,i*j,1)))/log(r);
 
 
if D<-2
 D=1;
end

