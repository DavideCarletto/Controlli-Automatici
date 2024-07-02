A = [0,1; 900, 0];
B = [0;-9];
C = [600, 0];
D = 0;

Mr = ctrb(A, B);
r = rank(Mr);

if r == size(A,1)
    disp('Matrice completamente raggiungibile');
    poles = [-40, -60];
    K = acker(A, B, poles)
    
    A_rs = A-B*K;
    B_rs = -1*B;
    C_rs = C-D*K;
    D_rs = -1*D;
    
    disp('Autovalori di A-BK:');
    lambda = eig(A_rs)
    
    T = 0:0.1:4;
    U = sign(sin(2*pi*0.5*T));
    
    x0 = [0;0];
    x1 = [0.01;0];
    x2 = [-0.01; 0];
    
    sistema_retroazionato=ss(A_rs,B_rs,C_rs,D_rs);
    t_r=0:.001:4;
    r=sign(sin(2*pi*0.5*t_r));
    
    [dy_1,t_dy_1]=lsim(sistema_retroazionato,r,t_r,x0);
    [dy_2,t_dy_2]=lsim(sistema_retroazionato,r,t_r,x1);
    [dy_3,t_dy_3]=lsim(sistema_retroazionato,r,t_r,x2);

    figure, plot(t_r,r,'k',t_dy_1,dy_1,'r',t_dy_2,dy_2,'g',t_dy_3,dy_3,'b'), grid on,
    title(['Risposta \deltay(t) del sistema controllato mediante retroazione', ...
           ' dallo stato al variare di \deltax_0']),
    legend('r(t)',' \deltay(t) per \deltax_0^{(1)}', ...
                  '  \deltay(t) per \deltax_0^{(2)}','   \deltay(t) per \deltax_0^{(3)}')
    
else
    disp('Matrice non completamente raggiungibile');
end


