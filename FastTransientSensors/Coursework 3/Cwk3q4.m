% Fast Transient Sensors - Coursework 3
% Devon Kerai (B128203)
% Due 19th May 2015

% Question 4
% Pre requisites
clc
clear
close all

% Variables
u0 = 4*pi*10^-7; % Free space permeability
e0 = 8.85*10^-12; % Free space permittivity
C = 100*10^-6;
width = 40*10^-2;
V0 = 30*10^3;
L = 50*10^-9;
diameterCircTunnel = 15*10^-3;
radiusCircTunnel = diameterCircTunnel/2;
probeDiameter = 3*10^-3;
probeRad = probeDiameter/2;
maxVolt = 200;

%% Part 1
Q = 0;
differentialI = (V0-(Q/C))/L; % 6*10^11

%% Part 2
I = 1;
r = 0;

area = pi*(radiusCircTunnel^2); % 1.7671*10^-4
x = r./radiusCircTunnel;
y = radiusCircTunnel./width;
z = 0;
zzed=(z./(width./2));

Bza = ((u0.*I)/(4.*pi.*width));
Bfun= @(phi) ((1-(x.*cos(phi)))./(1+(x.^2)-(2.*x.*cos(phi)))).*(((1-zzed)./sqrt(((y.^2)...
    .*(1+(x.^2))-(2.*x.*cos(phi)))+(((1-zzed).^2)./4)))+((1+zzed)./sqrt(((y.^2)...
    .*(1+(x.^2)-(2.*x.*cos(phi))))+(((1-zzed).^2)./4))));
q=integral(Bfun,0,pi);
Bz=Bza*q;

k = Bz/I;
diffflux = k*differentialI;

%% Part 3
coilArea = pi*(probeRad^2);
EMF = 200;

N = EMF./(coilArea*diffflux);

%% Part 4

coilLength = 20*10^-2;
k = coilLength/(coilLength+(0.9*probeRad));
inductCoil = ((u0.*pi.*(N^2).*(probeRad^2))./coilLength).*k;

resistivity = 1.68*10^-8;  % Resistivity of copper wire
probeArea = pi*(probeRad^2);

freq = 1/(2*pi*sqrt(L*C));
wireDiameter = sqrt(resistivity./(freq.*pi.*u0));
wireRad = wireDiameter;
wireArea = pi*(wireRad^2);
pitch = coilLength/N;
wireLength = (coilLength/pitch)*sqrt(((2*pi*probeRad)^2)+(pitch^2));
resistCoil = (resistivity*wireLength)/wireArea;

Rt = 50;
resistTotal = resistCoil+Rt;
xL = (2*pi*freq)*inductCoil;

% xL << resistTotal therefore proves it's a differentiating probe.

%% Part 5

% Look at Cap Bank notes - the last few pages and write a few sentences


%% Part 6

% Write on paper and add to appendix


%% Part 7
CapCircLoops = (2*(pi^2)*e0*probeRad)/log((pitch/(2*wireRad))+sqrt(((pitch/(2*wireRad))^2)-1));
Cp = ((1/CapCircLoops)*(N-1))^-1;
Emf = 1;
Eqn = [((inductCoil*Cp)) (((inductCoil/Rt)+(resistCoil*Cp))) (1+(resistCoil/Rt))];

Vout = tf(Emf,Eqn);
[volt, time] = step(Vout);

% Graph to show output voltage
% figure
% plot(time*10^9,volt,'Linewidth',2)
% grid on
% title('Output Voltage')
% xlabel('Time (ns)')
% ylabel('Voltage (V)')

