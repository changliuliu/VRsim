function [status,robotnew]=robotmove(t,robot)
status=0;
tic;

[J,H]=JacobiDiff(robot.DH,robot.nlink,robot.pos{t,robot.nlink}.p(:,2),robot.x(robot.nlink+1:robot.nlink*2,t));

%desired control
if isfield(robot,'refTraj')
    U=robot.goal(7:9,t)-1*eye(3)*(robot.wx(1:3,t)-robot.goal(1:3,t))-1.5*eye(3)*(robot.wx(4:6,t)-robot.goal(4:6,t));
    robot.u(:,t)=pinv(J)*[U-H*robot.x(robot.nlink+1:robot.nlink*2,t);0;0;0];
else
    robot.u(:,t)=0.5*(mod(robot.goal(:,t)-robot.x(1:robot.nlink,t)+pi,2*pi)-pi)-robot.x(robot.nlink+1:robot.nlink*2,t);
end
robot.profile{t}.optcontltime=toc;

tic;
%safe control
HuCap=robot.obs.HuCap{t,:};
RoCap=cell(1,robot.nlink);
for i=1:robot.nlink
    RoCap{i}=robot.pos{t,i};
    RoCap{i}.r=robot.cap{i}.r;
end
[dmin,p1,link1,p2,link2]=CriticlePoints(RoCap,HuCap);

robot.profile{t}.dmin=dmin;
robot.profile{t}.linkid=link1;
robot.profile{t}.p=p1;
robot.profile{t}.obsid=link2;
robot.profile{t}.dtime=toc;

tic;
[J,H]=JacobiDiff(robot.DH,robot.nlink,p1,robot.x(robot.nlink+1:robot.nlink*2,t));

BJ=robot.Bc*J(1:3,:);
velocity=[];
if t>1
    ref=robot.obs.HuCap{t-1,:};
    dist1=norm(HuCap{link2}.p(:,1)-p2);dist2=norm(HuCap{link2}.p(:,2)-p2);
    if dist1+dist2>0
        vref=(HuCap{link2}.p-ref{link2}.p)./robot.delta_t;
        velocity=(vref(:,1).*dist2+vref(:,2).*dist1)./(dist1+dist2);
    else
        velocity=(HuCap{link2}.p(:,1)-ref{link2}.p(:,1))./robot.delta_t;
    end
else
    velocity=[0;0;0];
end

x_H_predict=[p2+velocity*robot.delta_t;velocity];
D=robot.Ac*robot.wx(:,end)+robot.Bc*H*robot.x(robot.nlink+1:robot.nlink*2,t)-x_H_predict;

[thres,vet]=safety(D,BJ);
robot.profile{t}.ssa=0;
for i=1:1
    
    u=robot.u(1:robot.nlink,t);
    if (vet*u)<thres
        change=thres-vet*u;
        u=u+vet'*(change/norm(vet)^2);
        robot.u(1:robot.nlink,t)=u;
        robot.profile{t}.ssa=1;
    end
    
    if norm(robot.u(:,t))>2
        robot.u(:,t)=robot.u(:,t)/norm(robot.u(:,t))*2;
    end
    
end
robot.profile{t}.ssatime=toc;


% New state and pos
robot.x(1:2*robot.nlink,t+1)=robot.A*robot.x(:,t)+robot.B*robot.u(:,t);
for i=1:robot.nlink
    robot.x(i,t+1)=mod(robot.x(i,t+1)+pi,2*pi)-pi;
    robot.DH(i,1)=robot.x(i,t+1);
end

[newpos,M]=CapPos(robot.base,robot.DH,robot.cap);
for i=1:robot.nlink
    robot.pos{t+1,i}=newpos{i};
end
robot.profile{t+1}.M=M;
robot.wx(1:3,t+1)=robot.pos{t+1,robot.nlink}.p(:,2);
[J,~]=JacobiDiff(robot.DH,robot.nlink,robot.pos{t+1,robot.nlink}.p(:,2),robot.x(robot.nlink+1:end,t+1));

robot.wx(4:6,t+1)=J(1:3,:)*robot.x(robot.nlink+1:2*robot.nlink,t+1);

robotnew=robot;
end