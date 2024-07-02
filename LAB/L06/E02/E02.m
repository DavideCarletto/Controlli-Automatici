clear all, close all

s = tf('s')
F = (s-1)/((s+0.2)*(s^3+2.5*s^2+4*s))

zero(F)
damp(F)

dcgain(s*F)

Kc = 1;
Kr = 0.5;

%aggiunto dopo aver fatto i conti con Nyquist
Kc = -0.1

Ga=Kc/Kr*F;
W = feedback(Kc*F, 1/Kr)

zero(W)
damp(W)

bode(Ga), grid on
nyquist(Ga), grid on

