%%%%%%%%%%%% project dynamical systems theory:  
%%%%%%%%%%%% stabilizing a landing booster

clear;
close all;
clc;


%% parameters

Tfin = 10;                  % final simulation time

g = 9.81;                   % m/s^2 - gravity constant

m = 500000;                 % kg - booster with a little fuel left

h = 70;                     % m - height of booster

b = 10;                     % m - width of booster

rho = 1.225;                % kg/m^3 - air density

Cd = 1.2;                   % [] - drag coefficient (cylinder)

r = b/2;                    % m - radius of booster (from top view)

a = pi*r^2;                 % m^2 - surface area of bottom of booster

J = (1/12)*m*(b^2 + h^2);   % kg*m^2 - inertia of booster

drag = (1/2)*rho*Cd*a;      % kg*m/s^2 - constant drag

theta_tip = asin(b/h);          % tipping angle
theta_tip = rad2deg(theta_tip); % in degrees


%% equilibrium points

x2eq = h/2;
x2doteq = 0;
thetaeq = 0;
thetadoteq = 0;

u1eq = m*g;
u2eq = 0;
u3eq = 0;

z0 = [x2eq x2doteq thetaeq thetadoteq]';
u0 = [u1eq u2eq u3eq]';

model = 'nonlinear_system';
modelSim = sim(model);

t = modelSim.y.Time;

z1 = modelSim.y.Data(:,1);
z3 = modelSim.y.Data(:,2);

