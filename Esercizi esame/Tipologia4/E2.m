clear all, close all

s = tf('s')

Ga =-2*((1+s)*(1+s/2))/((1-s)*(1+s/20)*(1+s/40));


damp(Ga)

figure, nyquist(Ga)

