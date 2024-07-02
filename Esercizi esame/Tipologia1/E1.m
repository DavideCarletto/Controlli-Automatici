clear all, close all

s = tf('s');

F1 = 30/(s+15);
F2 = (3*s+3)/(s^3+10*s^2+24*s);

F = F1*F2;
Kr = 1;

zero(F)
damp(F)

Kf = dcgain(s*F)

figure, bode(F)

%a stabilità regolare, scelgo kc positivo
Kc = 40;

Ga1 = Kc*F;

wb = 20;
wc_des = 0.63*wb; %primo tentativo

figure, bode(Ga1)
[m_wc_des, f_wc_des] = bode(Ga1, wc_des)

%metto 2 reti anticipatrici da 3 per recuperare 60 gradi

md = 3;
xd = sqrt(md);
taud = xd/wc_des;

Rd = (1+taud*s)/(1+taud/md*s);

Ga2 = Ga1*Rd^2;

figure, bode(Ga2)
[m_wc_des2, f_wc_des2] = bode(Ga2, wc_des)

%ora piazzo rete attenuatrice per fare scendere il modulo di 9.54 db

mi = 3;
figure, bode((1+1/mi*s)/(1+s));
xi = 35;
taui = xi/wc_des;

Ri = (1+taui/mi*s)/(1+taui*s);


Ga3 = Ga2*Ri;

margin(Ga3);

C = Kc*Rd^2*Ri;
Ga = F*C;

W = feedback(Ga, 1/Kr);
figure, bode(W)
figure, step(W)

wb = 21.5;
alpha = 20;
T = 2*pi/(alpha*wb)
T = 0.002;

Gazoh = Ga/(1+T/2*s);
figure, margin(Gazoh)

Fd = c2d(F, T, 'zaoh')

Cz1 = c2d(C, T, 'tustin'); %conviene lui perchè mi da sovraelongazione minore
Cz2 = c2d(C, T, 'match');
Cz3 = c2d(C, T, 'zoh');


W1 = feedback(Fd*Cz1, 1/Kr);
figure, step(W1)

W2 = feedback(Fd*Cz2, 1/Kr);
figure, step(W2)

W3 = feedback(Fd*Cz3, 1/Kr);
figure, step(W3)
