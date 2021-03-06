

Vg = 28;        % input voltage
Pout = 100;     % output power
V = 12;         % outpout voltage
Rg = 140e-3;
fsw = 100e3;

Ts = 1/fsw;
Iout = Pout/V;

D = (V)/(Vg-(Iout*Rg))

vrip = 0.1;
irip = 0.05*Iout;

Rl = V/Iout;

L = ((Vg - V) / (2*irip)) * D * Ts;

C = ( irip * Ts ) / (8 * vrip);

