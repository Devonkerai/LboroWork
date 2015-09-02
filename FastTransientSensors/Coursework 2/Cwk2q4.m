% Fast Transient Sensors - Coursework 2
% Devon Kerai (B128203)
% Due 17th March 2015

% Question 4
% Pre requisites
clc
clear

% Variables
u0 = 4*pi*10^-7; % Free space permeability
e0 = 8.85*10^-12; % Free space permittivity

% Part C
C = 0.1*10^-6; % 0.1uF - bank capacitance
V0 = 30*10^3; % 30kV - Initial charge voltage
Im1 = 10*10^3; % 10kA
tm1 = 250*10^-9; % 250ns

gamma = 0:0.01:1;
F = C.*V0.*q4ffunction(gamma).*q4gfunction(gamma)-(tm1*Im1);

% Plotting graph
figure
plot(gamma,F)
grid on
title('Graph of F(\gamma) vs \gamma')
xlabel('\gamma')
ylabel('F(\gamma)')

gamma = 0.3421; % Obtained by looking at the graph
Lacc = ((V0.*sqrt(C).*q4gfunction(gamma))./Im1).^2; % 3.6977*10^-7 0.37uH
Racc = 2.*gamma.*sqrt(Lacc./C); % 1.3157

% Part D
t = 0:1*10^-10:0.5*10^-5;
omega = (1/sqrt(Lacc*C)).*sqrt(1-(gamma^2)); % 4.8866*10^6
Ia = (V0./(omega.*Lacc));
Ib = exp((-Racc/(2*Lacc)).*t);
Ic = sin(omega*t);
I = (Ia.*Ib).*Ic;

% Plotting Graph
figure
plot(t/10^-6,I/1000)
grid on
title('Capacitor Bank Discharge (Current vs Time)')
ylabel('Current (kA)')
xlabel('Time (\mu secs)')

Im2 = min(I); 
Tz = 6.429*10^-7; % Obtained from graph
T = 2*Tz;
Lest = (T^2)/(4*(pi^2)*C); % 4.1878*10^-7
Rest = (-2/pi)*(sqrt(Lest/C))*(log(abs(Im2)/Im1)); % 1.4901

Lerror1 = ((Lest-Lacc)/Lacc)*100; % 13.2553%
Rerror1 = ((Rest-Racc)/Racc)*100; % 13.2548%

% Part E
C = 54*10^-6; % 54uF - bank capacitance
V0 = 27*10^3; % 27kV - Initial charge voltage
Im1 = 1*10^6; % 1MA
tm1 = 1.7*10^-6; % 1.7us

gamma = 0:0.01:1;
F1 = C.*V0.*q4ffunction(gamma).*q4gfunction(gamma)-(tm1*Im1);

% Plotting graph
figure
plot(gamma,F1)
grid on
title('Graph of F(\gamma) vs \gamma')
xlabel('\gamma')
ylabel('F(\gamma)')

gamma = 0.1464; % Obtained by looking at the graph
Lacc = ((V0.*sqrt(C).*q4gfunction(gamma))./Im1).^2; % 2.5828*10^-8
Racc = 2.*gamma.*sqrt(Lacc./C); % 0.0064

t = 0:1*10^-10:0.6*10^-4;
omega = (1/sqrt(Lacc*C)).*sqrt(1-(gamma^2)); % 4.8866*10^6
Ia = (V0./(omega.*Lacc));
Ib = exp((-Racc/(2*Lacc)).*t);
Ic = sin(omega*t);
I = (Ia.*Ib).*Ic;

% Plotting Graph
figure
plot(t/10^-6,I/1000)
grid on
title('Capacitor Bank Discharge (Current vs Time)')
ylabel('Current (kA)')
xlabel('Time (\mu secs)')

Im2 = min(I); 
Tz = 3.751*10^-6; % Obtained by looking at the graph
T = 2*Tz;
Lest = (T^2)/(4*(pi^2)*C); % 2.64*10^-8
Rest = (-2/pi)*(sqrt(Lest/C))*(log(abs(Im2)/Im1)); % 0.0065

Lerror2 = ((Lest-Lacc)/Lacc)*100; % 2.2145%
Rerror2 = ((Rest-Racc)/Racc)*100; % 2.2024%

% Part F
% The Calibration shot equations take into account the second peak whereas
% the accurate equations do not. Because L and R are measured over a
% greater time period, the inductance and resistance will be lower than
% using just the first peak.

% The inductance changes because of the movement of the conductors from
% electromagnetic forces. The change of inductance, increases the total
% resistance of the circuit.
