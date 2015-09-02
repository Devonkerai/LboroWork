% Fast Transient Sensors - Coursework 2
% Devon Kerai (B128203)
% Due 17th March 2015

% Question 7
% Pre requisites
clc
clear

% Variables
u0 = 4*pi*10^-7; % Free space permeability
e0 = 8.85*10^-12; % Free space permittivity
freq = 10; % 10Hz - frequency
V0 = 170*10^3; % 170kV - peak voltage
t = 3*10^-9; % 3ns - rise time
Rload = 50; % 50Ohms - resistance
Cload = 2.5*10^-9; % 2.5nF - capacitance
Cmax = 20*10^-9; % 20nF - max capacitance
Vmax = 20*10^3; % 20kV - max voltage charge
Ebreak = 7*10^6; % 70kV/cm = 7MV/m - Breakdown electic field
sL = 50*10^-3; % 50mm - stage length
sD = 70*10^-3; % 70mm - stage outer diameter
sR = sD/2;
Rsg = 50*10^-3; % 50mOhms - Spark gap resistance
rsg = 2.5*10^-3; % 2.5mm - Spark gap radius
dsg = 0.5*10^-3; % 0.5mm - Spark gap distance
P0 = 101325; % 1atm - atmospheric pressure
Vbreak1 = 12260*exp((-2.1*10^-3)/rsg);
Vbreak2 = (dsg*10^3)^(0.49-(4*rsg)+(288*(rsg^2)));


% Part 1
outerRad = (V0/Ebreak)+sR; % 0.0593
strayCap = (2*pi*e0*sL)/(log(outerRad/sR)); % 5.2755*10^-12F

% Part 2
P = (Vmax*P0)/(Vbreak1*Vbreak2); % 5.3469*10^5

% Part 3
Csg1 = pi*e0*sqrt((((2*rsg)+dsg)^2)-(4*(rsg^2))); % 6.3705*10^-14F
for j = 0:14
    Csg2(j+1) = coth(((j)+0.5)*(acosh(((2*rsg)+dsg)/(2*rsg))))-1;
end

Csg = Csg1*sum(Csg2); % 2.9959*10^-13 = 0.3pF

% Part 4
LossPerStage = strayCap/(Csg+strayCap); % 0.9463

% Part 5
voltTotal = 0;
VoltPerStage = 0;
stages = 0;
VoltPrevStage = Vmax;

while voltTotal < V0
    VoltPerStage = VoltPrevStage*LossPerStage;
    voltTotal = voltTotal+VoltPerStage;
    VoltPrevStage = VoltPerStage;
    stages = stages+1;
end

stages; % 12 stages

% Part 6
T = 1/freq; % 0.1
feedResistors = T/(5*Cmax); % 1*10^6 = 1MOhm
charge = stages*Cmax*Vmax; % 0.0048
current = charge/T; % 0.048
power = (current^2)*feedResistors; % 2.304*10^3 = 2.3kW

% Part 7
RstTot = Rsg*stages; % 0.6
totalCap = Cmax/stages; % 1.6667*10^-9
B1 = 1/(RstTot*Cload); % 6.6667*10^8
B2 = 1/(Rload*totalCap); % 12*10^6

t=0:10^-10:10^-7;
Vload=(voltTotal/((B1-B2)*RstTot*Cload))*(exp(-B2*(t))-exp(-B1*(t)));
plot(t/10^-9,Vload/1000);
grid on
title('Discharge Load Voltage of a Marx Generator over time');
ylabel('Voltage (kV)');
xlabel('Time (ns)');
peakV = max(Vload);

while peakV < V0
    stages = stages+1;
    VoltPerStage = VoltPrevStage*LossPerStage;
    voltTotal = voltTotal+VoltPerStage;
    VoltPrevStage = VoltPerStage;
    
    RstTot = Rsg*stages;
    totalCap = Cmax/stages;
    B1 = 1/(RstTot*Cload);
    B2 = 1/(Rload*totalCap);
    Vload=(voltTotal/((B1-B2)*RstTot*Cload))*(exp(-B2*(t))-exp(-B1*(t)));
    
    peakV = max(Vload);
    riseTime = risetime(Vload);
    stages; % 14 stages to reach above 170kV (1.7278*10^5)
    
    charge = stages*Cmax*Vmax;
    current = charge/T;
    power = (current^2)*feedResistors; % at 14 stages, power = 3.14kW
end

plot(t/10^-9,Vload/1000);
grid on
title('Discharge Load Voltage of a Marx Generator over time');
ylabel('Voltage (kV)');
xlabel('Time (ns)');

% Calculate rise time
riseTime = risetime(Vload); % 28.794*10^-10 = 2.88ns - Obtained from graph

% Using equation
Lswitch = 32.5*10^-9;
Cpeak = totalCap;
rise1 = 1/(Lswitch*Cpeak);
rise2 = (Rload/(2*Lswitch))^2;
riseTime = abs(2.2/sqrt(rise1-rise2)) % 2.9135*10^-9 = 2.91ns
