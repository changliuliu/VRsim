%%%%%%%%%%%%%%%%%%%%%%
% Plot M16iB robot arm
% By: Changliu Liu
% 2015.8.1
%%%%%%%%%%%%%%%%%%%%%%

addpath('/Users/changliuliu/Matlab/M16iB 3D game/Data');
load('Data/M16iB-figure.mat');
robot=robotproperty(3);
figure(1);hold on

%% Base
for i=1:2
    f=base{i}.f; v=base{i}.v; c=base{i}.c; color=base{i}.color;
    patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
end

%% links
M={};
M{1}=eye(4);
DH=robot.DH;
for i=1:6
    R=[cos(DH(i,1)) -sin(DH(i,1))*cos(DH(i,4)) sin(DH(i,1))*sin(DH(i,4));
        sin(DH(i,1)) cos(DH(i,1))*cos(DH(i,4)) -cos(DH(i,1))*sin(DH(i,4));
        0  sin(DH(i,4)) cos(DH(i,4))];
    T=[DH(i,3)*cos(DH(i,1));DH(i,3)*sin(DH(i,1));DH(i,2)];
    M{i+1}=M{i}*[R T;zeros(1,3) 1];
end

for i=1:6
    v=link{i}.v; f=link{i}.f; c=link{i}.c; color=link{i}.color;
    for j=1:size(v,1)
        v(j,:)=v(j,:)*M{i+1}(1:3,1:3)'+M{i+1}(1:3,4)'.*1000;
    end
    patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
    if i==1 || i==3
        for k=1:4
            v=link{i}.motor{k}.v; f=link{i}.motor{k}.f; c=link{i}.motor{k}.c; color=link{i}.motor{k}.color;
            for j=1:size(v,1)
                v(j,:)=v(j,:)*M{i+1}(1:3,1:3)'+M{i+1}(1:3,4)'.*1000;
            end
            patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
        end
    end
    
end

%% Payload
i=6;
v=payload.v;f=payload.f;c=payload.c;color=payload.color;
for j=1:size(v,1)
    v(j,:)=v(j,:)*M{i+1}(1:3,1:3)'+M{i+1}(1:3,4)'.*1000;
end
patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');

%% Draw boundary
boundary={}; % The handles;
valpha=0.3; r=260; hight=500;
[X1,Y1,Z1]=sphere;
nd=size(X1,1);md=(nd+1)/2;
X=[X1(md,:).*r;X1(md:nd,:).*r];
Y=[Y1(md,:).*r;Y1(md:nd,:).*r];
Z=[Z1(md,:).*0;Z1(md:nd,:).*r+hight];
i=1;
boundary{i}.X=X;boundary{i}.Y=Y;boundary{i}.Z=Z;
boundary{i}.handle=surf(X,Y,Z);
alpha(boundary{i}.handle,valpha);
%% link1
r=150;offset1=-100;offset2=100;
[X,Y,Z]=sphere;
X=X.*r;
Y=Y.*r;
Z=Z.*r;
nd=size(Z,1);md=(nd+1)/2;
Z(1:md-1,:)=Z(1:md-1,:)+offset1;
Z(md:nd,:)=Z(md:nd,:)+offset2;
i=2;
boundary{i}.X=X;boundary{i}.Y=Y;boundary{i}.Z=Z;
for k=1:nd
for j=1:nd
    newvec=[X(k,j),Y(k,j),Z(k,j)]*M{2}(1:3,1:3)'+M{2}(1:3,4)'.*1000;
    X(k,j)=newvec(1);
    Y(k,j)=newvec(2);
    Z(k,j)=newvec(3);
end
end
boundary{i}.handle=surf(X,Y,Z);
alpha(boundary{i}.handle,valpha);
%% link2
r=130;offset1=-750;offset2=0;
[X1,Y1,Z1]=sphere;
nd=size(X1,1);md=(nd+1)/2;
X(1:md-1,:)=Z1(1:md-1,:).*r+offset1;
X(md:nd,:)=Z1(md:nd,:).*r+offset2;
Y=X1.*r;
Z=Y1.*r-150;
i=3;
boundary{i}.X=X;boundary{i}.Y=Y;boundary{i}.Z=Z;
for k=1:nd
for j=1:nd
    newvec=[X(k,j),Y(k,j),Z(k,j)]*M{3}(1:3,1:3)'+M{3}(1:3,4)'.*1000;
    X(k,j)=newvec(1);
    Y(k,j)=newvec(2);
    Z(k,j)=newvec(3);
