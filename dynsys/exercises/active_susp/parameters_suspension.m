%%%%%%% matlab parameters for the active suspension %%%%%%%

clear;
close all;
clc;


%% parameters of the system

% mass of the vehicle
m1 = 1000;

% mass of the wheel, rim and suspension
m2 = 20;

% elastic coefficient of the suspension
k1 = 30000;

% elastic coefficient of the wheel and rim
k2 = 100000;

% coefficients of damperes
b1 = 1000;
b2 = 150000;


[A, B, C, D] = linmod('suspm');


