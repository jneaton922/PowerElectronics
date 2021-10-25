close all
clear all
clc

% Converter Parameters
D=0.8;
R=10;
Vg=30;
L=160e-6;
C=160e-6;

% Calculations
Dprime=1-D;
V=Vg*(-D/Dprime);

s=tf('s'); % Laplace Transfer function operator s=jw

% Line to output and Control to output Transfer function Buck Boost
Ggo = - (D/Dprime);
Gdo = V/D/(Dprime);
wo = Dprime/sqrt(L*C);
Q = Dprime*R*sqrt(C/L);
fo = wo/2/pi;
wz = (Dprime^2)*R/D/L;
fz = wz/2/pi;

Gvd = Gdo*(1-s/wz)/( 1 +s/Q/wo + (s/wo)^2 );
Gvg = Ggo*1/( 1 +s/Q/wo + (s/wo)^2 );

figure()
bode(Gvd)
title('Control to Output Transfer Function Buck Boost')

figure()
bode(Gvg)
title('Lint to Output Transfer Function Buck Boost')
