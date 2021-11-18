%clear all
%close all
clc

% File to run DFT on time domain signals for Power Electronics Analysis Set
% up to import data from simulink
%% Fill in the inputs here!

dT = Ts/1000;                      % Sample time from fixed step simulation
steady_state_time = 10e-3;     % Define steady state time
tend = 20e-3;                    % Simulation end time
ig_t = out.iin_filter;                     % ig_t is the input variable from the workspace

%%
ig_t = ig_t(steady_state_time/dT:end-1);     % Pulling out steady state result only
% time vector
t=[dT*(steady_state_time/dT-1):dT:tend-dT];       % Recreated 

% Plot DFT of signal
fsamplefreq = 1/dT;
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
hold on
plot(t,ig_t,'r')
xlabel('Time (s)')
ylabel('Amplitude (A)')
title('Time Domain Signal')
subplot(2,1,2)
hold on
plot(f,ffmag,'b')
xlabel('Frequency (Hz)')
ylabel('Normalized Magnitude')
title('Frequency Domain Signal ')
