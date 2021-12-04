close all
clear all
clc

target_Q = 1;
target_THD = 0.01;
fo_fl = 18;
fl = 50;
vin_rms = 230;
R = 40;

%fo/fl = 18
fo = fo_fl * fl;

%Q = R/Ro
Ro = R/target_Q;

% Ro = sqrt(L/C)
L_C = Ro^2;

%fp = 1/2pirc, fp=fo/Q
% fp2pirc = 1
C = 1/(fo*2*pi*R);

L = L_C * C;