function J=Jacobi_6DOF(TCP,DH)
w=nan(3,6);
r_0=nan(3,6);
J=nan(6,6);% jacobian
TCP_T=eye(4);
alpha=DH(:,4);
A=DH(:,3);
D=DH(:,2);
q=DH(:,1);
for i=1:6
    w(:,i)=TCP_T(1:3,3);
    r_0(:,i)=TCP_T(1:3,4);
    TCP_T=TCP_T*...
        [cos(q(i)) -sin(q(i))*cos(alpha(i))  sin(q(i))*sin(alpha(i)) A(i)*cos(q(i));...
         sin(q(i))  cos(q(i))*cos(alpha(i)) -cos(q(i))*sin(alpha(i)) A(i)*sin(q(i));...
          0            sin(alpha(i))                cos(alpha(i))            D(i);...
          0                0                       0               1];
end
% TCP_T=TCP_T*... % up to now, forward kinematics, S0 to S6
%     [R_tool,p_tool;0 0 0 1]; % S6 to tool
    
%TCP=orig_abs;% TCP point in the world frame

for i=1:6
    J(:,i)=[cross(r_0(:,i)-TCP,w(:,i));w(:,i)];
end
end
