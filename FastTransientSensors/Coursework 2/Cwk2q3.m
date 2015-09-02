% Fast Transient Sensors - Coursework 2
% Devon Kerai (B128203)
% Due 17th March 2015

% Question 3
% Pre requisites
clc
clear

% Variables
u0 = 4*pi*10^-7; % Free space permeability
e0 = 8.85*10^-12; % Free space permittivity
Rc = 51; % 51 Ohms - Coaxial resistor
f = 1*10^9; % 1GHz - frequency
Zi = 51; % 51 Ohms - Transmission line impedance
L = 30*10^-3; % 30mm - axial length
row = 138*10^-8; % 138 uOhmcm
sigma = 1/row; % 7.24641x10^5 - Conductivity

% Length of wire
delta = sqrt(1/(pi*sigma*u0*f)); % 1.8696*10^-5m = 18.7um - radius
Sskin = (2*delta*pi*delta*(1-(delta/(2*delta)))); % 1.0982*10^-9
length = Rc*sigma*Sskin; % 0.0406m = 40.6mm

% Conductor/Insulator ratio
er = 2.25; % Permittivity of polyethylene 
e = e0*er; % 1.9912*10^-11

outerR = delta*exp((Zi*2*pi)/sqrt(u0/e0)); % 4.376*10^-5 = 43.8um - outer radius

% Plot graph of resistance vs frequency
for n = 1:1000;
    f(n)=10.^(0.01*n);
    
    skind(n) = sqrt(1/(f(n)*pi*sigma*u0));
    if(skind(n) > delta);
        skind(n) = delta; 
    end
    
    sSkin = 2*delta*pi*skind(n)*(1-(skind(n)/(2*delta)));
    res(n) = length/(sigma*sSkin);     
end

semilogx(f,res);
grid on
title('Coaxial Resistance with Frequency')
ylabel('Coaxial Resistance (\Omega)')
xlabel('Frequency (Hz)')

