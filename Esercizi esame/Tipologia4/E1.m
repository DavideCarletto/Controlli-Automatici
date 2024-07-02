clear all, close all

s = tf('s');

F1 = (5/s);
F2 = (s+20)/((s+1)*(s+5)^2);

F = F1*F2;
damp(F)

Kr = 1;
Kf = dcgain(s*F)

figure, bode(F)
figure, nyquist(F)

Kc = 5;

Ga1 = Kc*Kr*F;

wc_des = 1.89;

figure, bode(Ga1)
[m_wc_des, f_wc_des] = bode(Ga1, wc_des)

%prendo due reti derivative da 3 per recuperare 60 gradi 
md = 3;
xd = 1.73;
taud = xd/wc_des;

Rd = (1+taud*s)/(1+taud/md*s);

Ga2 = Ga1*Rd^2

figure, bode(Ga2)
[m_wc_des2, f_wc_des2] = bode(Ga2, wc_des)

%prendo rete attenuatrice per perdere il modulo
mi = 13
figure, bode((1+1/mi*s)/(1+s));
xi = 400;
taui = xi/wc_des;

Ri = (1+taui/mi*s)/(1+s*taui);

Ga3 = Ga2*Ri;

margin(Ga3)

C = Kc*Rd^2*Ri;
Ga = C*F;

W = feedback(Ga, 1/Kr);
figure, bode(W);
figure, step(W);

wb = 3.59;
T = 2*pi/(20*wb)
T = 0.02;

Gazoh = Ga/(1+s*T/2);
figure, margin(Gazoh)

Fd = c2d(F, T, 'zoh');

Cz1 = c2d(C, T, 'tustin')
Cz2 = c2d(C, T, 'zoh')
Cz3 = c2d(C, T, 'match')

W1 = feedback(Fd*Cz1, 1/Kr)
W2 = feedback(Fd*Cz2, 1/Kr)
W3 = feedback(Fd*Cz3, 1/Kr)

figure, step(W1)
figure, step(W2)
figure, step(W3)

%scelgo W1 come migliore