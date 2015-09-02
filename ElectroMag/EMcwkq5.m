% Electromagnetism C - Coursework
% Devon Kerai (B128203)

% Question 5

% Pre-requisites to clear the command window and workspace
clear
clc

% Variables
q = 500*10^-12;
a = 2*10^-2;
b = 1.8*10^-2;
e0 = (1*10^-9)/(36*pi);

% Co-ords of q1
q1x = 0;
q1y = 0;

% Co-ords of q2
q2x = a;
q2y = b;

% Co-ords of q3
q3x = 2*a;
q3y = 0;

% Co-ords of P
px = 2*a;
py = 2*b;

% Angle of q1 and q2
angle = atand(b/a); % 41.9872

% Distances from charges to P.
q1p = sqrt(((px)^2)+((py)^2)); % 0.0538
q2p = sqrt(((px-q2x)^2)+((py-q2y)^2)); % 0.0269
q3p = py-q3y; % 0.036

k = q/(4*pi*e0); % 4.5000

q1v = k/q1p; % 83.6206V
q2v = k/q2p; % 167.2412V
q3v = k/q3p; % 125.0000V

VatP = q1v+q2v+q3v; % 375.8618V

q1e = k/(q1p^2); % 1553.9V/m
q2e = k/(q2p^2); % 6215.5V/m
q3e = k/(q3p^2); % 3472.2V/m

Ev = q3e+((q1e+q2e)*sind(angle)); % 8669.6V/m
Eh = (q1e+q2e)*cosd(angle); % 5774.9V/m

EatP = sqrt((Ev^2)+(Eh^2)) % 10417V/m

direction = atand(Ev/Eh) % 56.3 degrees from horizontal

