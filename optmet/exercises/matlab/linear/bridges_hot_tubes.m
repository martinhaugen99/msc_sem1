%%%%%%% bridges hot tubes

clear;
close all;
clc;

c = [-350 -300];
A = [1 1; 9 6; 12 16];
b = [200 1566 2880];
lb = [0 0];

[x, fval] = linprog(c, A, b, [], [], lb, [])
