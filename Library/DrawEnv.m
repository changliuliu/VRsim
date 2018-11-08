load('figure/environment.mat');
offsetT = -[3250, 8500,0]';
offsetM = [eye(3), offsetT; zeros(1,4)];
envir.v = setVertice(envir.v,offsetM);
patch('Faces',envir.f,'Vertices',envir.v./1000,'FaceVertexCData',envir.c,'FaceColor',envir.color,'EdgeColor','None');