clear;
close all;
clc;

[x, y] = meshgrid(-2:.1:2, -2:.1:2);
a = -1;
b = 1;
f = 1/2*(a*x.^2 + b*y.^2)-1;
meshc(x, y, f);