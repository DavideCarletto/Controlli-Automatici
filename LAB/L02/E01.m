clear all, close all, pack

es = menu(' Risposta di sistemi del primo ordine ad ingressi canonici',...
    '1: G1(s) = 10/(s-5)',...
    '2: G2(s) = 10/s',...
    '3: G3(s) = 10/(s+5)',...
    '4: G4(s) = 10/(s+20)');

switch es,
    case 1,
        DEN = [1 -5];
    case 2,
        DEN = [1 0];
    case 3,
        DEN = [1 5];
    case 4,
        DEN = [1 20];
end

NUM = 10;

SYS = tf(NUM, DEN);

u = menu('Ingresso',...
    '1: impulse',...
    '2: step');

figure(1)

switch u,
    case 1,
        impulse(SYS);
    case 2,
        step(SYS);
end

    