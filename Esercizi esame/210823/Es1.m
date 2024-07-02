clear all, close all

s = tf('s');

F = 10*(s+10)/(s^2+0.5*s+25);

damp(F);
zero(F);

Kf = dcgain(F);

figure, bode(F)


Kc = 2000;
wc_des = 44;%iniziale 47

Ga1 =Kc*F/s;
figure, bode(Ga1)
[m_wb_des, f_wb_des] = bode(Ga1,wc_des);

%m_db_des = 20*log10(m_wb_des)
%f_wb_des

figure, bode((1+s));

xz = 2.8; %iniziale 1.78
tauz = xz/wc_des;
Rz = 1+tauz*s;
Ga2 = Kc/s*Rz*F;

[m_wb_des, f_wb_des] = bode(Ga2,wc_des)

mi = 31.9;
figure, bode((1+1/mi*s)/(1+s))

xi = 290
taui = xi/wc_des
Ri = (1+taui/mi*s)/(1+taui*s);


Ga = Kc/s*F*Ri*Rz;
margin(Ga)
C = Kc/s*Ri*Rz;

W = feedback(C*F, 1);
figure, step(W)