% Fast Transient Sensors - Coursework 2
% Devon Kerai (B128203)
% Due 17th March 2015

% Question 2
% Pre requisites
clc
clear

% Variables
u0 = 4*pi*10^-7; % Free space permeability
e0 = 8.85*10^-12; % Free space permittivity
d = 0.14*10^-3; % 0.14mm - Wire diameter
D = 4*10^-2; % 4cm - inner diameter
L = 10*10^-2; % 10cm - axial length
p = 0.8*10^-3; % 0.8mm - pitch
row = 1.72*10^-8; % 1.72uOhmcm - resistivity

% Part A
R = D/2;
length = (L/p)*(sqrt(((2*pi*R)^2)+(p^2))); % 15.7083m

r = d/2;
area = pi*(r^2); % 1.5394*10^-8 = 0.154nm^2
Rdc = (row*length)/area; % 17.5514 Ohms

% Part B
r = d/2;
f = 1*10^6; % 1MHz
delta = sqrt(row/(f*pi*u0)); % 6.6006*10^-5
Rskin = (length*row)/(2*r*pi*delta*(1-(delta/(2*r)))); % 17.6087 Ohms
Rprox = (1+((2*(r^2))/(p^2))); % 1.0153 Ohms
Rsp = Rdc*Rskin*Rprox; % 313.7893 Ohms

% Part C
r = d/2;
Fcrit = row./((r.^2).*pi.*u0);

RFreq = zeros(50);
freq = logspace(0,7);
for f = 1:1:50
    if freq(f) > Fcrit
        delta = sqrt(row./(freq(f).*pi.*u0));
        Rskin = (length*row)/(2*r*pi*delta*(1-(delta/(2*r))));
        Rprox = (1+((2*(r^2))/(p^2)));
        RFreq(f) = Rdc*Rskin*Rprox;
    else
        RFreq(f) = Rdc;
    end
end

semilogx(freq, (RFreq./Rdc))
grid on
title('Helical Coil Resistance vs Frequency')
ylabel('Helical Resistance/Helical DC Resistance')
xlabel('Frequency (Hz)')

ylim([1, inf])
xlim([0, 10^7])

% Part D
% Litz wire is a solution to maintain coil resistance up to high
% frequencies without affecting the inductance. It does this by consisting
% of many thin, insulated wire strands which are twisted together. Due to
% each wire being less than the skin depth, there is a reduced amount of
% skin effect and proximity effect losses.

% The Litz wire is used at frequencies up to 1MHz and is commonly used to
% make inductors and transformers for high frequency applications.
