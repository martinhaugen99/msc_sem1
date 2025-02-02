%%%%%%% example problem class

clear;
close all;
clc;

c = [-1 -2 -3];
A = [3 0 4; -8 0 -9];
A_eq = [5 1 6];
b = [5 -2];
b_eq = 7;
lb = [0 0 0];
up = [5 4 inf];

[x, fval, exitflag, output] = linprog(c, A, b, A_eq, b_eq, lb, up)