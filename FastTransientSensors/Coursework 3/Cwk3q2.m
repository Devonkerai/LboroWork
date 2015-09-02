% Fast Transient Sensors - Coursework 2
% Devon Kerai (B128203)
% Due 19th May 2015

% Question 2
% Pre requisites
clc
clear
close all

% Variables
u0 = 4*pi*10^-7; % Free space permeability
e0 = 8.85*10^-12; % Free space permittivity
C = 1*10^-6; % Capacitance
L = 50*10^-9; % Inductance
R = 10*10^-3; % Resistance
V0 = 40*10^3; % Initial Voltage
rodDiameter = 10*10^-3; % Rod diameter
voltlimit = 1*10^3;

%% Part 1
t = 0:1*10^-9:50*10^-6;

dampingfactor = 2*(sqrt(L/C));
omegapre = 1/(L*C);
omegasuf = (R/(2*L));
omega = sqrt(omegapre-(omegasuf^2));
omegastar = sqrt((omegasuf^2)-omegapre);

if R < dampingfactor
    currentdischarge = (V0/(omega*L))*exp(-omegasuf.*t).*sin(omega.*t);
    differentialcurrentdischarge = (V0./(omega.*L)).*((((-omegasuf)...
        .*exp(-omegasuf.*t)).*sin(omega.*t))+((omega.*exp(-omegasuf.*t)).*cos(omega.*t)));
    % Under Damped
end

if R == dampingfactor
    currentdischarge = ((V0*t)/L)*exp(-omegasuf.*t);
    differentialcurrentdischarge = ((-V0*R.*t)/(2*(L^2))).*exp(-omegasuf.*t)+(V0/L).*exp(-omegasuf.*t);
    % Critically Damped5
end
    
if R > dampingfactor
    currentdischarge = (V0/(2*omegastar*L)).*exp(-omegasuf.*t).*(exp(omegastar.*t)-exp(-omegastar.*t));
    differentialcurrentdischarge = (V0./(2.*omegastar.*L)).*((exp(-omegasuf.*t)...
        .*(omegastar.*exp(omegastar.*t)+omegastar.*exp(-omegastar.*t)))...
        +(-omegasuf).*exp(-omegasuf.*t).*(exp(omegastar.*t)-exp(-omegastar.*t)));
    % Over Damped
end

% Graph for current discharge
% figure
% plot(t.*10^6,currentdischarge.*10^-3,'Linewidth',2)
% grid on
% title('Current Discharge for a RLC Circuit')
% xlabel('Time (\mus)') 
% ylabel('Current (kA)')
    
% Graph for current differential discharge
% figure
% plot(t.*10^6,differentialcurrentdischarge.*10^-9,'Linewidth',2)
% grid on
% title('Differential Current Discharge for a RLC Circuit')
% xlabel('Time (\mus)')
% ylabel('Current (kA/s)')
    
%% Part 2
majorRad = 20*10^-3;
minorRad = 2*10^-3;
wireRad = 1*10^-3;
diameter = 2*wireRad;
N = 10; % Should be between 5 and 15
resistivity = 1.68*10^-8; % Copper resistivity
Rcdr = 50; % Ohms - Current viewing resistor

%% Part 3
pitch = (2*pi*majorRad)/N;
induct1 = u0*minorRad*N;
sum1 = 0.0007*((log((2*pi*majorRad)/pitch))^0);
sum2 = 0.1773*((log((2*pi*majorRad)/pitch))^1);
sum3 = -0.0322*((log((2*pi*majorRad)/pitch))^2);
sum4 = 0.00197*((log((2*pi*majorRad)/pitch))^3);
sumTotal = sum1+sum2+sum3+sum4;
induct2 = (((pi*minorRad)/pitch)+(log((2*pitch)/diameter))-(5/4)-sumTotal);
inductFinal = induct1*induct2;

