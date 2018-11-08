function handle = DrawRobotCAD(robotCAD, M)

%% base
for i=1:numel(robotCAD.base)
    f=robotCAD.base{i}.f; v=robotCAD.base{i}.v./1000; c=robotCAD.base{i}.c; color=robotCAD.base{i}.color;
    handle.base(i) = patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
end

%% Link
for i=1:6
    v=robotCAD.link{i}.v./1000; f=robotCAD.link{i}.f; c=robotCAD.link{i}.c; color=robotCAD.link{i}.color;
    v = setVertice(v,M{i+1});
    handle.link(i) = patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
    if i==1 || i==3
        for k=1:4
            v=robotCAD.link{i}.motor{k}.v./1000; f=robotCAD.link{i}.motor{k}.f; c=robotCAD.link{i}.motor{k}.c; color=robotCAD.link{i}.motor{k}.color;
            v = setVertice(v,M{i+1});
            handle.motor(i,k) = patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
        end
    end    
end

%% Payload
i = 7;
v=robotCAD.payload.v./1000;f=robotCAD.payload.f;c=robotCAD.payload.c;color=robotCAD.payload.color;
v = setVertice(v,M{i});
handle.payload(1) = patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
end