clear all, close all

s = tf('s')

F1 = 30/(s+15);
F2 = (3*s+3)/(s^3+10*s^2+24*s);

F = F1*F2;

damp(F)
Kf = dcgain(s*F)
Kr = 1

figure, bode(F);
figure, nyquist(F);

Kc = 40;

Ga1 = Kc*Kr*F;

wc_des = 12.6;

figure, bode(Ga1)
[m_wc_des, f_wc_des] = bode(Ga1, wc_des)

%rete anticipatrice per recuperare 55 gradi

taud = 0.25
md = 10

Rd = (1+taud*s)/(1+(taud/md)*s)

Ga2 = Ga1*Rd

[m_wc_des2, f_wc_des2] = bode(Ga2, wc_des)

%rete attenuatrice per perdere il modulo

mi = 3.15

figure, bode((1+1/mi*s)/(1+s))