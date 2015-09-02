% Fast Transient Sensors - Coursework 3
% Devon Kerai (B128203)
% Due 19th May 2015

% Question 1
% Pre requisites
clc
clear
close all

% Variables
u0 = 4*pi*10^-7; % Free space permeability
e0 = 8.85*10^-12; % Free space permittivity
stages = 20;
capStage = 40*10^-9;
V0 = 25*10^3;
resisStage = 10*10^-3; % Marx generator total resistance of each stage during a discharge
resisLoad = 10*10^3; % Resistance when coupled to a load
capLoad = 250*10^-9; % Capacitance when coupled to a load

%% Part 1
t=0:1*10^-10:1*10^-6;
voltMax = V0.*stages;
resisTotal = resisStage.*stages;
capTotal = capStage./stages;
beta1 = 1./(resisTotal.*capLoad);
beta2 = 1./(resisLoad.*capTotal);
voltLoad=(voltMax/((beta1-beta2)*resisTotal*capLoad))*(exp(-beta2*(t))-exp(-beta1*(t)));

% Voltage impulse info
rTime = risetime(voltLoad)./10^10;
vPeak = max(voltLoad);
fBand = 0.35./rTime;

% Voltage sensor info
voltSensorrTime = rTime/5;
voltSensorfBand = 0.35./voltSensorrTime;

% Graph for Marx generator
% figure
% plot(t.*10^6,voltLoad./10^3,'Linewidth',2)
% grid on
% title('Marx Generator Output Voltage')
% xlabel('Time (\mus)') 
% ylabel('Voltage (kV)')

%% Part 2
Zc = 50; % Ohms
Z1 = Zc;
Z2 = Zc;
Z = Zc/2;
Tlv = 0;

%% Part 3
Zhighvoltage = (((vPeak)/80)*Zc)-Zc;

%% Part 4
wireResistivity = 138*10^-8; % Ohm/cm
wireSHC = 435; % J/kg/K
wireDensity = 8100; % kg/m^3

colHeight = (vPeak/(5*10^3))*10^-2;
wireRad = 16*10^-6;
wireArea = (wireRad^2)*pi;
wireLength = (wireArea*Zhighvoltage)/wireResistivity;
mandrelRad = 7*10^-2;
wireLengthTotal = wireLength*4;
N = (wireLengthTotal/2)./(2.*pi.*mandrelRad);

% Temperature
tmax = 190*10^-6;
E = (tmax*(vPeak^2))/(2*Zhighvoltage);
wireVol = wireArea*wireLengthTotal;
wireMass = wireVol*wireDensity;
temp = E/(wireSHC.*wireMass);

%% Part 5
% See Maxwell Pics
CHVFinal = 13*10^-12;

%% Part 6
cableLen = 1;

d = sqrt(colHeight^2+cableLen^2);
l = 2*(colHeight+cableLen);
firstbit = u0/pi;
secondbit = colHeight*(log((2*colHeight*cableLen)/(wireRad*(colHeight+d))));
thirdbit = cableLen*(log((2*colHeight*cableLen)/(wireRad*(cableLen+d))));
fourthbit = (2*d)-(l*(7/8));
Lrect = firstbit*(secondbit+thirdbit+fourthbit);

Lwire1 = (u0*cableLen)/(2*pi);
Lwire2 = log(((2*cableLen)/wireRad))-(3/4);
LwireFinal = Lwire1*Lwire2;
Ltotal = LwireFinal/4;

% Write a statement saying that Ltotal is less than Lrect.

%% Part 7
% dampingRes = 1.2*sqrt(Ltotal/CHVFinal);
% TransferFunction = 1/((Ltotal*CHVFinal*(P^2))+(dampingRes*CHVFinal*P)+1);
% ResponseTime = dampingRest*CHVFinal;

%% Part 8
rcrit = 2*sqrt(Ltotal/CHVFinal);
dampingcritresist = 0.591*rcrit;
ResponseOptimumTime = dampingcritresist*CHVFinal;
dampingRes = 1.2*sqrt(Ltotal/CHVFinal);
ResponseTime = dampingRes*CHVFinal; % Using rd from notes

% ResponseTime (High Voltage Arm) = 3.16*10^-9
% voltSensorrTime = 1.9687*10^-8 (from part i)
% ResponseTime (Whole Divider) = 3.2067*10^-9 (from part viii)

% The rise time from part viii is faster than the rise time from part i.

%% Part 9
% Show on paper.

%% Part 10
% Use pic on phone and highlight the 3rd row - the really complex one.

% Using this combination would improve the response time of the divider
% because it was cause the rise time for the low voltage arm to be
% negative, reducing the response time of the entire system.

