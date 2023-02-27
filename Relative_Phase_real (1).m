clc;
clear;
close all;

Fs = 44100;
T = 1/Fs;
f = 17000;
seg_length = 5000;

d=0.11;

[R1r,Fs1] = audioread('DMT_14_T1_17kHz.wav');
[R2r,Fs2] = audioread('DMT_14_T2_17kHz.wav');
    
R1 = bandpass(R1r,[14000 20000],Fs);
R2 = bandpass(R2r,[14000 20000],Fs);

seg_num=floor(length(R1)/5000);
R1m = zeros(seg_num,seg_length);
R2m = zeros(seg_num,seg_length);

phi_hat = zeros(1,seg_num);
theta_AoA = zeros(1,seg_num);
phase_diff = zeros(1,seg_num);

for i=1:seg_num*seg_length
    R1m(i) = R1(i);
    R2m(i) = R2(i);
end

for i = 1:seg_num
    phi_hat(i) = angle(mean(hilbert(R2m(i,:))./hilbert(R1m(i,:))));
    theta_AoA(i) = asin((phi_hat(i)*(343/f)/2)/d);  % d << 11cm
    phase_diff(i)=rad2deg(phi_hat(i));
end

plot(phase_diff)%need a better plot

