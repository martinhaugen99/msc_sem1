%[x, y] = meshgrid(x_min:dx:x_max, y_min:dy:y_max)

clear;
close all;
clc;

[x, y] = meshgrid(-2:.1:2, -2:.1:2);
z = x.^4+y.^4-3*x.*y;

%mesh(x,y,z);
%contour(x, y, z);
meshc(x, y, z);