%%%%%%   simplified pendulum

clear;
close all;
clc;


%% parameters of the model

m=1;
l=1;
g=10;


%% equilibrium points

theta0 = 0;
thetadot0 = 0;

xeq = [theta0, thetadot0];
Teq = 0;

%try linearize around another equilibrium point
%try 45 and 90 degrees

[A, B, C, D] = linmod('nonlinearpendulum', xeq, Teq);



