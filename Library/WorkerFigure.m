load('Data/Worker-figure.mat');
figure(1); hold on
v=Worker.v;f=Worker.f;c=Worker.c;color=Worker.color;
v=v.*9;
R=[0 1 0;-1 0 0; 0 0 1]*[1  0 0; 0 0 -1;0 1 0];
for j=1:size(v,1)
    v(j,:)=v(j,:)*R';
end
T=[1600;0;-min(v(:,3))];
for j=1:size(v,1)
    v(j,:)=v(j,:)+T';
end
Worker.hanle=patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',[0.8,0.8,0.8],'EdgeColor','None');
valpha=0.2;

%% head
r=300;T=[1600;0;1500];
[X,Y,Z]=sphere;
X=X.*r+T(1);
Y=Y.*r+T(2);
Z=Z.*r+T(3);
i=1;
body{i}.X=X;body{i}.Y=Y;body{i}.Z=Z;
body{i}.handle=surf(X,Y,Z,'FaceColor',[0,0.8,0.8],'EdgeColor','None');
alpha(body{i}.handle,valpha);
%% trunk
r=220;offset1=800;offset2=1150;
[X,Y,Z]=sphere;
X=X.*r+1600;
Y=Y.*r;
Z=Z.*r;
nd=size(Z,1);md=(nd+1)/2;
Z(1:md-1,:)=Z(1:md-1,:)+offset1;
Z(md:nd,:)=Z(md:nd,:)+offset2;
i=2;
body{i}.X=X;body{i}.Y=Y;body{i}.Z=Z;
body{i}.handle=surf(X,Y,Z,'FaceColor',[0,0.8,0.8],'EdgeColor','None');
alpha(body{i}.handle,valpha);

