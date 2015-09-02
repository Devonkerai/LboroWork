% Fast Transient Sensors - Coursework 1
% Devon Kerai (B128203)
% Due 14th January 2015

% Question 4

% Variables
mew = 4*pi*10^-7;
permittivity = 2.4;
epsillion = 8.854*10^-12;
volts = 1;
distance = 20*10^-3;
diameter = 40*10^-3;
radius = diameter/2;
thickness = 3*10^-3;

% Part B
elecfieldestimate = volts/distance; % Electric Field (estimate) = 50 V/m
elecfieldfrommaxwell = 4.2853*10^1; % 43 V/m

% The estimated value of the electrical field does not take into account
% the plastic core. This is why the electric field retrieved from Maxwell
% is lower.

% Part C
maxelecfield = 1.2849*10^2 % 128 V/m

% Use above value to calculate the field enhancement in respect to the
% central field inside the capacitor.

% Field Enhancement
fieldenhancement = maxelecfield/elecfieldfrommaxwell % 2.9984

% Round the edges of the core and insulator to reduce the edge and fringe
% effects.

% Part D
surfacearea = pi*(radius^2);
capest = epsillion*permittivity*(surfacearea/distance); % Capacitance = 1.3352*10^-12F = 1.34pF

capactual = 2.1813*10^-12;

% Capacitor is not homogeneous.