%% Part 4
freq = 1/(2*pi*sqrt(L*C));
resistCoil1 = N/(pi*diameter);
resistCoil2 = sqrt((resistivity*pi*freq*u0)*((pitch^2)+((2*pi*minorRad)^2)));
resCoilFinal = resistCoil1*resistCoil2;

%% Part 5
% Differential Current Discharge
k = u0.*N.*(majorRad-sqrt((majorRad^2)-(minorRad^2)));
diffflux = k*differentialcurrentdischarge;
    
% Graph for current differential discharge
% figure
% plot(t.*10^6,diffflux,'Linewidth',2)
% grid on
% title('Differential Magnetic flux for a RLC Circuit')
% xlabel('Time (\mus)') 
% ylabel('Differential Magnetic flux (T/s)')

%% Part 6 and Part 7
Rr = resCoilFinal+Rcdr;
Lr = inductFinal;
time = 0:1*10^-12:10*10^-9;

% Rogowski Coil
rog1 = (exp((-Rr.*time)./Lr))./Lr;
rog2 = @(time) exp((Rr./(Lr)).*time).*(k.*(V0./(omega.*L).*((omega.*exp(-1.*(R./(2.*L))...
    .*time).*cos(omega.*time))+((-1.*(R./(2.*L))).*exp(-1.*(R./(2.*L)).*time).*sin(omega.*time)))));


rog3 = zeros(0, length(time));
for n=1:length(time)
   rog3(n) = integral(@(time) rog2(time), 0, time(n)); 
end
rogCurrent = rog1.*rog3;

% Differential Rogowski Coil
fluxdifferential = (k.*(V0./(omega.*L).*((omega.*exp(-1.*(R./(2.*L)).*time)...
    .*cos(omega.*time))+((-1.*(R./(2.*L))).*exp(-1.*(R./(2.*L)).*time).*sin(omega.*time)))));
diffRogCurrent1 = (rog1.*(exp((Rr./Lr).*time)).*fluxdifferential);
diffRogCurrent = diffRogCurrent1+(rog3.*((-Rr./Lr).*rog1));
 
% Graph for Current flowing through the Rogowski Coils
% figure
% hold on
% plot(time.*10^9,rogCurrent,'b','Linewidth',2)
% grid on
% title('Rogowski Coil Current')
% xlabel('Time (ns)') 
% ylabel('Current (A)')
% hold off

% Graph for differential current flowing through the Rogowski Coils.
% figure
% hold on
% plot(time.*10^9,diffRogCurrent*10^-9,'r','Linewidth',2)
% grid on
% title('Rogowski Coil Differential Current')
% xlabel('Time (ns)') 
% ylabel('Differential Current (GA/s)')
% hold off

% Graph for the voltage of the Rogowski coils
% figure
% hold on
% plot(time.*10^9,rogCurrent.*Rr,'b','Linewidth',2)
% plot(time.*10^9,diffRogCurrent.*Lr,'r','Linewidth',2)
% grid on
% title('Rogowski Coil Voltage')
% xlabel('Time (ns)')
% ylabel('V_{R} (V)')
% legend('RI','LdI/dt')
% hold off

%% Part 8
% Differential Current Discharge
k = u0.*N.*(majorRad-sqrt((majorRad^2)-(minorRad^2)));
Vout = k*differentialcurrentdischarge;
    
% Graph for current differential discharge
% figure
% plot(t.*10^6,Vout,'Linewidth',2)
% grid on
% title('Rogowski Coil Voltage Output')
% xlabel('Time (\mus)') 
% ylabel('Voltage (V)')

%% Part 9
Rsens = 5;
Csens = 5*10^-9;
Tau = Rsens*Csens;
Vout = (rogCurrent.*k)/Tau;

% Graph for voltage output with integrator
% figure
% plot(time.*10^6,Vout,'Linewidth',2)
% grid on
% title('Voltage output to match the sensor')
% xlabel('Time (\mus)') 
% ylabel('Voltage (V)')



