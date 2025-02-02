%%%%%%%%%% example in class 3

clear;
close all;
clc;

[x1, x2] = meshgrid(-5:0.1:5, -5:0.1:5);
y = x1.^3-12*x1.*x2+8*x2.^3;

meshc(x1,x2,y);