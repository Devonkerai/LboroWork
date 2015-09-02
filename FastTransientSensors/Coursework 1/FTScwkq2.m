% Fast Transient Sensors - Coursework 1
% Devon Kerai (B128203)
% Due 14th January 2015

% Question 2

% Variables
mew = 4*pi*10^-7;
x = 0.1; % meters
N1 = 5; % number of turns on coil 1
N2 = 4; % number of turns on coil 2
R1 = 0.2; % meters
R2 = 0.4*10^-2; % meters
I1 = 100; % amps
I2 = 200; % amps
z = x/2; % meters

% Part A
B1 = (mew*(R1^2)*I1)/(2*((R1^2)+(z^2))^(3/2)); % Inductance of coil 1
B2 = (mew*(R2^2)*I2)/(2*((R2^2)+(z^2))^(3/2)); % Inductance of coil 2

Bsamedir = B1+B2; % Current in same direction: 3.0278*10^-4 = 0.3028mT
Boppodir = B1-B2; % Current in opposite direction: 2.7092*10^-4 = 0.271mT

% Part B
z = x; % distance between the coils
B = (mew*(R1^2)*I1)/(2*((R1^2)+(z^2))^(3/2)); % 2.2479*10^-4 = 0.225mT

areasmallcoil = (pi*(R2^2));
flux = B*areasmallcoil; % 1.1299*10^-08 = 11.3nWb
mutualest = ((N2^2)/I1)*flux; % 1.8079*10^-9 = 1.81nH

% Part C
z = x; % distance between the coils
knum = 2*(sqrt(R1*R2));
kdenom = sqrt(((R1+R2)^2)+(z^2));
k = knum/kdenom;
[K,E] = ellipke(k);

firstbitbr = (mew*I1)/(2*pi); % 2*10^-5
secondbitbr = (z)/((R2)*sqrt(((R1+R2)^2)+(z^2))); % 110.0393
thirdbitbr = -K+E*((R1^2+R2^2+z^2)/((R1-R2)^2+z^2)); % -0.1688
Br = firstbitbr*secondbitbr*thirdbitbr; % -3.7147*10^-4T = -0.371 mT

firstbitbz = (mew*I1)/(2*pi); % 2*10^-5
secondbitbz = (1)/(sqrt(((R1+R2)^2)+(z^2))); % 4.4016
thirdbitbz = K+E*((R1^2-R2^2-z^2)/((R1-R2)^2+z^2)); % 2.5943
Bz = firstbitbz*secondbitbz*thirdbitbz; % 2.2838*10^-4T = 0.228mT

% Part D
firstbitbr = (mew*I2)/(2*pi); % 4*10^-5
secondbitbr = (z)/((R1)*sqrt(((R1+R2)^2)+(z^2))); % 2.2008
thirdbitbr = -K+E*((R2^2+R1^2+z^2)/((R2-R1)^2+z^2)); % -0.1688
Br = firstbitbr*secondbitbr*thirdbitbr; % -1.4859*10^-5T = -14.9uT

firstbitbz = (mew*I2)/(2*pi); % 4*10^-5
secondbitbz = (1)/(sqrt(((R1+R2)^2)+(z^2))); % 4.4016
thirdbitbz = K+E*((R2^2-R1^2-z^2)/((R2-R1)^2 + z^2)); % 0.1698
Bz = firstbitbz*secondbitbz*thirdbitbz;% 2.9889*10^-5T = 30uT 

% Part E
z = x; % distance between the coils
knum = 2*(sqrt(R1*R2));
kdenom = sqrt(((R1+R2)^2)+(z^2));
k = knum/kdenom;
[K,E] = ellipke(k);

mutualinductanceexact = ((2*mew*sqrt(R1*R2))/k)*((1-((k^2)/2))*K-E); % 4.7215*10^-8 = 47.22nH
