%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the CriticlePoints on the Capsules
%
% [dmin,p1,link1,p2,link2]=CriticlePoints(RoCap,HuCap);
%
% RoCap is a list of robot capsules
%   RoCap{i}.p is the starting and ending points on capsule i;
%   RoCap{i}.r is the radius of the capsule i;
% HuCap is a list of human capsules
% 
% Output: 
%   Minimum distance: dmin
%   Criticle point on the robot: p1 (on link1)
%   Criticle point on the human: p2 (on link2)
%   
%
% Changliu Liu
% 2015.8.5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function [dmin,p1,link1,p2,link2]=CriticlePoints(RoCap,HuCap)
nr=length(RoCap);
nh=length(HuCap);
dmin=100;

for i=1:nr
    for j=1:nh
        [d,~,point1,point2]=DistBetween2Segment(RoCap{i}.p(:,1),RoCap{i}.p(:,2),HuCap{j}.p(:,1),HuCap{j}.p(:,2));
        d=d-RoCap{i}.r-HuCap{j}.r;
        if d<dmin
            dmin=d;
            p1=point1;
            p2=point2;
            link1=i;
            link2=j;
        end
    end
end
end

