addpath('/Users/changliuliu/Matlab/stlread');
prefix='/Users/changliuliu/Matlab/M16iB 3D game/Data/human-worker/';
filename=strcat(prefix,'Human_Worker.stl');
[v, f, n, c, stltitle]=stlread(filename);
Worker.v=v;Worker.f=f;Worker.c=c;Worker.color='b';
save('Data/Worker-figure.mat','Worker');