%% arm-right-3
r=70;offset1=0;offset2=250;
[X,Y,Z]=sphere;
X=X.*r;
Y=Y.*r;
Z=Z.*r;
nd=size(Z,1);md=(nd+1)/2;
Z(1:md-1,:)=Z(1:md-1,:)+offset1;
Z(md:nd,:)=Z(md:nd,:)+offset2;
i=3;
body{i}.X=X;body{i}.Y=Y;body{i}.Z=Z;
theta=pi-0.3;
R=[1 0 0; 0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
T=[1600;-200;1200];
for k=1:nd
for j=1:nd
    newvec=[X(k,j),Y(k,j),Z(k,j)]*R'+T';
    X(k,j)=newvec(1);
    Y(k,j)=newvec(2);
    Z(k,j)=newvec(3);
end
end
body{i}.handle=surf(X,Y,Z,'FaceColor',[0,0.8,0.8],'EdgeColor','None');
alpha(body{i}.handle,valpha);
%% arm-right-4
r=70;offset1=0;offset2=230;
[X,Y,Z]=sphere;
X=X.*r;
Y=Y.*r;
Z=Z.*r;
nd=size(Z,1);md=(nd+1)/2;
Z(1:md-1,:)=Z(1:md-1,:)+offset1;
Z(md:nd,:)=Z(md:nd,:)+offset2;
i=4;
body{i}.X=X;body{i}.Y=Y;body{i}.Z=Z;
theta=pi-0.3;
R=[1 0 0; 0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
T=[1600;-300;880];
for k=1:nd
for j=1:nd
    newvec=[X(k,j),Y(k,j),Z(k,j)]*R'+T';
    X(k,j)=newvec(1);
    Y(k,j)=newvec(2);
    Z(k,j)=newvec(3);
end
end
body{i}.handle=surf(X,Y,Z,'FaceColor',[0,0.8,0.8],'EdgeColor','None');
alpha(body{i}.handle,valpha);
%% arm-left-5
r=70;offset1=0;offset2=250;
[X,Y,Z]=sphere;
X=X.*r;
Y=Y.*r;
Z=Z.*r;
nd=size(Z,1);md=(nd+1)/2;
Z(1:md-1,:)=Z(1:md-1,:)+offset1;
Z(md:nd,:)=Z(md:nd,:)+offset2;
i=5;
body{i}.X=X;body{i}.Y=Y;body{i}.Z=Z;
theta=pi+0.3;
R=[1 0 0; 0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
T=[1600;200;1200];
for k=1:nd
for j=1:nd
    newvec=[X(k,j),Y(k,j),Z(k,j)]*R'+T';
    X(k,j)=newvec(1);
    Y(k,j)=newvec(2);
    Z(k,j)=newvec(3);
end
end
body{i}.handle=surf(X,Y,Z,'FaceColor',[0,0.8,0.8],'EdgeColor','None');
alpha(body{i}.handle,valpha);
%% arm-left-6
r=70;offset1=0;offset2=230;
[X,Y,Z]=sphere;
X=X.*r;
Y=Y.*r;
Z=Z.*r;
nd=size(Z,1);md=(nd+1)/2;
Z(1:md-1,:)=Z(1:md-1,:)+offset1;
Z(md:nd,:)=Z(md:nd,:)+offset2;
i=6;
body{i}.X=X;body{i}.Y=Y;body{i}.Z=Z;
theta=pi+0.3;
R=[1 0 0; 0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
T=[1600;300;880];
for k=1:nd
for j=1:nd
    newvec=[X(k,j),Y(k,j),Z(k,j)]*R'+T';
    X(k,j)=newvec(1);
    Y(k,j)=newvec(2);
    Z(k,j)=newvec(3);
end
end
body{i}.handle=surf(X,Y,Z,'FaceColor',[0,0.8,0.8],'EdgeColor','None');
alpha(body{i}.handle,valpha);

%% leg-right-7
r=110;offset1=0;offset2=300;
[X,Y,Z]=sphere;
X=X.*r;
Y=Y.*r;
Z=Z.*r;
nd=size(Z,1);md=(nd+1)/2;
Z(1:md-1,:)=Z(1:md-1,:)+offset1;
Z(md:nd,:)=Z(md:nd,:)+offset2;
i=7;
body{i}.X=X;body{i}.Y=Y;body{i}.Z=Z;
theta=pi-0.2;
R=[1 0 0; 0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
T=[1600;-80;650];
for k=1:nd
for j=1:nd
    newvec=[X(k,j),Y(k,j),Z(k,j)]*R'+T';
    X(k,j)=newvec(1);
    Y(k,j)=newvec(2);
    Z(k,j)=newvec(3);
end
end
body{i}.handle=surf(X,Y,Z,'FaceColor',[0,0.8,0.8],'EdgeColor','None');
alpha(body{i}.handle,valpha);
%% leg-right-8
r=80;offset1=0;offset2=270;
[X,Y,Z]=sphere;
X=X.*r;
Y=Y.*r;
Z=Z.*r;
nd=size(Z,1);md=(nd+1)/2;
Z(1:md-1,:)=Z(1:md-1,:)+offset1;
Z(md:nd,:)=Z(md:nd,:)+offset2;
i=8;
body{i}.X=X;body{i}.Y=Y;body{i}.Z=Z;
theta=pi-0.2;
R=[1 0 0; 0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
T=[1600;-160;300];
for k=1:nd
for j=1:nd
    newvec=[X(k,j),Y(k,j),Z(k,j)]*R'+T';
    X(k,j)=newvec(1);
    Y(k,j)=newvec(2);
    Z(k,j)=newvec(3);
end
end
body{i}.handle=surf(X,Y,Z,'FaceColor',[0,0.8,0.8],'EdgeColor','None');
alpha(body{i}.handle,valpha);
%% leg-left-9
r=110;offset1=0;offset2=300;
[X,Y,Z]=sphere;
X=X.*r;
Y=Y.*r;
Z=Z.*r;
nd=size(Z,1);md=(nd+1)/2;
Z(1:md-1,:)=Z(1:md-1,:)+offset1;
Z(md:nd,:)=Z(md:nd,:)+offset2;
i=9;
body{i}.X=X;body{i}.Y=Y;body{i}.Z=Z;
theta=pi+0.2;
R=[1 0 0; 0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
T=[1600;80;650];
for k=1:nd
for j=1:nd
    newvec=[X(k,j),Y(k,j),Z(k,j)]*R'+T';
    X(k,j)=newvec(1);
    Y(k,j)=newvec(2);
    Z(k,j)=newvec(3);
end
end
body{i}.handle=surf(X,Y,Z,'FaceColor',[0,0.8,0.8],'EdgeColor','None');
alpha(body{i}.handle,valpha);
%% leg-left-10
r=80;offset1=0;offset2=270;
[X,Y,Z]=sphere;
X=X.*r;
Y=Y.*r;
Z=Z.*r;
nd=size(Z,1);md=(nd+1)/2;
Z(1:md-1,:)=Z(1:md-1,:)+offset1;
Z(md:nd,:)=Z(md:nd,:)+offset2;
i=10;
body{i}.X=X;body{i}.Y=Y;body{i}.Z=Z;
theta=pi+0.2;
R=[1 0 0; 0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
T=[1600;160;300];
for k=1:nd
for j=1:nd
    newvec=[X(k,j),Y(k,j),Z(k,j)]*R'+T';
    X(k,j)=newvec(1);
    Y(k,j)=newvec(2);
    Z(k,j)=newvec(3);
end
end
body{i}.handle=surf(X,Y,Z,'FaceColor',[0,0.8,0.8],'EdgeColor','None');
alpha(body{i}.handle,valpha);

%%
view([1,-0.5,0.4])
axis equal
%axis([-300,1300,-200,300,0,zlim])
camlight('left')