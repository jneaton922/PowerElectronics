clear all
clc

%given inputs
N = 1/2;
Vg = 48;
V = 12;
Pout = 150;
fsw = 100e3;
Lm = 250e-6;


% calcs     
Ts = 1/fsw;
C = 100e-6;

D = V/(V + N*Vg);
Ipeak = Vg/Lm * D * Ts;
Iout = Vg * (D*(Ipeak/2)/V);

R = V/ Iout;
