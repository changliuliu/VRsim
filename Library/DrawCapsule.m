%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function draws the capsules defined by 'boundary'
% with transformation matrix 'M'
%
% Changliu Liu
% 2015.8.5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function handle=DrawCapsule(boundary,M,valpha,color)

handle=[];
n=size(M,2);
for i=1:n
    X=boundary{i}.X;
    Y=boundary{i}.Y;
    Z=boundary{i}.Z;
    kd=size(X,1);jd=size(X,2);
    for k=1:kd
        for j=1:jd
            newvec=[X(k,j),Y(k,j),Z(k,j)]*M{i}(1:3,1:3)'+M{i}(1:3,4)';
            X(k,j)=newvec(1);
            Y(k,j)=newvec(2);
            Z(k,j)=newvec(3);
        end
    end
    handle(i)=surf(X,Y,Z,'FaceColor',color,'EdgeColor','None');
    alpha(handle(i),valpha);
end
