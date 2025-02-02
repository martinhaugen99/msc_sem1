%%%%%% matlab script for more complicated prey-predator model %%%%%%%

clear;
close all;
clc;


%% parameters
a1 = 1;
b1 = 0.0002;
g1 = 0.01;
a2 = 1;
g2 = 0.001;

% change these for exploration of model
x10 = 3000;
x20 = 1000;

tFinal = 100;

% equilibrium points
x1eq = 1000;
x2eq = 80;

xeq = [x1eq; x2eq];

ueq = 0;

% linearize
[A, B, C, D] = linmod('prey_pred_ext', xeq, ueq);


%% simulation
modelSim = sim("prey_pred_ext.slx");

x1 = modelSim.y.Data(:,1);
x2 = modelSim.y.Data(:,2);

time = modelSim.y.Time;


%% plotting
figure

plot(time, x1);
hold on;
plot(time, x2);
xlabel('time');
ylabel('population');
legend('prey', 'predators');
grid on;






