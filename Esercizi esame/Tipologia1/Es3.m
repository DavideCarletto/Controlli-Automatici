clear all, close all

s = tf('s')

F = (4*s^2+1200*s+90000)/(s^3+154*s^2+5600*s+20000);

thetaf = 0.01;
tauf = 0.30;
y_inf = 4.5;

Kf = y_inf/1;

Kp = 1.2*tauf/(Kf*thetaf);
T1 = 2*thetaf
Td = 0.5*thetaf
N = 10;

Rp = Kp*(1+1/(T1*s)+(Td*s)/(1+Td/N*s))

W = feedback(Rp*F, 1)
step(W/dcgain(W))
