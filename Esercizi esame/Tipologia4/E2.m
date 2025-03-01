clear all, close all

s = tf('s')

Ga =-2*((1+s)*(1+s/2))/((1-s)*(1+s/20)*(1+s/40));


damp(Ga)

figure, nyquist(Ga)

% Definizione delle matrici A e C
A = [44 -46 -6; 49 -59 3; 51 -39 -21];
C = [31 -8 -28];

% Costruzione della matrice di osservabilitÓ
O = obsv(A, C);

% Visualizzare la matrice di osservabilitÓ
disp('Matrice di osservabilitÓ O:')
disp(O)

% Verificare il rango della matrice di osservabilitÓ
rank_O = rank(O);
disp('Rango della matrice di osservabilitÓ O:')
disp(rank_O)

