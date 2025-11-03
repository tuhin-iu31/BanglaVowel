clc
clear all
close all
[s1,Fa] = audioread('Syac_8KHz_AC_M1_P012.wav'); % syn AC
[s2,Fa] = audioread('BC_Syac_8KHz_AC_M1_P012.wav'); % syn BC

x2=s2;
x1=s1;
%%
m =12;
[X3,acm1] = corrmtx(s1,m, 'autocorrelation'); % Syn AC by acm
[X4,acm2] = corrmtx(s2,m, 'autocorrelation'); % Syn BC by acm

%%
N=20;

e3=eig(acm1);
Emax=max(e3);
Emin=min(e3);
cs3=Emax/Emin;
AC_ACR=N*log10(cs3);% mc

e4=eig(acm2);
Emax=max(e4);
Emin=min(e4);
cs4=Emax/Emin;
BC_ACR=N*log10(cs4);% 

%
