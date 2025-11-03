
%%Synthetic AC speech generation 
clc
clear all
close all
[s1,Fa] = audioread('8KHz_M001_P001_ch1_1_1.wav'); %  true AC
% [s2,Fa] = audioread('8KHz_M004_P002_ch1_1_1.wav'); %  true AC
% [s3,Fa] = audioread('8KHz_M001_P003_ch1_1_1.wav'); %  true AC
% [s4,Fa] = audioread('8KHz_M001_P004_ch1_1_1.wav'); %  true AC
% [s5,Fa] = audioread('8KHz_M001_P005_ch1_1_1.wav'); %  true AC
x1=s1; x2=s2; x3=s3; x4=s4;x5=s5; figure(1); plot(s1);
 s1=s1(3800:4200-1);s2=s2(3600:4000-1);  s3=s3(2600:3000-1);s4=s4(3400:3800-1); s5=s5(2700:3100-1);
 %s1=s1(3300:4600-1);s2=s2(3500:4800-1);  s3=s3(2200:3600-1);s4=s4(3000:4400-1); s5=s5(2200:3600-1);
 m =12; N=1024;
[mc1, sigma1] = armcov(s1,m);  %  true AC used here  for Ck value 
% [mc2, sigma2] = armcov(s2,m);
% [mc3, sigma3] = armcov(s3,m);
% [mc4, sigma4] = armcov(s4,m);
% [mc5, sigma5] = armcov(s5,m);
G=sqrt(sigma1)+sqrt(sigma2)+sqrt(sigma3)+sqrt(sigma4)+sqrt(sigma5)

n=length(mc1);
e=zeros(80,1);
e(1)=1;
e1=repmat(e,100,1);
ek=e1(1:1024);
Sac=filter(0.1354,mc3,ek); %% ck (mc ) from true AC is used here 
audiowrite('Syac_8KHz_M001_P001_ch1_1_1.wav',Sac,Fa); 
%%
[Sac,Fa] = audioread('Syac_8KHz_M001_P001_ch1_1_1.wav');
[M, sigma6] = armcov(Sac,m);              % ck (M) is estimated from sythetic Ac
[Msac, w1] = freqz(sqrt(sigma6), M,N/2,Fa); % Ck from sythetic AC is used to generate true spectrum Msac
[Mtac, w2] = freqz(sqrt(sigma3), mc3,N/2,Fa);
Msac=abs(Msac); Mtac=abs(Mtac);
%%
figure
L=length(s1);
XB=fft(s3,N); 
XB_Power=abs(XB).^2;
XB_pspect=XB_Power./L;
xticks=[0:Fa/N:Fa/2-1];  
plot(xticks,10*log10(XB_pspect(1:N/2)),'g');
hold on
 %%
plot(xticks,20*log10(Msac));
plot(xticks,20*log10(Mtac));
legend('FFT spectrum','Synthetic AC',' True AC');


