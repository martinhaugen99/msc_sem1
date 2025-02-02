%%%%%%%%%% script for example 2

clear;
close all;
clc;

x0 = [1, 1];
A = [1 1];
b = 2; 
[x, fval] = fmincon(@nonlinear_example2, x0, A, b, [], [], [], [], @constraints_example2)