function [k,r]=closest(h,rangle,robotpos,link)
n=length(robotpos)/2;
theta=0;
record=100;
k=0;
for i=1:n-1
    x=robotpos(i*2-1);
    y=robotpos(i*2);
    theta=theta+rangle(i);
    dmin=abs((x-h(1))*sin(theta)-(y-h(2))*cos(theta));
    if dmin<record
    rx=h(1)-x;
    ry=h(2)-y;
    relangle=abs(dangle(rx,ry)-theta);
    if relangle<=atan(dmin/link(i))
        dmin=sqrt((h(1)-robotpos(i*2+1))^2+(h(2)-robotpos(i*2+2))^2);
        rr=1;
    else
        if relangle>=pi/2
        dmin=sqrt((h(1)-x)^2+(h(2)-y)^2);
        rr=0;
        else
            rr=dmin/tan(relangle)/link(i);
        end
    
    end
    if dmin<record
        record=dmin;
        k=i;
        r=rr;
    end     
end
end