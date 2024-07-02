clear all, close all

s = tf('s');

F = (5*(s+20))/(s*(s^2+2.5*s+2)*(s^2+15*s+100));

zero(F)
damp(F)

Kf = dcgain(s*F)
Kr = 2;

figure, bode(F/Kr), grid on

Kc = 160;

Ga1 = Kc*F/Kr;

ts = 1
wb_des = 3/ts;
wc_des = 0.63*wb_des

figure, bode(Ga1), grid on
[m_w_des, f_w_des] = bode(Ga1, wc_des)

md = 6;
xd = 1.3 ;
tau_d = xd/wc_des;

Rd = (1+tau_d*s)/(1+tau_d/md*s)

C1 = Rd*Rd;

%figure, bode(Ga1*C1), grid on
[m_w_des, f_w_des] = bode(Ga1*C1, wc_des)

mi = m_w_des;
%figure, bode((1+1/mi*s)/(1+s))

xi = 300;
tau_i = xi/wc_des

Ri = (1+tau_i/mi*s)/(1+tau_i*s)

margin(C1*Ri*Ga1)

C = Kc*C1*Ri;
Ga = C*F/Kr;

W = feedback(C*F, 1/Kr);
figure, step(W/Kr);

Wu = feedback(C,F/Kr);
figure, step(Wu);

figure, bode(W/Kr);