end
end
boundary{i}.handle=surf(X,Y,Z);
alpha(boundary{i}.handle,valpha);
%% link3
r=220;offset1=0;offset2=0;
[X,Y,Z]=sphere;
X=X.*r-30;
Y=Y.*r;
Z=Z.*r+50;
nd=size(Z,1);md=(nd+1)/2;
Z(1:md-1,:)=Z(1:md-1,:)+offset1;
Z(md:nd,:)=Z(md:nd,:)+offset2;
i=4;
boundary{i}.X=X;boundary{i}.Y=Y;boundary{i}.Z=Z;
for k=1:nd
for j=1:nd
    newvec=[X(k,j),Y(k,j),Z(k,j)]*M{4}(1:3,1:3)'+M{4}(1:3,4)'.*1000;
    X(k,j)=newvec(1);
    Y(k,j)=newvec(2);
    Z(k,j)=newvec(3);
end
end
boundary{i}.handle=surf(X,Y,Z);
alpha(boundary{i}.handle,valpha);
%% link4
r=110;offset1=0;offset2=550;
[X1,Y1,Z1]=sphere;
X=X1.*r;
Y=Z1.*r;
Z=Y1.*r;
nd=size(Z,1);md=(nd+1)/2;
Y(1:md-1,:)=Y(1:md-1,:)+offset1;
Y(md:nd,:)=Y(md:nd,:)+offset2;
i=5;
boundary{i}.X=X;boundary{i}.Y=Y;boundary{i}.Z=Z;
for k=1:nd
for j=1:nd
    newvec=[X(k,j),Y(k,j),Z(k,j)]*M{5}(1:3,1:3)'+M{5}(1:3,4)'.*1000;
    X(k,j)=newvec(1);
    Y(k,j)=newvec(2);
    Z(k,j)=newvec(3);
end
end
boundary{i}.handle=surf(X,Y,Z);
alpha(boundary{i}.handle,valpha);

%% link5
r=70;offset1=-50;offset2=100;
[X,Y,Z]=sphere;
X=X.*r;
Y=Y.*r;
Z=Z.*r;
nd=size(Z,1);md=(nd+1)/2;
Z(1:md-1,:)=Z(1:md-1,:)+offset1;
Z(md:nd,:)=Z(md:nd,:)+offset2;
i=6;
boundary{i}.X=X;boundary{i}.Y=Y;boundary{i}.Z=Z;
for k=1:nd
for j=1:nd
    newvec=[X(k,j),Y(k,j),Z(k,j)]*M{6}(1:3,1:3)'+M{6}(1:3,4)'.*1000;
    X(k,j)=newvec(1);
    Y(k,j)=newvec(2);
    Z(k,j)=newvec(3);
end
end
boundary{i}.handle=surf(X,Y,Z);
alpha(boundary{i}.handle,valpha);
%% link6
r=110;offset1=-110;offset2=-110;
[X1,Y1,Z1]=sphere;
X=Z1.*r;
Y=Y1.*r;
Z=X1.*r+90;
nd=size(Z,1);md=(nd+1)/2;
X(1:md-1,:)=X(1:md-1,:)+offset1;
X(md:nd,:)=X(md:nd,:)+offset2;
i=7;
boundary{i}.X=X;boundary{i}.Y=Y;boundary{i}.Z=Z;
for k=1:nd
for j=1:nd
    newvec=[X(k,j),Y(k,j),Z(k,j)]*M{i}(1:3,1:3)'+M{i}(1:3,4)'.*1000;
    X(k,j)=newvec(1);
    Y(k,j)=newvec(2);
    Z(k,j)=newvec(3);
end
end
boundary{i}.handle=surf(X,Y,Z);
alpha(boundary{i}.handle,valpha);

%%
[X,Y,Z]=cylinder(0.26);
X(3,:)=X(2,end:-1:1);
Y(3,:)=Y(2,end:-1:1);
Z(3,:)=Z(2,:);
surf(X,Y,Z.*0.125,'FaceColor','g');

%%
zlim=2000;
xlim=[-400,2000];
ylim=[-400,500];
view([1,-0.5,0.4])
axis equal
axis([xlim,ylim,0,zlim])
lighting=camlight('left')
%lighting phong
set(gca,'Color',[0.8 0.8 0.8]);
%set(gcf,'Renderer','zbuffer');

wall{1}.handle=fill3([xlim(1),xlim(1),xlim(2),xlim(2)],[ylim(1),ylim(2),ylim(2),ylim(1)],[0,0,0,0],[0.1,0.1,0.1]);
wall{2}.handle=fill3([xlim(1),xlim(1),xlim(1),xlim(1)],[ylim(1),ylim(1),ylim(2),ylim(2)],[0,zlim,zlim,0],[0,0.9,0.9])
wall{3}.handle=fill3([xlim(1),xlim(1),xlim(2),xlim(2)],[ylim(2),ylim(2),ylim(2),ylim(2)],[0,zlim,zlim,0],[0,0.9,0.9])


