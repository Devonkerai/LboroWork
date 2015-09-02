% Fast Transient Sensors - Coursework 3
% Devon Kerai (B128203)
% Due 19th May 2015

% Question 3
% Pre requisites
clc
clear
close all

% Variables
u0 = 4*pi*10^-7; % Free space permeability
e0 = 8.85*10^-12; % Free space permittivity
C = 100*10^-9;
L = 25*10^-9;
R = 50;
V0 = 60*10^3;
voltlimit = 1*10^3;

%% Part 1
t = 0:1*10^-12:10*10^-9;

dampingfactor = 2.*(sqrt(L./C));
omegapre = 1./(L*C);
omegasuf = (R./(2.*L));
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
    % Critically Damped
end
    
if R > dampingfactor
    currentdischarge = (V0./(2.*omegastar.*L)).*exp(-omegasuf.*t).*(exp(omegastar.*t)-exp(-omegastar.*t));
    differentialcurrentdischarge = (V0./(2.*omegastar.*L)).*((exp(-omegasuf.*t)...
        .*(omegastar.*exp(omegastar.*t)+omegastar.*exp(-omegastar.*t)))+(-omegasuf)...
        .*exp(-omegasuf.*t).*(exp(omegastar.*t)-exp(-omegastar.*t)));
    % Over Damped
end

% Graph for current discharge
% figure
% plot(t.*10^9,currentdischarge.*10^-3,'Linewidth',2)
% grid on
% title('Current Discharge for a RLC Circuit')
% xlabel('Time (ns)') 
% ylabel('Current (kA)')
    
% Graph for current differential discharge
% figure
% plot(t.*10^9,differentialcurrentdischarge.*10^-9,'Linewidth',2)
% grid on
% title('Differential Current Discharge for a RLC Circuit')
% xlabel('Time (ns)')
% ylabel('Current (GA)')

%% Part 2
majorRad = 20*10^-3;
minorRad = 2*10^-3;
wireRad = 1*10^-3;
diameter = 2*wireRad;
N = 40; % Should be in the 10s
resistivity = 1.68*10^-8; % Copper resistivity
Rcdr = 4; % Ohms - Current viewing resistor

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
freq = 1/(R*C);
resistCoil1 = N/(pi*diameter);
resistCoil2 = sqrt((resistivity*pi*freq*u0)*((pitch^2)+((2*pi*minorRad)^2)));
resCoilFinal = resistCoil1*resistCoil2;

%% Part 5
% Differential Current Discharge
k = u0.*N.*(majorRad-sqrt((majorRad^2)-(minorRad^2)));
diffflux = k*differentialcurrentdischarge;
    
% Graph for current differential discharge
% figure
% plot(t.*10^9,diffflux*10^-3,'Linewidth',2)
% grid on
% title('Differential Magnetic flux for a RLC Circuit')
% xlabel('Time (ns)') 
% ylabel('Differential Magnetic flux (kT/s)')

%% Part 6 and Part 7
Rr = resCoilFinal+Rcdr;
Lr = inductFinal;
time = 0:1*10^-12:10*10^-9;

% Rogowski Coil
rog1 = (exp((-Rr.*time)./Lr))./Lr;
rog2 = @(time) exp((Rr./(Lr)).*time).*(k.*(V0./(2.*omegastar.*L))...
    .*((exp(-omegasuf.*time).*(omegastar.*exp(omegastar.*time)...
    +omegastar.*exp(-omegastar.*time)))+(-omegasuf).*exp(-omegasuf.*time)...
    .*(exp(omegastar.*time)-exp(-omegastar.*time))));
rog3 = zeros(0, length(time));
for n=1:length(time)
   rog3(n) = integral(@(time) rog2(time), 0, time(n)); 
end
rogCurrent = rog1.*rog3;

% Differential Rogowski Coil
fluxdifferential = (k.*(V0./(2.*omegastar.*L)).*((exp(-omegasuf.*time)...
    .*(omegastar.*exp(omegastar.*time)+omegastar.*exp(-omegastar.*time)))...
    +(-omegasuf).*exp(-omegasuf.*time).*(exp(omegastar.*time)-exp(-omegastar.*time))));
diffRogCurrent1 = (rog1.*(exp((Rr./Lr).*time)).*fluxdifferential);
diffRogCurrent = diffRogCurrent1+(rog3.*((-Rr./Lr).*rog1));
 
% Graph for current flowing through the Rogowski Coils
% figure
% hold on
% plot(time.*10^9,rogCurrent,'b','Linewidth',2)
% grid on
% title('Rogowski Coil Current')
% xlabel('Time (ns)') 
% ylabel('Current (A)')
% hold off

% Graph for differential current flowing through the Rogowski Coils
% figure
% hold on
% plot(time.*10^9,diffRogCurrent*10^-9,'r','Linewidth',2)
% grid on
% title('Rogowski Coil Differential Current')
% xlabel('Time (ns)') 
% ylabel('Differential Current (GA/s)')
% hold off


% Graph for the Rogowski coils
% figure
% hold on
% plot(time.*10^9,(rogCurrent.*Rr)*10^-3,'b','Linewidth',2)
% plot(time.*10^9,(diffRogCurrent.*Lr)*10^-3,'r','Linewidth',2)
% grid on
% title('Rogowski Coil Voltage')
% xlabel('Time (ns)')
% ylabel('Voltage (kV)')
% legend('RI','LdI/dt')
% hold off


%% Part 8
% figure
% Rr = 1;
% plot(time.*10^9,(rogCurrent.*Rr),'b','Linewidth',2)
% grid on
% title('Output Voltage')
% xlabel('Time (ns)')
% ylabel('Voltage (V)')
% hold off
