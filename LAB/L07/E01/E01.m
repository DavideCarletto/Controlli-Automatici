clear all, close all

s = tf('s')

F = (13.5*(s+4)*(s+10))/(s+3)^3;

zero(F)
damp(F)

Kf = dcgain(F)

Kr = 1;
Ga1 = (5/s)*F/Kr;

wb_des = 6;
wc = 0.63*wb_des;
figure, bode(Ga1), grid on
[m_wc_des, f_wc_des] = bode(Ga1, wc)

md = 4;
xd = 1;
tau = xd/wc;
R1 = (1+tau*s)/(1+tau/md*s);
R2 = (1+tau*s)/(1+tau/md*s);

C1 = R1*R2;

figure, bode(Ga1*C1), grid on
[m_wc_des, f_wc_des] = bode(Ga1*C1, wc)

mi = 17.6
figure, bode((1+1/mi*s)/(1+s))
xi = 150;
tau_i = xi/wc;

R3 = (1+tau_i/mi*s)/(1+tau_i*s)

C1 = C1*R3;
C = 5/s*C1;

Ga = C*F/Kr;
margin(Ga)

W = feedback(C*F, Kr)
figure, bode(W), grid on

w_r = 0.1;
Sens = feedback(1, Ga);
err_sin = bode(Sens, w_r)*Kr
