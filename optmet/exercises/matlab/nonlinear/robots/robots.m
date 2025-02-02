%%%%%%%%%%%%% robots problem

clear;
close all;
clc;

x0 = [0 500 500 -500 -500 1000 0 500 -500 -500 500 0];

[x, fval] = fmincon(@obj_func_robots, x0, [], [], [], [], [], [], @con_robots)