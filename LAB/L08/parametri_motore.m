clear all
close all

% Parametri del motore elettrico

close all

s=tf('s');

Ra=6;
La=3.24e-3;
Km=0.0535;
J=19.74e-6;
Beta=17.7e-6;
Kf=14e-3;
Kpwm=2.925;
Rs=7.525;
Kt=0.02;                % guadagno della dinamo tachimetrica
tau_a=0.001;


F=402.5/(s*(1+s/0.8967)); % f.d.t. motore fra  u e velocita' angolare
Fd=-56500/(1+s/0.8967);   % f.d.t. motore fra Td e velocita' angolare

Td=0; %da cambiare a seconda dei casi

F1 = F*Kt

Kf1 = dcgain(s*F1)
damp(F1)

bode(F1)

Kc = 3;
s_max = 0.25;
Mr = 20*log10((1+s_max)/0.9);
ts = 0.5;
wb_des = 3/ts;
wc_des = 0.63*wb_des

C = Kc
Ga1 = C*F1
figure, bode(Ga1), grid on
[m_wc_des, f_wc_des] = bode(Ga1, wc_des);

20*log10(m_wc_des)
f_wc_des

md = 6;
tau_d = sqrt(md)/wc_des;
Rd = (1+tau_d*s)/(1+tau_d/md*s)

[m_wc_des, f_wc_des] = bode(Ga1*Rd, wc_des);

mi = m_wc_des
f_wc_des

figure, bode((1+1/mi*s)/(1+s))

xi= 28;
tau_i = xi/wc_des;

Ri = (1+tau_i/mi*s)/(1+tau_i*s);

C = Kc*Rd*Ri;
Ga = F1*C;

margin(Ga)

W = feedback(Ga, 1);
figure, step(W)
figure, bode(W)

wb = 5;
alpha = 20;
Ts = 2*pi/(alpha*wb);
Ts = 0.02; %scelgo 0.02 perchè ancora troppo grande T rispetto al tempo di salita
H = Ga/(1+Ts/2*s);
margin(H)

margin(H)

Cd = c2d(C, Ts, 'matched')
Fd = c2d(F1, Ts, 'zoh')
Wd = feedback(Cd*Fd, 1);
figure, step(Wd)
