clear all
close all
clc

% Power Train Parameters

Vg=48;
n=0.5;
L=250e-6;
C=100e-6;
R=5;
fs=200e3;
D=0.3;
Dprime = 1-D;

% Calculations and DC operating point

Ts=1/fs;
V = D*Vg*n/Dprime;
IL = n*V/Dprime/R;
Iout = V/R;
Pout = Iout^2*R;
% Impedance
s=tf('s');
ZN = (s*L*n*IL-Dprime*(Vg*n+V))/(D*n*IL);
ZD =  (s^2*L*n^2*R*C+s*L*n^2+R-2*D*R+D^2*R)/(D^2*n^2*(s*C*R+1));

opts = bodeoptions('cstprefs');
opts.PhaseVisible = 'off';
opts.FreqUnits = 'Hz';

% Filter design
G = 10^(-100/20);
ff = sqrt(G)*fs;
Cf = 3*47e-6;
Lf = 1/(ff^2)/4/pi/pi/Cf;
Zomm = (10^(14.7/20))*0.3;
Rof = sqrt(Lf/Cf);

nf= ((Rof^2)/(Zomm^2))*(1+sqrt(1+4*(Zomm^2)/(Rof^2)));
Cb = nf*Cf;
Rf = Rof*sqrt( (2+nf)*(4+3*nf)/(2*nf^2*(4+nf)) );

Zcf = 1/s/Cf;
Zdamp = Rf+1/s/Cb;
Zparallel = Zcf*Zdamp/(Zdamp+Zcf);
Zinductor = s*Lf;
Zout = Zinductor*Zparallel/(Zinductor+Zparallel);
Htransfer_unfilt = Zcf/(Zcf+Zinductor);
Htransfer_filt = Zparallel/(Zparallel+Zinductor);

figure()
bode(ZN,'r',opts)
hold on
bode(ZD,'b',opts)
title('Impedance Plots')
hold on
bode(Zout,'m')