figure
subplot(2,1,1);
plot(t, z1);
title("vertical position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_1$','Interpreter','latex');
grid;

subplot(2,1,2);
plot(t, z3);
title("angular position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_3$','Interpreter','latex');
grid;

sgtitle('Equilibrium points');

%print -depsc figures/eq_points


%% linearization

model_lin = 'nonlinear_sys_linearization';

op = operspec(model_lin);                  % operating point specification

op.States(1).x = z0(1);                    % x2
op.States(2).x = z0(2);                    % x2dot
op.States(3).x = z0(3);                    % theta
op.States(4).x = z0(4);                    % thetadot

stateorder = {'z1', 'z2', 'z3', 'z4'};     % state order

linsys = linearize(model_lin, op, 'StateOrder', stateorder);   % linearize model around eq point

[A, B, C, D] = ssdata(linsys);


%% stability

% internal stability - Lyapunovs reduced criteria of stability

eigenA = eig(A);                     % eigenvalues of A

dz0 = [0, 0, theta_tip+10, 0]';      % small perturbation to initial state
du0 = [0, 0, 0]';

model_stab = 'booster_stability';

out_stab = sim(model_stab);

t_stab = out_stab.ystab.Time;

z1_stab = out_stab.ystab.Data(:,1);
z3_stab = out_stab.ystab.Data(:,2);

figure
subplot(2,1,1);
plot(t_stab, z1_stab);
title("vertical position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_1$','Interpreter','latex');
grid;

subplot(2,1,2);
plot(t_stab, z3_stab);
title("angular position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_3$','Interpreter','latex');
grid;

sgtitle('Small perturbation to initial state');

%print -depsc figures/stability

% external stability - BIBO stability - all poles of tf negative real part

W = tf(linsys);

p = pole(W);


%% controller

Tfin_cont = 5;      % sim time for controller model

R = ctrb(A, B);     % controllability matrix
rankR = rank(R);    % rank of controllability matrix

if rankR == size(A, 1)
disp('The system is controllable');
else
disp('The system is NOT controllable');
end

desired_poles = [-3 + 1.5i, -3 - 1.5i, -5, -10];   % desired poles for the closed-loop system
K = -place(A, B, desired_poles);                   % state-feedback gain

dz0_cont = [0, 0, theta_tip+10, 0]';
z0_cont = z0 + dz0_cont;

model_cont = 'booster_control';

out_cont = sim(model_cont);

% on non-linear system

t_cont = out_cont.ycontrol.Time;

z1_cont = out_cont.ycontrol.Data(:,1);
z2_cont = out_cont.ycontrol.Data(:,2);
z3_cont = out_cont.ycontrol.Data(:,3);
z4_cont = out_cont.ycontrol.Data(:,4);

figure
subplot(2,2,1);
plot(t_cont, z1_cont);
title("vertical position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_1$','Interpreter','latex');
grid;

subplot(2,2,2);
plot(t_cont, z2_cont);
title("vertical velocity", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_2$','Interpreter','latex');
grid;

subplot(2,2,3);
plot(t_cont, z3_cont);
title("angular position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_3$','Interpreter','latex');
grid;

subplot(2,2,4);
plot(t_cont, z4_cont);
title("angular velocity", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_4$','Interpreter','latex');
grid;

sgtitle('Controller on non-linear system');

%print -depsc figures/cont_nonlin

% on linear system:

t_cont_lin = out_cont.ycont_lin.Time;

z1_cont_lin = out_cont.ycont_lin.Data(:,1);
z2_cont_lin = out_cont.ycont_lin.Data(:,2);
z3_cont_lin = out_cont.ycont_lin.Data(:,3);
z4_cont_lin = out_cont.ycont_lin.Data(:,4);

figure
subplot(2,2,1);
plot(t_cont_lin, z1_cont_lin);
title("vertical position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_1$','Interpreter','latex');
grid;

subplot(2,2,2);
plot(t_cont_lin, z2_cont_lin);
title("vertical velocity", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_2$','Interpreter','latex');
grid;

subplot(2,2,3);
plot(t_cont_lin, z3_cont_lin);
title("angular position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_3$','Interpreter','latex');
grid;

subplot(2,2,4);
plot(t_cont_lin, z4_cont_lin);
title("angular velocity", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_4$','Interpreter','latex');
grid;

sgtitle('Controller on linear system');

%print -depsc figures/cont_lin


%% observer

Tfin_obs = 10;      % sim time observer model

O = obsv(A, C);     % observability matrix
rankO = rank(O);    % rank of observability matrix

if rankO == size(A, 1)
disp('The system is observable');
else
disp('The system is NOT observable');
end

desired_poles_obs = [-15, -15, -30, -60];  % desired poles for the observer
L = place(A', C', desired_poles_obs);      % observer gain
L = L';

Aobs = A-L*C;           
Bobs = [B L];
Cobs = eye(4);
Dobs = zeros(4, 5);

poles_placed = eig(Aobs);              

dz0_obs = [0, 0, 0, 0]';
z0_obs = z0 + dz0_obs;

model_obs = 'booster_observer';

out_obs = sim(model_obs);

%% observer on non-linear system

t_obs = out_obs.yobs.Time;

z1_obs_true = out_obs.yobs.Data(:,1);
z2_obs_true = out_obs.yobs.Data(:,2);
z3_obs_true = out_obs.yobs.Data(:,3);
z4_obs_true = out_obs.yobs.Data(:,4);
e1_nonlin = out_obs.yobs.Data(:,5);
e2_nonlin = out_obs.yobs.Data(:,6);
e3_nonlin = out_obs.yobs.Data(:,7);
e4_nonlin = out_obs.yobs.Data(:,8);
z1_obs_est = out_obs.yobs.Data(:,9);
z2_obs_est = out_obs.yobs.Data(:,10);
z3_obs_est = out_obs.yobs.Data(:,11);
z4_obs_est = out_obs.yobs.Data(:,12);

% compare position

figure
subplot(2,1,1);
plot(t_obs, z1_obs_true,'r');
hold on;
plot(t_obs, z1_obs_est,'b');
title("Vertical position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_1$','Interpreter','latex');
legend('true', 'estimated');
grid;

subplot(2,1,2);
plot(t_obs, z3_obs_true,'r');
hold on;
plot(t_obs, z3_obs_est,'b');
title("Angular position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_3$','Interpreter','latex');
legend('true', 'estimated');
grid;

sgtitle('Observer: position non-linear system');

%print -depsc figures/obs_pos_nonlin

% compare velocity

figure
subplot(2,1,1);
plot(t_obs, z2_obs_true,'r');
hold on;
plot(t_obs, z2_obs_est,'b');
title("Vertical velocity", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_2$','Interpreter','latex');
legend('true', 'estimated');
grid;

subplot(2,1,2);
plot(t_obs, z4_obs_true,'r');
hold on;
plot(t_obs, z4_obs_est,'b');
title("Angular velocity", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_4$','Interpreter','latex');
legend('true', 'estimated');
grid;

sgtitle('Observer: velocity non-linear system');

%print -depsc figures/obs_vel_nonlin

%error

figure
subplot(2,2,1);
plot(t_obs, e1_nonlin);
title("Error vertical position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$e_1$','Interpreter','latex');
grid;

subplot(2,2,2);
plot(t_obs, e2_nonlin);
title("Error vertical velocity", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$e_2$','Interpreter','latex');
grid;

subplot(2,2,3);
plot(t_obs, e3_nonlin);
title("Error angular position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$e_3$','Interpreter','latex');
grid;

subplot(2,2,4);
plot(t_obs, e4_nonlin);
title("Error angular velocity", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$e_4$','Interpreter','latex');
grid;

sgtitle('Observer: error non-linear system');

%print -depsc figures/obs_err_nonlin

%% observer on linear system:

t_obs_lin = out_obs.yobs_lin.Time;

z1_obs_true_lin = out_obs.yobs_lin.Data(:,1);
z2_obs_true_lin = out_obs.yobs_lin.Data(:,2);
z3_obs_true_lin = out_obs.yobs_lin.Data(:,3);
z4_obs_true_lin = out_obs.yobs_lin.Data(:,4);
e1_lin = out_obs.yobs_lin.Data(:,5);
e2_lin = out_obs.yobs_lin.Data(:,6);
e3_lin = out_obs.yobs_lin.Data(:,7);
e4_lin = out_obs.yobs_lin.Data(:,8);
z1_obs_est_lin = out_obs.yobs_lin.Data(:,9);
z2_obs_est_lin = out_obs.yobs_lin.Data(:,10);
z3_obs_est_lin = out_obs.yobs_lin.Data(:,11);
z4_obs_est_lin = out_obs.yobs_lin.Data(:,12);

% compare position

figure
subplot(2,1,1);
plot(t_obs_lin, z1_obs_true_lin,'r');
hold on;
plot(t_obs_lin, z1_obs_est_lin,'b');
title("Vertical position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_1$','Interpreter','latex');
legend('true', 'estimated');
grid;

subplot(2,1,2);
plot(t_obs_lin, z3_obs_true_lin,'r');
hold on;
plot(t_obs_lin, z3_obs_est_lin,'b');
title("Angular position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_3$','Interpreter','latex');
legend('true', 'estimated');
grid;

sgtitle('Observer: position linear system');

%print -depsc figures/obs_pos_lin

% compare velocity

figure
subplot(2,1,1);
plot(t_obs_lin, z2_obs_true_lin,'r');
hold on;
plot(t_obs_lin, z2_obs_est_lin,'b');
title("Vertical velocity", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_2$','Interpreter','latex');
legend('true', 'estimated');
grid;

subplot(2,1,2);
plot(t_obs_lin, z4_obs_true_lin,'r');
hold on;
plot(t_obs_lin, z4_obs_est,'b');
title("Angular velocity", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_4$','Interpreter','latex');
legend('true', 'estimated');
grid;

sgtitle('Observer: velocity linear system');

%print -depsc figures/obs_vel_lin

%error

figure
subplot(2,2,1);
plot(t_obs_lin, e1_lin);
title("Error vertical position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$e_1$','Interpreter','latex');
grid;

subplot(2,2,2);
plot(t_obs_lin, e2_lin);
title("Error vertical velocity", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$e_2$','Interpreter','latex');
grid;

subplot(2,2,3);
plot(t_obs_lin, e3_lin);
title("Error angular position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$e_3$','Interpreter','latex');
grid;

subplot(2,2,4);
plot(t_obs_lin, e4_lin);
title("Error angular velocity", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$e_4$','Interpreter','latex');
grid;

sgtitle('Observer: error linear system');

%print -depsc figures/obs_err_lin


%% Dynamic regulator (compensator)

Tfin_comp = 5;         % sim time compensator model

dz0_comp = [0, 0, theta_tip+10, 0]';
z0_comp = z0 + dz0_comp;

model_comp = 'booster_compensator';

out_comp = sim(model_comp);

% on non-linear system

t_comp = out_comp.ycomp.Time;

z1_comp = out_comp.ycomp.Data(:,1);
z2_comp = out_comp.ycomp.Data(:,2);
z3_comp = out_comp.ycomp.Data(:,3);
z4_comp = out_comp.ycomp.Data(:,4);

figure
subplot(2,2,1);
plot(t_comp, z1_comp);
title("vertical position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_1$','Interpreter','latex');
grid;

subplot(2,2,2);
plot(t_comp, z2_comp);
title("vertical velocity", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_2$','Interpreter','latex');
grid;

subplot(2,2,3);
plot(t_comp, z3_comp);
title("angular position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_3$','Interpreter','latex');
grid;

subplot(2,2,4);
plot(t_comp, z4_comp);
title("angular velocity", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_4$','Interpreter','latex');
grid;

sgtitle('Compensator on non-linear system');

%print -depsc figures/comp_nonlin

% on linear system:

t_comp_lin = out_comp.ycomp_lin.Time;

z1_comp_lin = out_comp.ycomp_lin.Data(:,1);
z2_comp_lin = out_comp.ycomp_lin.Data(:,2);
z3_comp_lin = out_comp.ycomp_lin.Data(:,3);
z4_comp_lin = out_comp.ycomp_lin.Data(:,4);

figure
subplot(2,2,1);
plot(t_comp_lin, z1_comp_lin);
title("vertical position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_1$','Interpreter','latex');
grid;

subplot(2,2,2);
plot(t_comp_lin, z2_comp_lin);
title("vertical velocity", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_2$','Interpreter','latex');
grid;

subplot(2,2,3);
plot(t_comp_lin, z3_comp_lin);
title("angular position", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_3$','Interpreter','latex');
grid;

subplot(2,2,4);
plot(t_comp_lin, z4_comp_lin);
title("angular velocity", 'Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel('$t$','Interpreter','latex');
ylabel('$z_4$','Interpreter','latex');
grid;

sgtitle('Compensator on linear system');

%print -depsc figures/comp_lin