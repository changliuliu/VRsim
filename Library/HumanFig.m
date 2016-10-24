
agent.fig={};

i=1;
agent.fig{i}.name='head';
agent.fig{i}.handle=plot3(agent.x(1,end),agent.x(2,end),agent.x(3,end),'.','markersize',100);
set(agent.fig{i}.handle,'XDataSource','agent.x(1,end)');
set(agent.fig{i}.handle,'YDataSource','agent.x(2,end)');
set(agent.fig{i}.handle,'ZDataSource','agent.x(3,end)');

i=2;
agent.fig{i}.name='trunk';
list=[10,20,40,10,60,80,10];
agent.fig{i}.list=list;
agent.fig{i}.handle=plot3(agent.x(list+1,end),agent.x(list+2,end),agent.x(list+3,end),'linewidth',10,'color','k','markersize',50);
set(agent.fig{i}.handle,'XDataSource','agent.x(agent.fig{2}.list+1,end)');
set(agent.fig{i}.handle,'YDataSource','agent.x(agent.fig{2}.list+2,end)');
set(agent.fig{i}.handle,'ZDataSource','agent.x(agent.fig{2}.list+3,end)');

i=3;
agent.fig{i}.name='arms';
list=[100,30,20,40,50,110];
agent.fig{i}.list=list;
agent.fig{i}.handle=plot3(agent.x(list+1,end),agent.x(list+2,end),agent.x(list+3,end),'linewidth',10,'color','k','markersize',50);
set(agent.fig{i}.handle,'XDataSource','agent.x(agent.fig{3}.list+1,end)');
set(agent.fig{i}.handle,'YDataSource','agent.x(agent.fig{3}.list+2,end)');
set(agent.fig{i}.handle,'ZDataSource','agent.x(agent.fig{3}.list+3,end)');

i=4;
agent.fig{i}.name='legs';
list=[120,70,60,80,90,130];
agent.fig{i}.list=list;
agent.fig{i}.handle=plot3(agent.x(list+1,end),agent.x(list+2,end),agent.x(list+3,end),'linewidth',10,'color','k','markersize',50);
set(agent.fig{i}.handle,'XDataSource','agent.x(agent.fig{4}.list+1,end)');
set(agent.fig{i}.handle,'YDataSource','agent.x(agent.fig{4}.list+2,end)');
set(agent.fig{i}.handle,'ZDataSource','agent.x(agent.fig{4}.list+3,end)');

