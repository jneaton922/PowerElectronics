
% GIVEN PARAMETERS
    
    % flyback
    n1 = 7; n2 = 2;
    Lmag = 106e-6;
    fsw = 100e3;
    
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
n = n2/n1;
% (V/Vg) = n(D/Dp)
D_flyback = (V_interm)/(n*Vg + V_interm);
D_notes_peak = 1 / ( ((Vg*n2)/(V_interm*n1)) +1);

D_ss = ( 2 * sqrt((Lmag*Pload)/Ts) ) / 170;

% filter Q
Ts = 1/fsw;
Re = (2*Lmag)/((D_ss^2)*Ts);
Q_filt = Re*sqrt(Cfilt/Lfilt);

diode_block = V_interm - (Vg*n);

Rload = (V^2)/Pout;
D_buck = V/V_interm;
Zn_buck = -(Rload/D_buck^2);

Gvd_mag = 20;

v_perturb = 10^(Gvd_mag/20);
vmax = V_interm + v_perturb;