%close all
%clear all
clc

%converter parameters
N = 1/2;
Vg = 48;
fsw = 200e3;
D = 0.3;
Dpr = 1 - D;
L = 250e-6;    
Ts = 1/fsw;
C = 100e-6;
R = 5;

V = Vg * N * D/Dpr;
I = N*V / (Dpr*R);

%filter requirements
atten_db = 100;

% ||G|| = (f/fo)^n, n=-2 (2nd order low pass)
% solve for fo such that attenuation at fsw is 100 dB
% fo = 1 / 2pi sqrt(lc)
lin_atten = 10^(-atten_db/20);
fo = sqrt(lin_atten)*fsw;
Cf = 47e-6 * 3;
Lf = ((1/(fo*2*pi))^2)/Cf;

%parallel RC damping
% n factor is Cb/Cf
% min between ZD and ZN is 5.43
% design Zo as 0.3Zmin = 1.63
% Zomm = Rof * sqrt(2*(2+n))/n
% Rof is Zi of undamped filter = sqrt(L/C)

Zomm = 1.63;
Rof = sqrt(Lf/Cf);

% n*Zomm/Rof = sqrt(2(2+n))
%  n^2 * Zomm^2/Rof^2 -2n -4 = 0
a = (Zomm^2)/Rof^2; b = -2; c = -;
n = (-b + sqrt(b^2 - 4*a*c))/(2*a);

Cb = n*Cf;
Rf = Rof*sqrt( ( (2+n) * (4+3*n) ) / ( (2*n^2) * (4+n) ) );
s = tf('s');

% Zojw = (R+C)//L//C
Zrc = Rf + (1/(s*Cb));
Zl = s*Lf;
Zc = 1/(s*Cb);s
Zo = Zrc*Zl*Zc/(Zrc+Zl+Zc);

%small signal for Zd/Zn 
% Ldi/dt = Dvg - Dp v/n + (Vg + V/n)d
% Zn requires Dp*il = I*d (no current through output node)


Zn = (s*L - (Dpr/I)*(Vg + V/N) )/ D;

Zd = ( s*L + (Dpr^2)/(N^2 * (C*s + 1/R)))/D; 

figure();
bodemag(Zo);
hold on;
bodemag(Zn);
hold on;
bodemag(Zd);
