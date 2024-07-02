clear all, close all 

s = tf('s')

Kr = 1;

F1 = (s+12)/(s+4);
F2 = 2*(s+5)/(s*(s^2+7.2*s+16));

damp(F1)
damp(F2)

dcgain(F1)
dcgain(s*F2)

bode(F1*F2), grid on

Kc = 17;
Ga1 = Kc*F1*F2;

wc_des = 30;
%bode(Ga1), grid on
[m_wc_des, f_wc_des] = bode(Ga1, wc_des);

md = 4;
xd = 2;
taud = xd/wc_des;

Rd = (1+taud*s)/(1+taud/md*s);
Ga2 = Ga1*Rd^2;

[m2, f2] = bode(Ga2, wc_des)

Kcorr = 8;
Ga3 = Ga2*Kcorr;
figure, margin(Ga3)

C = Kc*Kcorr*Rd^2;
W = feedback(C*F1*F2,1)*Kr;
sens = feedback(1, Ga3);
figure, bode(sens);
[ms, fs] = bode(sens, 20)
figure, bode(W)


figure, step(W)

wb = 67.7;
T = 2*pi/(20*wb);
t = 0.004;
Gazoh = Ga3/(1+T/2*s);

margin(Ga3);

Cz1 = c2d(C, T, 'tustin');
Cz2 = c2d(C, T, 'zoh');
Cz3 = c2d(C, T, 'match');
