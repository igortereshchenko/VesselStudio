
function [contour]=points_to_closed_contour(Xin,Yin)

[Xout,Yout]=points_to_contour(Xin,Yin,1,'cw'); %2

 %close contour if it unclosed
if (Xout(length(Xout))~=Xout(1))||(Yout(length(Yout))~=Yout(1))
 Xout(length(Xout)+1)=Xout(1);
 Yout(length(Yout)+1)=Yout(1);
end;

 contour(:,1)=Xout;
 contour(:,2)=Yout;
