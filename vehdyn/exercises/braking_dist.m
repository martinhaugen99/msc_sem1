% Define constants
m = 1500;           % Mass of the vehicle (kg)
m_r = 98.4;         % Mass of rotational components (kg)
m_t = m + m_r;      % Total mass (kg)
f_V = 0.01;         % Rolling resistance coefficient
g = 9.81;           % Acceleration due to gravity (m/s^2)
rho = 1.225;        % Air density (kg/m^3)
A = 2;              % Frontal area (m^2)
C_X = 0.26;         % Drag coefficient
V0 = 27.78;         % Initial speed (m/s)

% simulation parameters:
dt = 0.1;       % time steps (s)
t_max = 400;    % end time (s)
N = t_max / dt; % number of steps

% arrays for storing data:
v_drag = zeros(1, N);
time = zeros(1, N);

% initial conditions:
v_drag(1) = V0;
time(1) = 0;

% case 1: only considering rolling resistance
dec_roll = - (f_V * m * g) / m_t;                           % deceleration (m/s^2)
time_roll = (- V0) / dec_roll;                              % braking time (s)     
dist_roll = V0 * time_roll + (dec_roll/2) * time_roll^2;    % braking distance (m)
fprintf('Braking time considering only rolling resistance: %.2f seconds\n', time_roll);
fprintf('Braking distance considering only rolling resistance: %.2f meters\n', dist_roll);

% case 2: only considering aerodynamic drag
k = (rho * C_X * A) / (m_t * 2);    % constant for aerodynamic factor

% loop for calculating the speeds:
for i = 1:N-1
   % aerodynamic drag only:
   dVdt = (-k) * v_drag(i)^2;
   v_drag(i+1) = v_drag(i) + dVdt * dt;

   % update time:
   time(i+1) = time(i) + dt;
end

% analytical solution with aerodynamic drag only:
v_analytical = 1 ./ (k .* time + (1 / V0));

% plot results
figure;
plot(time, v_drag, 'b', 'LineWidth', 2);
hold on;
plot(time, v_analytical, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Speed (m/s)');
title('Speed over time: Aerodynamic drag');
legend('Numerical', 'Analytical');
grid on;
hold off;

% case 3: both rolling resistance and aerodynamic drag:

v_both = zeros(1, N);   % array for storing velocities
time_both = zeros(1, N);

v_both(1) = V0;         % initial condition
time_both(1) = 0;

% variable for tracking distance
distance = 0;

% loop for calculating speeds:
for i = 1:N-1
    % update speed
    dVdt_both = -((f_V * m * g) / m_t) - ((rho * C_X * A * v_both(i)^2) / (2 * m_t));
    v_both(i+1) = v_both(i) + dVdt_both * dt;

    % update time:
    time_both(i+1) = time_both(i) + dt;

    % update distance
    delta_distance = v_both(i) * dt;
    distance = distance + delta_distance;

    % stop if below zero
    if v_both(i+1) <= 0
        v_both(i+1:end) = 0;
        time_both(i+1:end) = time_both(i);
        break;
    end
end

% plot results
figure;
plot(time_both, v_both, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Speed (m/s)');
title('Speed over time; aerodynamic drag and rolling resistance');
grid on;

% results
stoptime_both = time_both(N);
fprintf('\nBraking time considering both drag and rolling resistance: %.2f seconds\n', stoptime_both);
fprintf('Braking distance considering both drag and rolling resistance: %.2f meters\n', distance);