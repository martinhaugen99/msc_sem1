%%%%%%%% in class exercise 2

clear;
close all;
clc;

[x1,x2] = meshgrid(-3:0.1:3, -3:0.1:3);
y = x1.^4+x2.^2-3*x1.*x2;

meshc(x1,x2,y);