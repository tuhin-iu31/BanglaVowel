clear all; clc; close all;
m =12; N=1024;
%[T,Fa] = audioread('M1_AC_Crop_8KHz_µ-law _P01.wav'); %True AC
[SAc,Fa] = audioread('Syac_8KHz_AC_M1_P006.wav');  %Syn AC
[SBc,Fa] = audioread('BC_Syac_8KHz_AC_M1_P006.wav');  %Syn BC 
%% True spectrum estimation from synthetic AC speech (source filter model)
% [M1, sigma1] = armcov(T,m);  %Synthetic AC for true apectrum
% [Msac, w1] = freqz(sqrt(sigma1), M1,N/2,Fa);  
% Msac=abs(Msac);
%% Estimated Spectrum by ACM for Syn AC
[AutoAC, sigma2] = lpc(SAc,m);
[ACM1, w2] = freqz(sqrt(sigma2), AutoAC,N/2,Fa);  
ACM1=abs(ACM1);
%% Estimated Spectrum by ACM for Syn BC
[AutoBC, sigma3] = lpc(SBc,m);
[ACM2, w3] = freqz(sqrt(sigma3), AutoBC,N/2,Fa);  
ACM2=abs(ACM2);

%%
[s1,Fa] = audioread('Syac_8KHz_AC_M1_P006.wav'); 

x1=s1; 
s1=s1(500:900-1);
figure
L=length(s1);
XB=fft(s1,N); 
XB_Power=abs(XB).^2;
XB_pspect=XB_Power./L;
xticks=[0:Fa/N:Fa/2-1];  
plot(xticks,8.5*log10(XB_pspect(1:N/2)),'g');

%%
[s2,Fa] = audioread('BC_Syac_8KHz_AC_M1_P006.wav'); %Synthetic BC
s2=s2(500:900-1);
L=length(s2);
XB=fft(s2,N); 
XB_Power=abs(XB).^2;
XB_pspect=XB_Power./L;
xticks=[0:Fa/N:Fa/2-1];  
hold on
plot(xticks,8.5*log10(XB_pspect(1:N/2)),'r');
hold on

plot(xticks,20*log10(ACM1)+4,'k'); % ACR for Syn AC
plot(xticks,20*log10(ACM2)+12,'b'); % ACR for syn BC
%grid on
%legend('Synthetic AC Speech','Synthetic BC Speech');
legend('Synthetic AC Speech','Synthetic BC Speech','Spectrum envelope [Synthetic AC]','Spectrum envelope [Synthetic BC]');
xlabel('Frequency [Hz]', 'FontSize', 14,'Color','k'); ylabel('Magnitude [dB]', 'FontSize', 14,'Color','k')