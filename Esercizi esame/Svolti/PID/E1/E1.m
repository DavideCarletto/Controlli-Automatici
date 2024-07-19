clear all, close all

s = tf('s')

F = 2*(s+10)/(s*(s+1)*(s+8)^2)

figure, bode(F)

Kp = 27.7
T = 2*pi/2.59

Kp = 27.7*0.6
Ti = 0.5*T
Td = 0.125*T

N = 10

R = Kp * (1 + 1/(Ti*s) + (Td*s)/(1 + Td/(N*s)))

W = feedback(F*R, 1)

margin(R*F)
figure, bode(W)

%troppo alto il picco di risonanza, impongo margine di fase a 45 gradi

Kp = 19.58
Ti = 1.86
Td = 0.25*Ti

R = Kp * (1 + 1/(Ti*s) + (Td*s)/(1 + Td/N*s))

W = feedback(F*R, 1)

margin(R*F)
figure, bode(W)