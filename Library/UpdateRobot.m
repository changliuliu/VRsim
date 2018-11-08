function handle = UpdateRobot(handle,M,robotCAD)

%% Base
for i = 1:numel(handle.base)
    v = robotCAD.base{i}.v./1000;
    v = setVertice(v, M{1});
    set(handle.base(i), 'Vertices', v)
end

%% Link
for i =1:6
    v = robotCAD.link{i}.v./1000;
    v = setVertice(v, M{i+1});
    set(handle.link(i), 'Vertices', v);
    if i==1 || i==3
        for k=1:4
            v=robotCAD.link{i}.motor{k}.v./1000;
            v = setVertice(v,M{i+1});
            set(handle.motor(i,k),'Vertices',v);
        end
    end
end

%% Payload
i = 7;
v=robotCAD.payload.v./1000;f=robotCAD.payload.f;c=robotCAD.payload.c;color=robotCAD.payload.color;
v = setVertice(v,M{i});
set(handle.payload(1),'Vertices',v);
