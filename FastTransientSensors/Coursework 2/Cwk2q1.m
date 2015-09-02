% Fast Transient Sensors - Coursework 2
% Devon Kerai (B128203)
% Due 17th March 2015

% Question 1
% Pre requisites
clc
clear

% Variables
u0 = 4*pi*10^-7; % Free space permeability
e0 = 8.85*10^-12; % Free space permittivity
a = 3.5*10^-3; % 3.5mm
b = 10.5*10^-3; % 10.5mm
La = 22*10^-3; % 22mm
Lb = 12*10^-3; % 12mm
Lc = 50*10^-3; % 50mm
row = 72*10^-8; % 72uOhmcm

% Part A
Rcon = row * (Lc / (pi*a*b)); % 3.1181*10^-4 = 0.31mOhms
Rstart = row*La/((pi*(a^2))); % 4.1159*10^-4 = 0.41mOhms
Rend = row*Lb/((pi*(b^2))); % 2.4945*10^-5 = 25uOhms
Rdc = Rcon + Rstart + Rend; % 7.4835*10^-4 = 0.75mOhms

% Part B
Fcritstart = row/((a^2)*pi*u0); % 1.4888*10^4 = 0.15kHz
Fcritend = row/((b^2)*pi*u0); % 1.6542*10^3 = 1.65kHz

% Conical section
alpha = atan((b-a)/Lc);
N = 1000;
z = Lc/N;
for n = 1:1:N
    height(n) = z*n.*tan(alpha)+a;
    Fcritcon(n) = row./((height(n).^2).*pi.*u0);
    Rdccon(n) = row.*z/((pi.*(height(n).^2)));
end

RFreq = zeros(50);
freq = logspace(0,9);

for f = 1:1:50
    
    % First Section
    if freq(f) >= Fcritstart
        delta = sqrt(row./(freq(f).*pi.*u0));
        Rfsect = (La*row)/(2*a*pi*(delta*(1-(delta/(2*a)))));
    else
        Rfsect = Rstart;
    end
    
    % End Section
    if freq(f) >= Fcritend
        delta = sqrt(row./(freq(f).*pi.*u0));
        Resect = (Lb*row)/(2*b*pi*(delta*(1-(delta/(2*b)))));
    else
        Resect = Rend;
    end
    
    % Conical Section
    for n = 1:1:N
        if freq(f) >= Fcritcon(n)
            delta = sqrt(row./(freq(f).*pi.*u0));
            Rcsect(n) = (z*row)/(2*height(n)*pi*(delta*(1-(delta/(2*height(n))))));
        else
            Rcsect(n) = Rdccon(n);
        end
    end
    
    % Total Conductor Resistance
    RFreq(f) = Rfsect + Resect + sum(Rcsect);
end

loglog(freq, (RFreq./Rdc))
grid on
title('Conductor Resistance vs Frequency') 
xlabel('Frequency (Hz)') 
ylabel('Resistance (\Omega)') 
