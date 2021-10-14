clear all
close all
clc


% Input Parameters
Vg = 48;
V = 12;
Pout = 150;
fsw = 100e3;
n = 0.5;
Lm = 250e-6 ;
Cout = 100e-6;

% Calculations
Ts = 1/fsw;
duty = V/(V+n*Vg);
dprime = 1-duty;


Rcrit = 2*Lm*V*n/(duty*dprime*Ts*Vg)
D2 = 2*Lm*V*n/(duty*Rcrit*Ts*Vg)
i1peak = (Vg/Lm)*duty*Ts
