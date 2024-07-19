clear all, close all

s = tf('s')

Kr = 1

F1 = 5/s
F2 = (s+20)/((s+1)*(s+5)^2)

F = F1*F2;

Kf1 = dcgain(F1)
Kf2 = dcgain(F2)

Kf = dcgain(s*F)

figure, bode(F)
figure, nyquist(F)

Kc = 5;
wc_des = 1.89;

Ga1 = Kc*F
[m_wc_des, f_wc_des] = bode(Ga1, wc_des)


%recupero 60 gradi con due reti da 3

md = 3;
xd = sqrt(md);
taud = xd/wc_des

Rd = (1+taud*s)/(1+taud/md*s)

Ga2 = Ga1*Rd^2

[m_wc_des, f_wc_des] = bode(Ga2, wc_des)

%perdo 13 di modulo con rete attenuatrice

mi = 13.05

figure, bode((1+1/mi*s)/(1+s))

xi = 375
taui = xi/wc_des

Ri = (1+taui/mi*s)/(1+taui*s)

Ga3 = Ga2*Ri

margin(Ga3)

C = Kc*Rd^2*Ri
Ga = C*F

W = feedback(Ga, 1)

figure, bode(W)
figure, step(W)