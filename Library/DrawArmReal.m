function DrawArmReal(base,link,payload,M)
%% Base
for i=1:2
    f=base{i}.f; v=base{i}.v./1000; c=base{i}.c; color=base{i}.color;
    patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
end

%% links

for i=1:6
    v=link{i}.v./1000; f=link{i}.f; c=link{i}.c; color=link{i}.color;
    for j=1:size(v,1)
        v(j,:)=v(j,:)*M{i+1}(1:3,1:3)'+M{i+1}(1:3,4)';
    end
    patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
    if i==1 || i==3
        for k=1:4
            v=link{i}.motor{k}.v./1000; f=link{i}.motor{k}.f; c=link{i}.motor{k}.c; color=link{i}.motor{k}.color;
            for j=1:size(v,1)
                v(j,:)=v(j,:)*M{i+1}(1:3,1:3)'+M{i+1}(1:3,4)';
            end
            patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
        end
    end
    
end

%% Payload
i=6;
v=payload.v./1000;f=payload.f;c=payload.c;color=payload.color;
for j=1:size(v,1)
    v(j,:)=v(j,:)*M{i+1}(1:3,1:3)'+M{i+1}(1:3,4)';
end
patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
end
