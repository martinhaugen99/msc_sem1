clear; close all; clc;

% Submarine Parameters
g = 9.81;       %[m/s^2]
rhoa = 1000;    %[Kg*m^3]
b = 0.25;       %[Kg/s]
v = 9270;       %[m^3]
M = 3059100;    %[Kg]
K = 0.5;        %[Kg/s]

%%%%%%%%%%%%%

% Equilibrium Point
meq = rhoa*v - M;
heq = 0;

x1eq = heq;
x2eq = 0;
x3eq = meq;


x0 = [0 0 meq]';
u0 = 0;
y0 = 0;

modello = 'Sottomarino';
[xeq, ueq, yeq] = trim(modello); %, x0, u0, y0, [], 1, []);
[A, B, C, D] = linmod(modello, xeq, ueq);
C = C(1,:);
D = D(1,1);
G = ss(A, B, C, D);
G = zpk(G);

%%%%%%%

% progetto controllore
R = ctrb(A, B);
Ka = acker(A, B, [-1 -2 -4.95/2]);

AK = A-B*Ka;
BK = B;
CK = C;
DK = D;
GK = ss(AK, BK, CK, DK);
GK = zpk(GK);

%%%%%%%%%%%%%

% progetto osservatore di stato
O = obsv(A, C);
Lt = acker(A', C', [-7 -8 -10]);
L = Lt';

AL = A-L*C;
BL = [B L];
CL = eye(3);
DL = zeros(3, 2);
GL = ss(AL, BL, CL, DL);
GL = zpk(GL);

%%%%%%%%%%%%%%

step(GK)
