clear all, close all

Ra = 1;
La = 6e-3;
Km = 0.5;
J = 0.1;
beta = 0.02;
Ka = 10;

s = tf('s')

F1 = Ka*Km/(s^2*J*La + s*(beta*La + J*Ra) + beta*Ra + Km^2);
F2 = -(s*La + Ra)/(s^2*J*La + s*(beta*La + J*Ra) + beta*Ra + Km^2);

tout = 20;
Ku = 1/dcgain(F1);

Kc_vec = [0.1, 1, 5]

open_system('Sistema_in_catena_chiusa')

for Kc=Kc_vec
    sim('Sistema_in_catena_chiusa')
    wrif = ones(size(tout));
    errore = wrif-vel_ang;
    figure, plot(tout, vel_ang, tout, wrif, tout, errore), grid on, ylim([0,1.2])
end

figure
for Kc=Kc_vec
  Kc
  W=feedback(Kc*F1, 1)
  bode(W)
  hold on, grid on
end