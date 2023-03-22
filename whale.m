clc;
clear;
close all;

[x,fs] = audioread('bluewhale.au');
t = 1/fs;
L = length(x);

x_f = bandpass(x, [49,53],fs);

y = fft(x);
P2 = abs(y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(L/2))/L;
plot(f,P1);
xlim([0,100]);

figure();
y = fft(x_f);
P2 = abs(y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(L/2))/L;
plot(f,P1)
xlim([0,100])
