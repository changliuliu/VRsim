function DrawWorker(Worker)
v=Worker.v;f=Worker.f;c=Worker.c;color=Worker.color;
v=v.*9./1000;
R=[0 1 0;-1 0 0; 0 0 1]*[1  0 0; 0 0 -1;0 1 0];
for j=1:size(v,1)
    v(j,:)=v(j,:)*R';
end
T=[0;0;-min(v(:,3))]+humanoff(:,t);
for j=1:size(v,1)
    v(j,:)=v(j,:)+T';
end
Worker.hanle=patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
valpha=0.2;
end