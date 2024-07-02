clear all, close all

s = tf('s');

F = 5*(1+s/4)/((1+s)^2*(1+s/16)^2)

[Gm, Pm, Wcg, Wcp] = margin(F) %Gm margine di guadagno, Wcg pulsazione a cui si legge il margine di guadagno
Kpmax = Gm
T = 2*pi/Wcg %periodo di oscillazione che otterrei sull'uscita

%Metodo di Ziegere Nichols, F deve avere margine di guadagno finito per
%poter essere applicato
Kp = 0.6*Kpmax;
Ti = 0.5*T;
Td = 0.125*T;

N = 10;
pc = N/Td %polo di chiusura
Rpid = Kp*(1+1/(Ti*s)+Td*s/(1+Td/N*s));
Ga = Rpid*F;
figure, margin(Ga)
[Gma, Pma, Wcga, Wcpa] = margin(Ga)
W_ZNcc = feedback(Rpid*F, 1)
figure, step(W_ZNcc)

%meotodo taratura ad anello aperto. necessario avere sist asint. stabile e
%deve avere una risposta al gradino motonona.
figure, step(F)
Kf = 5;
thetaf = 0.24;
tauf = 1.76;
Fapp = Kf/(1+tauf*s)*exp(-thetaf*s);

Tmax = 12;

figure, step(F, Tmax)
hold on
step(Fapp, Tmax) %guardo se la mia Fapp approssima bene La mia F, se si sono autorizzato ad andare avanti con i valori che ho scelto
grid on 
hold off

Kp = 1.2*tauf/(Kf*thetaf);
Ti = 2*thetaf;
Td = 0.5*thetaf;

pc = -N/Td;
Rpid = Kp*(1+1/(Ti*s)+Td*s/(1+Td*s/N));
Ga = Rpid*F;

figure, margin(Ga)
[Gma, Pma, Wcga, Wcpa] = margin(Ga)
W_ZNca = feedback(Rpid*F, 1)
figure, step(W_ZNca)