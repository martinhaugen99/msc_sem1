

%Dati:
M=1500/4;   %[kg]
%W=m*9.81; %[N] Forza peso

Iw=1;     %[kg*m^2]
Rw=0.3;    %[m]

V0=100/3.6; %[m/s] velocità iniziale (100 km/h)

w0=(V0)/Rw;%[rad/s]

Tbmax=1500;  %[Nm]

slip=[0 0.1 0.2 0.6 1]';
mu=[0 0.45 0.9 0.8 0.65]';

sim('braking_NO_ABS_Fin');

plot(t_pass,Brake_pass);
figure;
plot(t_pass,s_pass);
figure;
plot(t_pass,Vw_pass);
figure;
plot(t_pass,Slip_pass);
sim('braking_ABS_Fin');

figure
plot(t_ABS,Brake_ABS);
figure;
plot(t_ABS,s_ABS);
figure;
plot(t_ABS,Vw_ABS);
figure;
plot(t_ABS,Slip_ABS);

