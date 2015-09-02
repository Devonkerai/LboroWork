% Fast Transient Sensors - Coursework 2
% Devon Kerai (B128203)
% Due 17th March 2015

% Question 6
% Pre requisites
clc
clear

% Variables
u0 = 4*pi*10^-7; % Free space permeability
e0 = 8.85*10^-12; % Free space permittivity
Z0 = 15; % 15Ohms
L = 1.25; % 1.25m - axial length
er = 2.25; % relative permittivity
V0 = 60*10^3; % 60kV
t = 37.6*10^-9; % 37.6ns
c = 3*10^8; % Speed of light

T = (2*sqrt(er)*L)/c; % 1.25*10^-8
Reflections = t/T; % 3.008 - 3 reflections occur during the time period. 

% Part A
Zload = Z0;
Vpfla = V0/2; % 30000 = 30kV - Matched load
rowload = (Zload-Z0)/(Zload+Z0); % 0 - Matched load
V1a = Vpfla; % 30kV
V2a = V1a*rowload; % 0kV
V3a = V2a*rowload; % 0kV
Va = [V1a, V2a, V3a];

% Part B
Zload = 5*Z0;
Vpflb = (V0*Zload)/(Z0+Zload); % 50000 = 50kV
rowload = (Zload-Z0)/(Zload+Z0); % 0.6667
V1b = Vpflb; % 50kV
V2b = V1b*rowload; % 33.33kV
V3b = V2b*rowload; % 22.22kV
Vb = [V1b, V2b, V3b];

% Part C
Zload = Z0/5;
Vpflc = (V0*Zload)/(Z0+Zload); % 10000 = 10kV
rowload = (Zload-Z0)/(Zload+Z0); % -0.6667
V1c = Vpflc; % 10kV
V2c = V1c*rowload; % -6.67kV
V3c = V2c*rowload; % 4.44kV
Vc = [V1c, V2c, V3c];

% Plotting Graphs
figure
subplot(3,1,1)
bar(Va/1000, 1, 'b')
grid on
title('Zload = Z0')
ylabel('Voltage (kV)')
xlabel('Time (T)')
subplot(3,1,2)
bar(Vb/1000, 1, 'm')
grid on
title('Zload = 5*Z0')
ylabel('Voltage (kV)')
xlabel('Time (T)')
subplot(3,1,3)
bar(Vc/1000, 1, 'y')
grid on
title('Zload = $${Z0\over 5}$$', 'Interpreter','Latex')
ylabel('Voltage (kV)')
xlabel('Time (T)')
