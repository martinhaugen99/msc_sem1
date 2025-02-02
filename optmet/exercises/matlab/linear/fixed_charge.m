%%%%%%%%% fixed charge

clear;
close all;
clc;

c = [3 5 6 3 5 6 750 600 800 1000 900 1100]; % [x_ad x_bd x_cd x_an x_bn x_cn y_ad y_bd y_cd y_an y_bn y_cn]
A = [-1 -1 -1 0 0 0 0 0 0 0 0 0;
    0 0 0 -1 -1 -1 0 0 0 0 0 0;
    1 0 0 0 0 0 -2000 0 0 0 0 0;
    0 1 0 0 0 0 0 -1700 0 0 0 0;
    0 0 1 0 0 0 0 0 -2500 0 0 0;
    0 0 0 1 0 0 0 0 0 -2000 0 0;
    0 0 0 0 1 0 0 0 0 0 -1700 0;
    0 0 0 0 0 1 0 0 0 0 0 -2500];
b = [-4000 -2800 0 0 0 0 0 0];
lb = [0 0 0 0 0 0 0 0 0 0 0 0];
ub = [inf inf inf inf inf inf 1 1 1 1 1 1];
intcon = [7, 8, 9, 10, 11, 12];

[x, fval] = intlinprog(c, intcon, A, b, [], [], lb, ub)