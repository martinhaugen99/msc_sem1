%%%%% matlab pararmeters for prey predator model %%%%%%%

clear;
close all;
clc;


%% parameters
a = 0.9;
b = 0.01;
c = 0.8;
d = 0.01;


x01 = 70;
x02 = 70;

%equilibirum points

xeq = [c/d; a/b];

ueq = 0;

[A, B, C, D] = linmod('prey_predator', xeq, ueq);


%% simulation
modelSimulation = sim("prey_predator.slx");

x1 = modelSimulation.y.Data(:,1);
x2 = modelSimulation.y.Data(:,2);

time = modelSimulation.y.Time;


%% plotting
figure;

plot(time, x1);
hold on;
plot(time, x2);
xlabel('time');
ylabel('population');
legend('prey', 'predators');
grid on;


