%%%%%%%%% Matlab parameters for Simulink %%%%%%%%%%%%

clear;
close all;
clc;

%% Parameters for the Simulation

%Mass
m = 1;

%Length of the rod
l = 1;

%Gravity constant
g = 10;

%friction coefficient
c = 0.2;

%final value of the step
finalInputValue = 0.1;

%final time of the simulation
tFinal = 30;

%max step size for the simulation
maxStepSize = 0.05;

%command for launcing simulation
%sim('example2_0511_pendulum.slx');


%time window
t = linspace(0, tFinal, 100)';

%torque values
dataTorq = sin(t);

%plotting
plot(t, dataTorq);

grid on;

Torq = [t, dataTorq];


%% Calling the simulink model from matlab

modelSimulation = sim('example2_0511_pendulum.slx');


%% Collect the data
% using the 'to workspace' block

t_i = modelSimulation.x.Time;

theta_i = modelSimulation.x.Data(:,1);
thetadot_i = modelSimulation.x.Data(:,2);


%% Plotting the retrieved data and computed values

figure;

plot(t_i, theta_i);
grid on;

[thetaMax, indexMax] = max(theta_i);
t_i_max = t_i(indexMax);

hold on;

plot(t_i_max, thetaMax, 'rx', 'LineWidth', 3);


xlabel('time [s]');

ylabel('theta');




