clear all
close all
clc

% Control Design of a Boost converter
% Converter Parameters
power = 500;
Vg = 170;
V = 350;
fs = 100e3;
iripple = 0.2; % percentage
vripple = 0.1; % volts
Vm = 2; % peak to peak of PWM ramp

% Calculations
Ts = 1/fs;
Iout = power/V;
R = V/Iout;
dprime = Vg/V;
D = 1-dprime
IL = Vg/(R*dprime^2);
diL = iripple*IL;
Lout = Vg*D*Ts/(2*diL);
Cout = V*D*Ts/(2*R*vripple);

% Define open loop transfer functions - Table 8.2 From Erickson
s=tf('s');
Ggo = 1/dprime;
Gdo = V/dprime;
wo = dprime/(sqrt(Lout*Cout));
Q = dprime*R*sqrt(Cout/Lout);
wz = (dprime^2)*R/Lout;

% control to output
Gvd = Gdo*(1-s/wz)/( 1 + s/Q/wo + (s/wo)^2 );
% Line to output
Gvg = Ggo*1/( 1 + s/Q/wo + (s/wo)^2 );

% Low Pass sensor filter 
wf = 2*pi*(fs/10);
H = 1/(1+s/wf);

% Compensator
Gc = 34.14*(1+0.00028*s)*(1+0.0004*s)/( s*(1+4.5e-6*s));

% Define open Loop Gain
T = Gvd*Gc*H*(1/Vm);

% Closed Loop Transfer functions

vtovref = (1/H)*(T/(1+T));
figure()
bode(vtovref)

vtovg = Gvg/(1+T);
figure()
bode(vtovg)





