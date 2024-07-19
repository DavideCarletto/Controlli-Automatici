clear all, close all

s = tf('s')

F = (4*s^2+1200*s+90000)/(s^3+154*s^2+5600*s+20000)

figure, bode(F)
figure, step(F)

Kf = 4.5
thetaf = 0.01
tauf = 0.3

F1 = Kf/(1+tauf*s)*exp(-thetaf*s)

Kp = 1.2*tauf/(Kf*thetaf)
Ti = 2*thetaf
Td = 0.5*thetaf

N = 10

R = Kp * (1 + 1/(Ti*s) + (Td*s)/(1 + Td/N*s))

W = feedback(R*F, 1)

figure, step(W)