clear all
close all
clc

% Buck Parameters
Vg=28;
Pout=100;
V=12;
Rg=.14*0;
fs=100e3;
deltav = 0.1;

%Calcs
Ts=1/fs;
iout = Pout/V;
R=V/iout;
IL = V/R
deltaiL = .05*IL;
duty = V/(Vg-IL*Rg)
Lout = (Vg-IL*Rg-V)*duty*Ts/(2*deltaiL)
Cout = deltaiL*Ts/(8*deltav)

% DC operating point
D=duty;
IL=IL;
C = Cout;
L = Lout;

