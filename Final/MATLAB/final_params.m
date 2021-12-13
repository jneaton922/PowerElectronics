close all
clc

% GIVEN PARAMETERS
    
    % flyback
    np = 7; n1 = 2;
    Lmag = 106e-6;
    fsw = 100e3;
    Ts = 1/fsw;
    
    % input filter
    Lfilt = 10.2e-3;
    Cfilt = 1.1e-6;
    
    % buck converter
    V = 5;
    D_max_buck = 0.98;
    eff_target = 0.9;
    Pout = 150;
    Pload = Pout/eff_target;

Vin_rms = 120;
freq_in = 60;
flyback_V = 48;
THD_target = 0.01; 
   

% calcs

Vg = Vin_rms*sqrt(2); % full wave rectifier

Idiode_rms = 7.51;
Idiode_avg = 3.55;
Imain_rms = 2.32;
Imain_avg = 1.28;
Rdson = 100e-3;
diode_Vf = 0.8;

cond_loss_fet = (Imain_rms^2) * Rdson;
cond_loss_diode = (Idiode_avg)*diode_Vf;


% flyback calcs
Vin = Vg;
V_interm = 48;
n = n1/np;
% (V/Vg) = n(D/Dp)
D_flyback = (V_interm)/(n*Vg + V_interm);
D_notes_peak = 1 / ( ((Vg*n1)/(V_interm*n1)) +1);


D_ss = ( 2 * sqrt((Lmag*Pload)/(Ts)) ) / Vin;


% filter Q
Re = (2*Lmag)/((D_ss^2)*Ts);
Q_filt = Re*sqrt(Cfilt/Lfilt);

diode_block = V_interm - (Vg*n);

Rload = (V^2)/Pout;
D_buck = V/V_interm;
Zn_buck = -(Rload/D_buck^2);

Gvd_mag = 20;

v_perturb = 10^(Gvd_mag/20);
vmax = V_interm + v_perturb;

% storage Cap
t_hold = (1/freq_in) * 3; % 3 line cycles

Vin_min = V/D_max_buck;

% Pload = E/t = (1/2)Cstorage(V1^2 - V2^2)/t_hold
C_storage = 2*Pload*t_hold/(V_interm^2 - Vin_min^2);

% control loop design
Vref = 2.5;
Vm = 2;
s = tf('s');
Ho = Vref/V_interm;
w_lpf = (1/10)*fsw*2*pi;

Htf = Ho*(w_lpf)/(s+w_lpf);



Gco = 10;
% ki(skp/ki + 1) /s
wz = 1/0.076;
ki = Gco;
kp = (1/wz)*ki;

Gc = ki*(1+(kp/ki)*s) / s;


bode(gvd*Gc*Htf);
h=gcr;
setoptions(h,'FreqUnits','Hz');
