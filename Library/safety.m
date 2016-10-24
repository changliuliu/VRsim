function [thres,vet]=safety(D,BJ)
P1=eye(6);P1(4,4)=0;P1(5,5)=0;P1(6,6)=0;
P2=[zeros(3) 0.5*eye(3);0.5*eye(3) zeros(3)];
margin=0.8;
dnext=sqrt(D'*P1*D);
thres=margin*dnext-dnext^3-D'*P2*D;
vet=2*D'*P2*BJ;
end