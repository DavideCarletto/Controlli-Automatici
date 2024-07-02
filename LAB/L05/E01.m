clear all, close all

s = tf('s')
F = (s^2+11*s+10)/(s^4+4*s^3+8*s^2)

Kr = 1;
Kc = 1;
Kf = dcgain(s^2*F)

[Wn, Zeta, P] = damp(F);

disp('Poli della funzione di trasferimento:');
disp(P);
disp('Pulsazione naturale dei poli:');
disp(Wn);
disp('Fattore di smorzamento dei poli:');
disp(Zeta);

zeros_F = zero(F);
disp('Zeri della funzione di trasferimento:');
disp(zeros_F);

Ga = Kc*F/Kr;
figure, bode(Ga), grid on

z = logspace(0,3,1000);
figure, nyquist(Ga,z), grid on

W = feedback(Kc*F, 1/Kr);
damp(W)