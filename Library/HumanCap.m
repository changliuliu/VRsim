function HuCap=HumanCap()
HM=cell(1,10);
for i=1:10
    HM{i}=eye(4);
end

HuCap={};
HuCap{1}.p=[0 0;0 0;1.5 1.5];
HuCap{1}.r=0.3;

HuCap{2}.p=[0 0;0 0;0.8 1.15];
HuCap{2}.r=0.22;

t=[0;0;pi-0.3;pi-0.3;pi+0.3;pi+0.3;pi-0.2;pi-0.2;pi+0.2;pi+0.2];
for i=3:2:5
HuCap{i}.r=0.07;
HuCap{i}.p=[0 0;0 0;0 0.25];
theta=t(i);
R=[1 0 0; 0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
T=[0;(i-4)*0.2;1.200];
HM{i}=[R T;0 0 0 1];
HuCap{i}.p=R*HuCap{i}.p+[T T];
end
%%
for i=4:2:6
HuCap{i}.r=0.07;
HuCap{i}.p=[0 0;0 0;0 0.23];
theta=t(i);
R=[1 0 0; 0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
T=[0;(i-5)*0.3;0.88];
HM{i}=[R T;0 0 0 1];
HuCap{i}.p=R*HuCap{i}.p+[T T];
end

for i=7:2:9
HuCap{i}.r=0.1;
HuCap{i}.p=[0 0;0 0;0 0.3];
theta=t(i);
R=[1 0 0; 0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
T=[0;(i-8)*0.08;0.65];
HM{i}=[R T;0 0 0 1];
HuCap{i}.p=R*HuCap{i}.p+[T T];
end

for i=8:2:10
HuCap{i}.r=0.08;
HuCap{i}.p=[0 0;0 0;0 0.27];
theta=t(i);
R=[1 0 0; 0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
T=[0;(i-9)*0.16;0.3];
HM{i}=[R T;0 0 0 1];
HuCap{i}.p=R*HuCap{i}.p+[T T];
end
end

