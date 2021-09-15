clear all
close all
clc

% Input Parameters

power = ;    % Converter output power
Vout=;       % Converter output voltage
VD = ;       % Device Blocking Voltage
VGS = ;       % Peak applied Gate Voltage
RG = ;        % Gate resistance
IDONmax = ;       % Peak Main switch current at maximum power 
k = 3.0139;      % Device Transconductance
VTh = 5.4239;    % Device Threshold voltage
trr = ;    % Diode Reverse Recovery Time
Irr = ;        % diode peak reverse current during reverse recovery
fsw = ;    % Switching Frequency
di = ;         % Inductor Current Ripple 
Rdson = ;    % MOSFET ON State Resistance
Rindesr = ; % Equivalent series resistance of inductor
von = ;      % Free Wheel Diode on state voltage
D = ;       % Converter Duty cycle

% Discritize the nonlinear device capacitance vs. device voltage curves
% from the onstate voltage (VDon) up to including the blocking voltage (VD) as the
% final point from datasheet

voltage = [1.0000 1.2553 2.0066 3.0303 4.0266 5.1272 6.0807 7.0094 8.1956 9.0529 10.1431 12.5535 13.4781 14.6780 15.9847 17.6569 20.0664 23.4623 30.3027 39.6977 50.5480 59.1024 69.1045 80.7993 91.8254 102.8830 120];

Coss=1e3*[1.2192 1.1297 1.0132 0.7912 0.6671 0.5771 0.5210 0.4784 0.4355 0.4103 0.3832 0.3372 0.3232 0.3070 0.2917 0.2748 0.2545 0.2317 0.1987 0.1690 0.1462 0.1331 0.1212 0.1103 0.1022 0.0955 0.0870]*10^-12;
Ciss=1e3*[1.3103 1.2809 1.2201 1.1667 1.1299 1.0986 1.0765 1.0581 1.0379 1.0250 1.0103 0.9827 0.9735 0.9624 0.9514 0.9385 0.9219 0.9017 0.9256 0.9256 0.9256 0.9256 0.9256 0.9256 0.9256 0.9256 0.9256]*10^-12;
Crss=[511.2220 473.6930 417.9731 308.7202 250.5113 209.7467 185.0338 166.6793 148.5851 138.1078 127.0345 108.6088 103.0813 96.8182 90.9357 84.5230 76.9382 68.5859 56.8288 46.5977 39.0153 34.7798 31.0042 27.6384 25.1582 23.1411 20.6661]*10^-12;


% Rectifier capacitance - use same voltage points used from mosfet curves
Cj = [236.5200  214.0512  174.2158  145.3770  128.3216  115.4065  107.0810  100.6037   93.9303 89.9162   85.5380   77.8951   75.5024   72.7279   70.0554   67.0614   63.3992   59.1937 52.9051   46.9905   42.2612   39.4578   36.8404   34.3966   32.5183   30.9349   28.9139]*10^-12;


% Calculate MOSFET equivalent capacitances
Cgd = ;
Cgs = ;
Cds = ;

% Loop current to calculate losses as a function of device current
current = linspace(1,IDONmax,10);

for loop=1:length(current) % Begin Loop
    
    IDON = current(loop);

% Calculate Miller Capacitance
Vmiller = ;

% Calcualte trajectory times

tdon = ;
tdoff = ;
tr = ;
tf = ;

% Calcualte voltage fall time 
tfu = ;
tru = ;

% Calculate Cross over Energy Loss
Won = ;
Woff = ;

% Calculate CV^2 Loss

Cosser = ;
Cjer = ;
Wc = ;

% Calculate recovery loss
Qrr = ;
Wrr = ;

% Calculate total switching loss
Wmsw = Won+Woff+Wrr+Wc;
pswavg = ;

% Calculate Conduction Loss
pcavg = ;
pcdiode = ;

% Calculate Conduction Loss of Inductor
Iindrms = ;
pindcopper = ;
pcore = pindcopper;

% Total loss
ploss(loop) = pcdiode+pcavg+pswavg+pindcopper+pcore;

% Efficiency
iout(loop) = ; % Map IDON to iout
power(loop) = iout(loop)*Vout;
eff(loop) = power(loop)/( power(loop) + ploss(loop) );

end            % End Loop

figure()
hold on
grid on
plot(current,ploss,'b','LineWidth',2)
xlabel('Load Current (A)')
ylabel('Loss (W)')
title('Total Conduction+Switching Loss')

figure()
hold on
grid on
plot(power,eff,'r','LineWidth',2)
xlabel('Load Power (W)')
ylabel('Converter Efficiency')
title('Converter Efficiency vs. Load Power')

