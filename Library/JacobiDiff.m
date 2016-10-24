%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the Jacobi matrix (J) and its derivative (H) of
% a given point p (in the base coordinate) on the link n.
%
% Changliu Liu
% 2015.8.5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [J,H]=JacobiDiff(DH,n,p,qdot)
z=nan(3,n); %z(:,i) is the z axis of link i in the base coordinate
r_0=nan(3,n+1); %r_0(:,i) is the coordinate of the i-th origin
w=nan(3,n); % angular velocity of z
J=nan(6,n); % Jacobian
H=nan(3,n); % Diff(J)
TCP_T=eye(4);

JointJacobi={};
vj=nan(3,n);

for i=1:n
    JointJacobi{i}=nan(3,i);
end

alpha=DH(:,4);A=DH(:,3);D=DH(:,2);q=DH(:,1);

for i=1:n
    z(:,i)=TCP_T(1:3,3);
    r_0(:,i)=TCP_T(1:3,4);
    if i>1
        w(:,i)=w(:,i-1)+z(:,i).*qdot(i);
    else
        w(:,i)=z(:,i).*qdot(i);
    end
    TCP_T=TCP_T*...
        [cos(q(i)) -sin(q(i))*cos(alpha(i))  sin(q(i))*sin(alpha(i)) A(i)*cos(q(i));...
         sin(q(i))  cos(q(i))*cos(alpha(i)) -cos(q(i))*sin(alpha(i)) A(i)*sin(q(i));...
          0            sin(alpha(i))                cos(alpha(i))            D(i);...
          0                0                       0               1];
end
r_0(:,n+1)=TCP_T(1:3,4);
% TCP_T=TCP_T*... % up to now, forward kinematics, S0 to S6
%     [R_tool,p_tool;0 0 0 1]; % S6 to tool
    
for i=1:n
    J(:,i)=[cross(r_0(:,i)-p,z(:,i));z(:,i)];
    for j=i:n
        JointJacobi{j}(:,i)=cross(r_0(:,i)-r_0(:,j+1),z(:,i));
    end
end
vp=J(1:3,:)*qdot;
vj(:,1)=[0;0;0];
for i=1:n-1
    vj(:,1+i)=JointJacobi{i}*qdot(1:i);
end

for i=1:n
    H(:,i)=cross(r_0(:,i)-p,cross(w(:,i),z(:,i)))+cross(vj(:,i)-vp,z(:,i));
end
end
