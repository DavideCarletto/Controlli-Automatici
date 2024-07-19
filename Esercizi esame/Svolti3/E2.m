clear all, close all

s = tf('s')

F = (31250*(s+4)^2)/((s^3+s^2)*(s+50)^2);

zero(F)
damp(F)

figure, bode(F)