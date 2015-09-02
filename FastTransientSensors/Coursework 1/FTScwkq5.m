% Fast Transient Sensors - Coursework 1
% Devon Kerai (B128203)
% Due 14th January 2015

% Question 5

% Variables
mew = 4*pi*10^-7; % constant

% Single turn coils
D2 = 40*10^-3; % meters (inner diameter)
R2 = D2/2; % meters
H1 = 20*10^-3; % meters (width)

% Transmission Line
distance = 0.2*10^-3; % meters
length = 300*10^-3; % meters
H2 = 100*10^-3; % meters
delta = 45*10^-3; % meters
beta = 35*10^-3; % meters
alpha = 45; % degrees

S = H2-H1; % 80*10^-3 (distance between the two single turn coils)

% Inductance of trapezium:
heightoftrap = (S/2)*tanh(45); % 0.04m
wm = (H2+H1)/2; % 0.06
xtrap = distance/wm; % 0.0033
Fxtrap_1 = 1+(1.21*(xtrap))-(0.11*(xtrap^2));
Fxtrap_2 = ((xtrap/2)*((1-(xtrap/2))^6));
Fxtrap = 1/(Fxtrap_1+Fxtrap_2); % 0.9943

inducttrap = (mew*heightoftrap)*(distance/(H2-H1))*log(H2/H1)*Fxtrap; % 2.0111*10^-10 = 0.2nH

% Inductance of big rectangle (at the bottom)
lengthbr = length+beta; % 0.3350m
xbr = distance/(2*H2); % 1*10^-3
Fxbr_1 = ((xbr/2)*((1-(xbr/2))^6)); % 4.9850*10^-4
Fxbr_2 = 1+(1.21*xbr)-(0.11*(xbr^2)); % 1.0012
Fxbr = 1/(Fxbr_2+Fxbr_1); % 0.9983

inductbr = (mew*lengthbr)*(xbr)*Fxbr; % 4.2026*10^-10 = 0.42nH

% Inductance of the single turn coil
y = R2 / H1; % 1
hcy = (0.5/y)-(0.0625/(y^3))+(0.0117/(y^5)); % 0.4492
hey = 0.5-(0.21/(y^0.61)); % 0.29
alphay = (0.782*y)+1.5145; % 2.2965

firstbit = (pi*(R2^2))/H1; % 0.06280
secondbit = hcy+((2/(alphay+2))*(hey-hcy)); % 0.3751
inductcoil = mew*firstbit*secondbit; % 2.9616*10^-8 = 0.296nH

% Inductance of delta rectangle
xdr = distance/(H1); % 0.01
Fxdr = 1/(1+(1.21*xdr)-(0.11*(xdr^2))+((xdr/2)*((1-(xdr/2))^6))); % 0.9833

inductdr = mew*delta*xdr*Fxdr; % 5.5607*10^-10 = 0.556nH

% Mutual inductance
N = 1000;
for k = (0:1:N-1);
    j = (0:1:N-1);
    c = H1-(k.*(H1./N))+S+(j.*(H1./N));
    knum = 2.*(sqrt(R2.*R2));
    kdenom = sqrt(((R2+R2).^2)+(c.^2));
    k1 = knum./kdenom;
    [K,E] = ellipke(k1);
    mutualinductanceexact = ((2.*mew.*sqrt(R2.*R2))./k1).*((1-((k1.^2)./2)).*(K-E));
end

mutual = sum(mutualinductanceexact)

% Total Inductance
totalind = mutual+inductbr+(2*inducttrap)+(2*inductcoil)+(2*inductdr)


