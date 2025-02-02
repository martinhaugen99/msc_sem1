%%%%%%%%% Rotating disk parameters

clear;
close all;
clc;

% final sim time
Tf = 10;

m = 1;          %mass
l = 1.1;        %length of the rod
J = 1;          %inertia
g = 9.81;       %gravity constant
theta0 = 20;    %angle of the rod

% intitial conditions
si = 0.3;
dotsi = 1;
wi = 15;

x0 = [si dotsi wi];
u0 = 0;
y0 = x0;

% equilibrium point of the model
[xeq, ueq] = trim('nonlinear_system', x0, u0, y0);

% linearize the model around the equilibrium point
[A, B, C, D] = linmod('nonlinear_system', xeq, ueq);

% state-space system representation
sys = ss(A, B, C, D);

% eigenvalues of A
egeinA = eig(A);

% controllability matrix
R = ctrb(A,B);

% rank of conrollability matrix
rankR = rank(R);

% observability matrix
O = obsv(A,C);

% rank of observability matrix
rankO = rank(O);


% pole positioning by state feedback u(t) = Kx(t)
% computing the gain using the acker function
K = -acker(A, B, [-5.6 -7 -10]);

% xdot(t) = Ax(t) + Bu(t) => (A+B*K)x(t) => Acx(t)
Ac = (A+B*K);

eigenAc = eig(Ac);