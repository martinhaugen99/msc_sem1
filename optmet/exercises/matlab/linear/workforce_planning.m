%%%%%%%%% workforce planning

clear;
close all;
clc;

c = [-1 -1 -1];
A = [40000 30000 25000; -32000 30000 0; 0 -1 2];
b = [3000000 0 0];
lb = [6 6 6];
int = [1 2 3];

[x, fval, exitflag] = intlinprog(c, int, A, b, [], [], lb, [])

