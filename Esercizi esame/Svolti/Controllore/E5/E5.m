clear all, close all

s = tf('s')

Kr = 1

F1 = (1+s/0.1)/((1+s/0.2)*(1+s/10))
F2 = 1/s

F = F1*F2

damp(F1)
damp(F2)

Kf1 = dcgain(F1)
Kf2 = dcgain(s*F2)

Kf = dcgain(s*F)

figure, bode(F/s)
figure, nyquist(F/s)

Kc = 6.25

wc_des = 2.52;

Ga1 = Kc/s*F

[m_wc_des, f_wc_des] = bode(Ga1, wc_des)

%piazzo 2 reti derivative per recuperare 60 gradi 

md1 = 3;
xd1 = sqrt(md1)
taud1 = xd1/wc_des

Rd1 = (1+taud1*s)/(1+taud1/md1*s)


md2 = 4;
xd2 = 2
taud2 = xd2/wc_des

Rd2 = (1+taud2*s)/(1+taud2/md2*s)

Ga2 = Ga1*Rd2*Rd2

[m_wc_des, f_wc_des] = bode(Ga2, wc_des)

%faccio scendere il modulo di 4.52 con rete attenuatrice

mi = 7.6

figure, bode((1+1/mi*s)/(1+s))

xi = 300
taui = xi/wc_des

Ri = (1+taui/mi*s)/(1+taui*s)

Ga3 = Ga2*Ri

margin(Ga3)

C = Kc/s*Rd1*Rd2*Ri
Ga = F*C

W = feedback(Ga, Kr)

figure, bode(W)
figure, step(W)