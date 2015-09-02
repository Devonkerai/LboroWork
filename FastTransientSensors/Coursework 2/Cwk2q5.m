% Fast Transient Sensors - Coursework 2
% Devon Kerai (B128203)
% Due 17th March 2015

% Question 5
% Pre requisites
clc
clear

% Variables
u0 = 4*pi*10^-7; % Free space permeability
e0 = 8.85*10^-12; % Free space permittivity
Z0 = 50; % 50 Ohms
V = 5; % 5V
Zload1 = 50; % 50 Ohms
Zload2 = 20; % 20 Ohms
Zload3 = 75; % 75 Ohms

% Part A
% i)
Pload1 = (Zload1-Z0)/(Zload1+Z0); % 0
V1att2 = V*Pload1; % 0V

% ii)
Pload2 = (Zload2-Z0)/(Zload2+Z0); % -0.4286
V2att2 = V*Pload2; % 2.14V

% iii)
Pload3 = (Zload3-Z0)/(Zload3+Z0); % 0.2
V3att2 = V*Pload3; % 1V

% Plot Graphs
figure
subplot(3,1,1)
bar(3/2, V1att2, 1, 'y')
grid on
title('Zload = 50 \Omega')
ylabel('Volts (V)')
xlabel('Time (\delta)')
subplot(3,1,2)
bar(3/2, V2att2, 1, 'm')
grid on
title('Zload = 20 \Omega')
ylabel('Volts (V)')
xlabel('Time (\delta)')
subplot(3,1,3)
bar(3/2, V3att2, 1, 'c')
grid on
title('Zload = 75 \Omega')
ylabel('Volts (V)')
xlabel('Time (\delta)')

% Part B
% i)
Pload1 = (Zload1-Z0)/(Zload1+Z0); % 0
V1a = V; % 5V - from 0 -> delta
V1b = V1a*Pload1; % 0V - from delta -> 2delta
V1c = V1b*Pload1; % 0V - from 2delta -> 3delta
V1d = V1c*Pload1; % 0V - from 3delta -> 4delta
V1 = [V1a, V1b, V1c, V1d];

% ii)
Pload2 = (Zload2-Z0)/(Zload2+Z0); % -0.4286
V2a = V; % 5V - from 0 -> delta
V2b = V2a*Pload2; % 2.14V - from delta -> 2delta
V2c = V2b*Pload2; % 0.9184V - from 2delta -> 3delta
V2d = V2c*Pload2; % 0.3936V - from 3delta -> 4delta
V2 = [V2a, V2b, V2c, V2d];

% iii)
Pload3 = (Zload3-Z0)/(Zload3+Z0); % 0.2
V3a = V; % 5V - from 0 -> delta
V3b = V3a*Pload3; % 1V - from delta -> 2delta
V3c = V3b*Pload3; % 0.2V - from 2delta -> 3delta
V3d = V3c*Pload3; % 0.04V - from 3delta -> 4delta
V3 = [V3a, V3b, V3c, V3d];

% Plot graph
figure
subplot(3,1,1)
bar(V1, 1, 'g')
grid on
title('Zload = 50 \Omega')
ylabel('Volts (V)')
xlabel('Time (\delta)')
subplot(3,1,2)
bar(V2, 1, 'b')
grid on
title('Zload = 20 \Omega')
ylabel('Volts (V)')
xlabel('Time (\delta)')
subplot(3,1,3)
bar(V3, 1, 'y')
grid on
title('Zload = 75 \Omega')
ylabel('Volts (V)')
xlabel('Time (\delta)')
