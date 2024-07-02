clear all, close all

s = tf('s')

Gp = -0.65/(s^3+4*s^2+1.75*s);

A = 9;
Tp = 1;

damp(Gp)

%un polo nell'origine
Kf = dcgain(s*Gp)

figure, bode(Gp)
figure, nyquist(Gp)

Kc = -1.5;

Ga1 = Kc*A*Gp;

wc_des = 1.89;

figure, bode(Ga1)
[m_wc_des, f_wc_des] = bode(Ga1, wc_des)

%metto due reti anticipatrici da 4 per aumentare fase di 70 gradi
md = 4;
xd = 1.5;
taud = xd/wc_des;

Rd = (1+taud*s)/(1+taud/md*s);

Ga2 = Ga1*Rd^2;

figure, bode(Ga2)
[m_wc_des, f_wc_des] = bode(Ga2, wc_des)

%ora metto rete attenuatrice per far scendere modulo di 1.7 unità naturali

mi = 1.7;
figure, bode((1+1/mi*s)/(1+s));
xi = 17.8;
taui = xi/wc_des;

Ri = (1+taui/mi*s)/(1+taui*s);

Ga3 = Ga2*Ri;

margin(Ga3);

%chiudo l'anello

C = Kc*Rd^2*Ri;
Ga = A*Gp;

W = feedback(Ga*C, 1/Tp);
figure, bode(W)
figure, step(W)

Ap = 1e-3;
Omegap = 30;
Wu = feedback(C, A*Gp*Tp);
[mu, fu] = bode(Wu, Omegap);
Udp = Ap*mu