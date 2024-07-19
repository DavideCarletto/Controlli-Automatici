clear all, close all

s = tf('s')

F = 200*(s+10)/(s^3+45*s^2-250*s);

damp(F)

 figure, bode(F)
 
 Kc = 10
 
 W = feedback(Kc*F, 1);
 
 damp(W)
 
 figure, margin(Kc*F)