%FTS Question 4%
clear all
close all
clc
V0=30e3;
L=50e-9;
C=100e-6;
R=0;
uo=(4*pi*10^-7);
Eo=8.85e-12;
a=7.5e-3;
l=40e-2;
r=1.5e-3;
z=1/2;

y0(1)=0;
y0(2)=0;
tspan=[0:1e-9:200e-6];
[t,cur,]=ode45('Currentchange',tspan,y0);
plot(t,cur(:,1))
grid on
I=1%(cur(:,1));
Im=max(I);
didt=V0/L;
%% ii)
Preintergral=((uo*Im)/(4*pi*(40e-2)));
y=a/l;
x=(r/a);
zdash=(z/(l/2));
Bfun= @(W) ((1-(x.*cos(W)))./(1+(x.^2)-(2.*x.*cos(W)))).*(((1-zdash)./sqrt(((y.^2).*(1+(x.^2))-(2.*x.*cos(W)))+(((1-zdash).^2)./4)))+((1+zdash)./sqrt(((y.^2).*(1+(x.^2)-(2.*x.*cos(W))))+(((1-zdash).^2)./4))))
q=integral(Bfun,0,pi)
Bz=q*Preintergral

dbdt=Bz*didt; %Change of B with time

Area=(pi*r*r); %CSA of the coil
N=200/(dbdt*Area); %Number of turns
[PKS,LOCS]=findpeaks(cur(:,1)); %Finding the frequency
Freq=1/((LOCS(2)-LOCS(1))*1e-9); %Calculating the frequency
coillength=(r*5); %Choosing coil length
coilL=((uo*pi*(N^2)*(r^2))/coillength)*(coillength/(coillength+(0.9*r)));%Self Inductance of the coil
Pitch=coillength/N; %\Pitch of the coil
HelicalPath=((coillength)/Pitch)*sqrt(((2*pi*r)^2)+Pitch^2); %Length of wire in the coil
rho=133*(1e-6)*(1e-2); %Resistivity of EvanOhm Alloy R
coilR=(rho*HelicalPath)/0.7874e-3 %Resistance of the coil