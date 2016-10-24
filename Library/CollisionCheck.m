function status=CollisionCheck(robot,obstacle,range)
status=0;
for i=1:size(robot,2)
[~,~,profile]=closestMultiple(robot{i}.l,robot{i}.pos(:,end),obstacle);
if profile.rmin<range
    status=1;
end
end
end