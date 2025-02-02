%%%%%%%%%% script for example 1

clear;
close all;
clc;

x0 = [1, 1];
[x, fval] = fmincon(@nonlinear_example1, x0, [], [], [], [], [], [], @constraints_example1)