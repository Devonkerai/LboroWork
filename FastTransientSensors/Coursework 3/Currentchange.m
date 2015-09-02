function [Current] =Currentchange(t,y)
V0=30e3;
L=50e-9;
C=100e-6;
R=0;

% V0=25e-3;
% C=20e-6;
% L=30e-9;
% R=7e-3;

Current(1,1)=(V0-(y(2)/C)-(R*y(1)))/L;
Current(2,1)=y(1);


end

