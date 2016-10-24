function x=HumanConfUpdate(base)
agent.shoulderlength=0.45;
agent.pelvislength=0.32;
x(1:3,1)=base+[0;0;1.6]; %1:head
x(11:13,1)=base+[0;0;1.2]; %2:trunk
x(21:23,1)=base+[0;agent.shoulderlength/2;1.4]; %3:right boom
x(31:33,1)=x(21:23,1)+[0;0;-0.3]; %4:right forearm
x(41:43,1)=base+[0;-agent.shoulderlength/2;1.4]; %5:left boom
x(51:53,1)=x(41:43,1)+[0;0;-0.3]; %6:left forearm
x(61:63,1)=base+[0;agent.pelvislength/2;0.8]; %7:right thigh
x(71:73,1)=x(61:63,1)+[0;0;-0.3]; %8:right calf
x(81:83,1)=base+[0;-agent.pelvislength/2;0.8]; %9:left thigh
x(91:93,1)=x(81:83,1)+[0;0;-0.3]; %10:left calf
x(101:103,1)=x(31:33,1)+[0;0;-0.4]; %right wrist
x(111:113,1)=x(51:53,1)+[0;0;-0.4]; %left wrist
x(121:123,1)=x(71:73,1)+[0;0;-0.5]; %right ancle
x(131:133,1)=x(91:93,1)+[0;0;-0.5]; %left ancle
end
