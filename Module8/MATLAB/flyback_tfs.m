% Module 8 Assignment:
% Flyback small signal transfer functions

close all
clear all
clc

% Given Converter Parameters
Vg = 48;     %AVG input
V = 12;      %AVG output
P = 150;     %output power
fsw = 100e3; %switcghing frequency 
Lm = 250e-6; %magnetizing inducatanze
Ron = 0;     %fet on resistance
Cout = 100e-6;  %output cap
n = 0.5;     %turns ratio (n2/n1)

% Calculated parameters
Ts = 1/fsw;
D = V/(V + n*Vg); 
Dprime = 1-D;
Ip = Vg/Lm * D * Ts;
I = Vg * (D * (Ip/2)/V);

Rout = V / I;


% transfer functions
s =tf('s'); % s = jw

%line to output Gvg
Ggo =  D * n / Dprime;
wo = (Dprime) / (n * sqrt( Lm * Cout ) );
Q = Rout * sqrt( Lm * Cout) / (n * Lm);

Gvg = Ggo/(1 + s/(Q*wo) + (s/wo)^2);

 figure();
 bode(Gvg);
 title('line to output transfer function flyback');


% control to output Gvd

Gdo = Dprime/(n*Vg + V);
wz = Dprime*(Vg + (V/n)) / (I*Lm);

Gvd = (Gdo*(1 - s/wz)) / (1 + s/(Q*wo) + (s/wo)^2);

 figure();
 bode(Gvd);
 title('control to output transfer function flyback');


