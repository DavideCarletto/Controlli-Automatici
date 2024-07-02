
%{

------------------------------- PARTE 1 ---------------------------------------
es  = menu('Risposta al gradino di sistemi del secondo ordine',...
    '1: G1(s): 20/((s+1)(s+10))',...
    '2: G2(s): 2/(s+1)^2',...
    '3: G3(s): 0.2/((s+1)(s+0.1))');

s = tf('s');

switch es,
    case 1,
        G = 20/((s+1)*(s+10));
    case 2,
         G = 2/(s+1)^2;
    case 3,
         G = 0.2/((s+1)*(s+0.1));        
end

figure(1)

step(G);
%}


%{

---------------------------- PARTE 2 -----------------------------------
s = tf('s'); 

es = menu('Zeri',...
    '1: Z1: 100, Z2: 10, Z3: 1, Z4: 0.5',...
    '2: Z1: -0.9, Z2: -0.5, Z3: -0.1',...
    '3: Z1: -100, Z2: -10, Z3: -2');

switch es
    case 1
        z = [100 10 1 0.5];
        
    case 2
        z = [-0.9 -0.5 -0.1];
        
    case 3
        z = [-100 -10 -2];
end


figure;

funzioni = cell(1, numel(z)); % Inizializzazione della cella per memorizzare le funzioni

% Ciclo per creare le funzioni
for i = 1:numel(z)
    funzioni{i} = (5 / -z(i)) * ((s-z(i))/((s+1)*(s+5)));
end

step(funzioni{:}); % Passa le funzioni alla funzione step
%}


es = menu('Risposta al gradino di G5(s) = wn^2/(s^2+2*zeta*wn*s+wn^2)',...
    '1. wn = 2, zeta = 0.5',...
    '2. wn = 2, zeta = 0.25',...
    '3. wn = 1, zeta = 0.5');

switch es,
    case 1,
        wn = 2;
        zeta = 0.5;
    case 2,
        wn = 2;
        zeta = 0.25;
    case 3,
        wn = 1;
        zeta = 0.5;
end
G5 = wn^2/(s^2+2*zeta*wn*s+wn^2);
sCappello = exp(-pi*zeta/(sqrt(1-zeta^2)));
ts = 1/(wn*sqrt(1-zeta^2))*(pi-acos(zeta));
tAssestamento = -log(0.05)/(zeta*wn)
step(G5);
        