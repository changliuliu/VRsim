if MODE == 'MOUSES'
    set(fighandle(1),'currentaxes',fighandle(2))
end
% robot.handle=zeros(1,6);
% for i=1:6
%     robot.handle(i)=plot3(robot.pos{1,i}.p(1,:),robot.pos{1,i}.p(2,:),robot.pos{1,i}.p(3,:),'.-','LineWidth',10,'markersize',50);
%     set(robot.handle(i),'XDataSource','robot.pos{t,i}.p(1,:)');
%     set(robot.handle(i),'YDataSource','robot.pos{t,i}.p(2,:)');
%     set(robot.handle(i),'ZDataSource','robot.pos{t,i}.p(3,:)');
% end

HuCap=HumanCap();
xref=HuCap{1}.p(1,1); yref=HuCap{1}.p(2,1);
for i=1:10
    HuCap{i}.p=HuCap{i}.p-[xref xref;yref yref;0 0]+[init_pos(1) init_pos(1);init_pos(2) init_pos(2);0 0];
end

Hhandle=[];
for i=1:10
    if i==1
        Hhandle(i)=plot3(HuCap{i}.p(1,:),HuCap{i}.p(2,:),HuCap{i}.p(3,:),'.-','LineWidth',10,'markersize',100);
    else
        Hhandle(i)=plot3(HuCap{i}.p(1,:),HuCap{i}.p(2,:),HuCap{i}.p(3,:),'.-','LineWidth',10,'markersize',50);
    end
    set(Hhandle(i),'XDataSource','HuCap{i}.p(1,:)');
    set(Hhandle(i),'YDataSource','HuCap{i}.p(2,:)');
    set(Hhandle(i),'ZDataSource','HuCap{i}.p(3,:)');
end