addpath('/Users/changliuliu/Matlab/stlread');
prefix='/Users/changliuliu/Matlab/M16iB-Simulator/CAD_model/';
base={};
filename=strcat(prefix,'base_yellow.stl');
[v, f, n, c, stltitle]=stlread(filename);
base{1}.v=v;base{1}.f=f;base{1}.c=c;base{1}.color='y';

filename=strcat(prefix,'base_black.stl');
[v, f, n, c, stltitle]=stlread(filename);
base{2}.v=v;base{2}.f=f;base{2}.c=c;base{2}.color='k';

link={};
for i=1:5
filename=strcat(prefix,'link',num2str(i),'_yellow.stl')
[v, f, n, c, stltitle]=stlread(filename);
link{i}.v=v;link{i}.f=f;link{i}.c=c;link{i}.color='y';
end

i=6;
filename=strcat(prefix,'link',num2str(i),'_black.stl')
[v, f, n, c, stltitle]=stlread(filename);
link{i}.v=v;link{i}.f=f;link{i}.c=c;link{i}.color='k';

filename=strcat(prefix,'payload.stl')
[v, f, n, c, stltitle]=stlread(filename);
payload.v=v;payload.f=f;payload.c=c;payload.color='k';
%%
i=1;j=1;link{i}.motor={};
filename=strcat(prefix,'link1_motor1_black.stl')
[v, f, n, c, stltitle]=stlread(filename);
link{i}.motor{j}.v=v;link{i}.motor{j}.f=f;link{i}.motor{j}.c=c;link{i}.motor{j}.color='k';

i=1;j=2;
filename=strcat(prefix,'link1_motor1_red.stl')
[v, f, n, c, stltitle]=stlread(filename);
link{i}.motor{j}.v=v;link{i}.motor{j}.f=f;link{i}.motor{j}.c=c;link{i}.motor{j}.color='r';

i=1;j=3;
filename=strcat(prefix,'link1_motor2_black.stl')
[v, f, n, c, stltitle]=stlread(filename);
link{i}.motor{j}.v=v;link{i}.motor{j}.f=f;link{i}.motor{j}.c=c;link{i}.motor{j}.color='k';

i=1;j=4;
filename=strcat(prefix,'link1_motor2_red.stl')
[v, f, n, c, stltitle]=stlread(filename);
link{i}.motor{j}.v=v;link{i}.motor{j}.f=f;link{i}.motor{j}.c=c;link{i}.motor{j}.color='r';

i=3;j=1;link{i}.motor={};
filename=strcat(prefix,'link3_motor3_black.stl')
[v, f, n, c, stltitle]=stlread(filename);
link{i}.motor{j}.v=v;link{i}.motor{j}.f=f;link{i}.motor{j}.c=c;link{i}.motor{j}.color='k';

i=3;j=2;
filename=strcat(prefix,'link3_motor3_red.stl')
[v, f, n, c, stltitle]=stlread(filename);
link{i}.motor{j}.v=v;link{i}.motor{j}.f=f;link{i}.motor{j}.c=c;link{i}.motor{j}.color='r';

i=3;j=3;
filename=strcat(prefix,'link3_motor4_black.stl')
[v, f, n, c, stltitle]=stlread(filename);
link{i}.motor{j}.v=v;link{i}.motor{j}.f=f;link{i}.motor{j}.c=c;link{i}.motor{j}.color='k';

i=3;j=4;
filename=strcat(prefix,'link3_motor4_red.stl')
[v, f, n, c, stltitle]=stlread(filename);
link{i}.motor{j}.v=v;link{i}.motor{j}.f=f;link{i}.motor{j}.c=c;link{i}.motor{j}.color='r';

save('Data/M16iB-figure.mat','base','link','payload');