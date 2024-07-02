clear all, close all

s = tf('s')

F = (s+10)/(s^3+45*s^2-250*s);
zero(F)
damp(F)

kf = dcgain(s*F)
Kr = 2;
Kc = 1;

Ga = Kc*F/Kr;

bode(Ga), grid on
nyquist(Ga), grid on

Kc = 800;
W = feedback(Kc*F,1/Kr);
dcgain(W)
damp(W)