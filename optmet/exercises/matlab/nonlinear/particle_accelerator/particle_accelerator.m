%%%%%%%%%%% particle accelerator

clear;
close all;
clc;

x0 = [1 0 0 0 3 0]; % x = [x1 x2 y1 y2 r1 r2]

A = [0 0 -1 0 1 0;
     0 0 0 -1 0 1;
     -1 0 0 0 1 0;
     0 -1 0 0 0 1;
     0 0 1 0 1 0;
     0 0 0 1 0 1;
     1 0 0 0 1 0;
     0 1 0 0 0 1];

b = [50 50 100 100 50 50 100 100];

Aeq = [0 0 0 0 1 -1];

beq = 0;

[x, fval] = fmincon(@obj_func_partacc, x0, A, b, Aeq, beq, [], [], @con_partacc)