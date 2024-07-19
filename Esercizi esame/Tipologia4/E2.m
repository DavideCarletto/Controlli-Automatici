clear all, close all

s = tf('s')

Ga =-2*((1+s)*(1+s/2))/((1-s)*(1+s/20)*(1+s/40));


damp(Ga)

figure, nyquist(Ga)

% Definizione delle matrici A e C
A = [44 -46 -6; 49 -59 3; 51 -39 -21];
C = [31 -8 -28];

% Costruzione della matrice di osservabilità
O = obsv(A, C);

% Visualizzare la matrice di osservabilità
disp('Matrice di osservabilità O:')
disp(O)

% Verificare il rango della matrice di osservabilità
rank_O = rank(O);
disp('Rango della matrice di osservabilità O:')
disp(rank_O)

