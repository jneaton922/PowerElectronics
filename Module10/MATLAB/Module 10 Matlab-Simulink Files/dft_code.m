clear all
close all
clc

% File to run DFT on time domain signals for Power Electronics Analysis

% Buck Converter inputs

Vg=48;
V=12;
Pout=500;
fsw = 100e3;

% Calculations
Tsw=1/fsw;
Iout = Pout/V;
Rout = V/Iout;
D = V/Vg;
IL = Iout;

% Approximate ig(t) using fourier series. Or you can import time domain
% from simulink result

dT = Tsw/1000;               % Determine sample step size 1000 samples within a switching cycle
fsamplefreq = 1/dT;          % Sample frequency. DON'T confuse with switching frequency
t=[-Tsw/2:dT:Tsw/2-dT]';     % time vector Leave off one sample point from end (this is why -dT)
k=linspace(1,1000,1000)';    % Fourier series counter
n=1;
w=2*pi*fsw;
sumterm = 0;

ig_t=zeros(size(t));

for m=1:length(t)
    for n=1:length(k)
        sumterm = sumterm+(2*Iout/k(n)/pi)*sin(k(n)*pi*D)*cos(k(n)*w*t(m,1));
    end
    ig_t(m,1) = D*IL+sumterm;
    sumterm = 0;
    
end

%ig_t=10*sin(w*t)+5*sin(6*w*t); % test signal

% Plot DFT of signal

IG_T=fft(ig_t);                                 % Take DFT of time domain signal
lengthdft = length(IG_T);                       % Calculate size of DFT result
f = (0:lengthdft-1)*fsamplefreq/lengthdft;      % Map DFT bins to frequency map
ffmag = abs(IG_T/lengthdft);                    % Calcualte magnitude of DFT result "2 sided"

% Redefine vectors only to the nyquist frequency (1/2 x fsamplefreq)
newlength = 0.5*lengthdft+1;
f=f(1:newlength);
ffmag = ffmag(1:newlength);                     % Single sided DFT result
ffmag(2:end-1) = 2*ffmag(2:end-1);              % Scale magnitude for a single sided DFT


% Plot Results

subplot(2,1,1)
plot(t,ig_t)
xlabel('Time (s)')
ylabel('Amplitude (A)')
title('Time Domain Signal')
subplot(2,1,2)
plot(f,ffmag,'r')
xlabel('Frequency (Hz)')
ylabel('Normalized Magnitude')
title('Frequency Domain Signal ')
