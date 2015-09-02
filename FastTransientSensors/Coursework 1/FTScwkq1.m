% Fast Transient Sensors - Coursework 1
% Devon Kerai (B128203)
% Due 14th January 2015

% Question 1

% Variables
mew = 4*pi*10^-7;
pitch = 1*10^-3; % pitch in meters.
turns = 60;
diameter = 10*10^-3; % diameter in meters.
radius = diameter/2;
distance = 30*10^-3; % distance in meters (from origin to coil).
current = 100; % amps

length = pitch*turns; % length of coil = 0.06m
Zp = distance+(length/2); % 0.06m

% Part A
Bo = (mew*turns*current)/(2*length); % 0.0628

Ba = (Zp+(length/2))/(sqrt((radius^2)+(Zp+(length/2))^2)); % 0.9985

Bb = (Zp-(length/2))/(sqrt((radius^2)+(Zp-(length/2))^2)); % 0.9864

magFluxDens = Bo*(Ba-Bb); % 7.5816*10^-4 T = 0.76mT

% Part B
totalMagFluxDens = sqrt(magFluxDens^2+magFluxDens^2+magFluxDens^2); % 0.0013T = 1.3mT
angle = acos(magFluxDens/totalMagFluxDens); % 0.9553 rads

% Part C
totalMagField = (sqrt(magFluxDens^2+((-magFluxDens)^2)+magFluxDens^2))/mew; % 1.045*10^3 = 1kT

% Angles
angle1 = acos(magFluxDens/totalMagFluxDens); % 0.9553 rads
angle2 = acos(-magFluxDens/totalMagFluxDens); % 2.1863 rads
angle3 = acos(magFluxDens/totalMagFluxDens); % 0.9553 rads

% Part D
Zp = (0:1*10^-4:(distance+(length/2))); % Changing Zp from origin to mid point of the coil

Bo = (mew.*turns.*current)./(2.*length);
Ba = (Zp+(length./2))./(sqrt((radius.^2)+(Zp+(length./2)).^2));
Bb = (Zp-(length./2))./(sqrt((radius.^2)+(Zp-(length./2)).^2));
magFluxDens=Bo.*(Ba-Bb);

plot (Zp*1000, magFluxDens*1000)
title ('Plot to show the magnetic flux density generated by one coil along its axis')
xlabel ('Zp (mm)')
ylabel ('Magnetic Flux Density (mT)')
    