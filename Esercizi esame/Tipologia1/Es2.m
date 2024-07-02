clear all, close all

s = tf('s');

G = 3*((1+s)*(1+s/2))/((1-s)*(1+s/15)*(1+s/45));

figure, nyquist(G);