% Fast Transient Sensors - Coursework 1
% Devon Kerai (B128203)
% Due 14th January 2015

% Question 3

% Variables
mew = 4*pi*10^-7;
pitch = 2*10^-3; % meters
length = 200*10^-3; % meters
diameter = 20*10^-3; % meters
radius = diameter / 2;
Z1 = 20*10^-3; % meters
Z2 = 120*10^-3; % meters
Z3 = length+Z1+Z2; % meters
turns = length / pitch;

% Part A
correctionFactor = length/(length+(0.9*radius));
inductance = (mew*pi*(turns^2)*(radius^2))/(length)*correctionFactor; % 1.8889*10^-5 = 18.89uH

% Part B
% M12
lengthl123 = length+length+Z1;
turns = lengthl123/pitch;
correctionFactor = lengthl123/(lengthl123+(0.9*radius));

L123 = (mew*pi*(turns^2)*(radius^2))/(lengthl123)*correctionFactor;

turns = Z1/pitch;
correctionFactor = Z1/(Z1+(0.9*radius));

L3 = (mew*pi*(turns^2)*(radius^2))/(Z1)*correctionFactor;

length13 = length+Z1;
turns = length13/pitch;
correctionFactor = length13/(length13+(0.9*radius));

L13 = (mew*pi*(turns^2)*(radius^2))/(length13)*correctionFactor;

length23 = Z1+length;
turns = length23/pitch;
correctionFactor = length23/(length23+(0.9*radius));

L23 = (mew*pi*(turns^2)*(radius^2))/(length23)*correctionFactor;

M12 = 0.5*(L123+L3-L13-L23) % M12 = 1.1224*10^-7 = 0.112uH

% M13
lengthl123 = length+length+Z3;
turns = lengthl123/pitch;
correctionFactor = lengthl123/(lengthl123+(0.9*radius));

L123 = (mew*pi*(turns^2)*(radius^2))/(lengthl123)*correctionFactor;

turns = Z3/pitch;
correctionFactor = Z3/(Z3+(0.9*radius));

L3 = (mew*pi*(turns^2)*(radius^2))/(Z3)*correctionFactor;

length13 = length+Z3;
turns = length13/pitch;
correctionFactor = length13/(length13+(0.9*radius));

L13 = (mew*pi*(turns^2)*(radius^2))/(length13)*correctionFactor;

length23 = Z3+length;
turns = length23/pitch;
correctionFactor = length23/(length23+(0.9*radius));

L23 = (mew*pi*(turns^2)*(radius^2))/(length23)*correctionFactor;

M13 = 0.5*(L123+L3-L13-L23) % M13 = 2.2283*10^-9 = 2.23nH

% M23
lengthl123 = length+length+Z2;
turns = lengthl123/pitch;
correctionFactor = lengthl123/(lengthl123+(0.9*radius));

L123 = (mew*pi*(turns^2)*(radius^2))/(lengthl123)*correctionFactor;

turns = Z2/pitch;
correctionFactor = Z2/(Z2+(0.9*radius));

L3 = (mew*pi*(turns^2)*(radius^2))/(Z2)*correctionFactor;

length13 = length+Z2;
turns = length13/pitch;
correctionFactor = length13/(length13+(0.9*radius));

L13 = (mew*pi*(turns^2)*(radius^2))/(length13)*correctionFactor;

length23 = Z2+length;
turns = length23/pitch;
correctionFactor = length23/(length23+(0.9*radius));

L23 = (mew*pi*(turns^2)*(radius^2))/(length23)*correctionFactor;

M23 = 0.5*(L123+L3-L13-L23) % M23 = 1.4243*10^-8 = 14.2nH

% Part C
coilinseries = inductance*3;
totalmutual = 2*(M12+M13+M23);
totalinductance = coilinseries+totalmutual % 5.6925*10^-5 = 57uH
