

Vg = 28;        % input voltage
Pout = 100;     % output power
V = 12;         % outpout voltage
Rg = 140e-3;
fsw = 100e3;

D = V/Vg;

Ts = 1/fsw;
Iout = Pout/V;

vrip = 0.1;
irip = 0.05*Iout;

Rl = V/Iout;

L = (Vg*D*Ts)/(2*irip);

C = (Vg*D*D*Ts)/(2*(1-D)*Rl*vrip);

