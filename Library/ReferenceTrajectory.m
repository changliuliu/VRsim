% Reference trajectory for Robot
tfinal=1000;
r=0.25;v=25;
for t=1:tfinal
robot.goal(1:3,t)=robot.pos{1,robot.nlink}.p(:,2)+r*[sin(t/v);0;0]%+r/2*[0;0;sin(t/v/2)];
end

for t=1:tfinal-1
    robot.goal(4:6,t)=(robot.goal(1:3,t+1)-robot.goal(1:3,t))./robot.delta_t;
end
for t=1:tfinal-2
    robot.goal(7:9,t)=(robot.goal(4:6,t+1)-robot.goal(4:6,t))./robot.delta_t;
end
plot3(robot.goal(1,:),robot.goal(2,:),robot.goal(3,:),'LineWidth',1);