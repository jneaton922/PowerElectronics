clear all
close all
clc

% given parameters
Vg = 48;
V = -15;
fsw = 200e3;
Vref = 5;
Vm = 3;

L = 50e-6;
C = 220e-6;
R = 5;

% V = DVg/(1-D)
% V - VD = DVg
% V = D(Vg+V)
% (V/Vg+V) = D
D =  -V/(V+Vg);
Dprime = 1 - D;


s = tf('s');

% small-signal tf salient features
Ggo = -D/Dprime;
Gdo = V/(D*Dprime^2);
wo = Dprime/sqrt(L*C);
Q = Dprime*R*sqrt(C/L);
wz = ( Dprime^2 * R ) / ( D*L );

% transfer functions

    denom = 1 + (s/(Q*wo)) + (s/wo)^2;
    % control to output
    Gvd = Gdo * ( 1 - s/wz ) / denom;

    %line to output
    Gvg = Ggo / denom;

    % lpf/ sensor gain
    Ho = Vref/V;
    wf = 2*pi*(fsw/2.5);
    H = Ho; % /(1+ (s/wf));

% compensator design

Gco = 153;
wz1 = 5.56e3;
wz2 = 1.13e3;
Gc = Gco * (1 + s/wz1)*(1+ s/wz2)/ (s * (1+s/wf));



% closed loop functions

T = Gvd * Gc * H * (1/Vm);

figure();
h1 = subplot(211);
bode(T/Gc);
hold on;
h2 = subplot(212);
bode(Gc);

vtovref = (1/H) * (T/(1+T));


figure();
h1 = subplot(211);
bode(T);
hold on;
h2 = subplot(212);
bode(T/(1+T));
