


clear all; 
clc 
close all;

[Sac1,Fs] = audioread('Filename.wav');
% [Sac2,Fs] = audioread('Syac_8KHz_M004_P002_ch1_1_1.wav');
% [Sac3,Fs] = audioread('Syac_8KHz_M001_P003_ch1_1_1.wav');
% [Sac4,Fs] = audioread('Syac_8KHz_M001_P004_ch1_1_1.wav');
% [Sac5,Fs] = audioread('Syac_8KHz_M001_P005_ch1_1_1.wav');
%% Synthetic BC speech generation from synsthtic AC speech by lowpass of IIR filter
a=[1 -0.80];
b=0.30;
%[ac,Fs]= audioread('8KHz_M001_P001_ch1_1_1.wav');
Bc1=filter(b,a,Sac1);
% Bc2=filter(b,a,Sac2);
% Bc3=filter(b,a,Sac3);
% Bc4=filter(b,a,Sac4);
% Bc5=filter(b,a,Sac5);

audiowrite('Filename.wav',Bc1,Fs);
% audiowrite('BC_Sac2_8KHz_M004_P002_ch1_1_1.wav',Bc2,Fs);
% audiowrite('BC_Sac3_8KHz_M001_P003_ch1_1_1.wav',Bc3,Fs);
% audiowrite('BC_Sac4_8KHz_M001_P004_ch1_1_1.wav',Bc4,Fs);
% audiowrite('BC_Sac5_8KHz_M001_P005_ch1_1_1.wav',Bc5,Fs);  


