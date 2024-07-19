clear all, close all

s = tf('s')

A = 9
Gp = -0.65/(s^3+4*s^2+1.75*s);

damp(Gp)

KGp = dcgain(s*Gp)

F = A*Gp;

Kf = dcgain(s*F)

figure, bode(F)
figure, nyquist(F)
axis equal

Kc = -1.5

wc_des = 1.89

Ga1 = Kc*F

figure, bode(Ga1)
[m_wc_des, f_wc_des] = bode(Ga1, wc_des)

%devo recuperare 60 gradi, uso due reti attenuatrici da 3 nel max

xd = 1.73
taud = xd/wc_des
md = 3

Rd = (1+taud*s)/(1+taud/md*s)

Ga2 = Ga1*Rd^2

[m_wc_des, f_wc_des] = bode(Ga2, wc_des)

%metto reti attenuatrici in modo da perdere 1.78 
mi = 1.789

figure, bode((1+1/mi*s)/(1+s))

xi = 50;
taui = xi/wc_des

Ri = (1+taui/mi*s)/(1+taui*s)

Ga3 = Ga2*Ri

margin(Ga3)

C = Kc*Rd^2*Ri
Ga = F

W = feedback(C*F, 1);

figure, bode(W)
figure, step(W)

We = feedback(1, Kc*9*Ga*C)
[mu, fu] = bode(We, 30)
u_max = 9*mu

