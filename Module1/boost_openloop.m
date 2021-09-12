close all
clear all
clc

% Input Parameters
Vg = 48;
V = 120;
Pout = 500;
fsw = 100e3;

% Calculations
Ts = 1/fsw;
iout = Pout/V;
D = 1 - (Vg/V);
Dprime = 1-D;
R = Pout/(iout^2);
IL = V/(Dprime*R);

deltaiL = 0.02*IL; 
L =  ( (Vg/2)*D*Ts ) /deltaiL;


deltaV = 0.1;
C = ((V/(2*R))*D*Ts)/deltaV;

devicerms = IL*sqrt(D)*sqrt(1+(1/3)*((deltaiL/IL)^2))
deviceon = 0.125*IL
diodecurrentavg = Dprime*IL


