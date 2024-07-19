clear all, close all

s = tf('s')

F1 = (s+40)/(s+2)
F2 = 80/(s^2+13*s+256)

F = F1*F2

Kr = 1

damp(F)

Kf1 = dcgain(F1)
Kf2 = dcgain(F2)

Kf = dcgain(F)

figure, bode(F)

Kc = 4

wc_des = 9.45

Ga1 = Kc/s*F
[m_wc_des, f_wc_des] = bode(Ga1, wc_des)

%devo recuperare 60 gradi --> metto due reti derivative da 3

md = 4;
taud = sqrt(3)/wc_des;

Rd = (1+taud*s)/(1+taud/md*s)

Ga2 = Ga1*Rd^2

[m_wc_des, f_wc_des] = bode(Ga2, wc_des)

%devo far scendere il modulo di 2.08 unita naturali

mi = 2.34
figure, bode((1+1/mi*s)/(1+s))

xi = 60
taui = xi/wc_des

Ri = (1+taui/mi*s)/(1+s*taui)

Ga3 = Ga2*Ri

margin(Ga3)

C = Kc/s*Rd^2*Ri
Ga = C*F

W = feedback(Ga, Kr)

figure, bode(W)
figure, step(W)