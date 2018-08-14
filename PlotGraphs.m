clear all
close all
clc

%Constants
g = 9.81;

%Read data from file
%data = xlsread('forward/15-forward-1.xlsx');
data = xlsread('backward/14-backward-1.xlsx');
%data = xlsread('latiral/18-latiral-1.xlsx');
%data = xlsread('adl/3-adl-1.xlsx');

Gyroscope = data(: , 5 : 7) * (pi / 180);   % degres/sec convert to rad/sec
Accelometer = data(:, 2 : 4) * g;           % Units in 'g'
Magnetometer = data(:, 8 : 10) * 10.^-6;         % µT convert to T

time = data(:, 1);

%Initial conditions
x_0 = [0; 0; 0; 1; 0; 0; 10; 0; 0; 0];
p_0 = zeros(10);

%Parameters
params.ts = 1/20; 
params.sigma_a = 5 * 10^-2;
params.sigma_m = 0.001;
params.sigma_g = 0.1;
params.a_sigma_w = 5 * 10^-1;
params.m_sigma_w = 0.05;
params.g = [0; 0; 0.1];    %[x y z]
params.h = [10; 0; 10];

%Initialize
x_k_1 = x_0;
p_k_1 = p_0;

euler = zeros(length(time), 3);
q_out = zeros(length(time), 4);
x_out = zeros(length(time), 10);

for k=1:length(time)
    
    gyro_k = transpose(Gyroscope(k,:));
    acc_k = transpose(Accelometer(k,:));
    mag_k = transpose(Magnetometer(k,:));

    r_k = [acc_k; gyro_k; mag_k];
    [x_k, x_k_bar, p_k_bar] = kalmanPropergation(x_k_1, p_k_1, r_k, params);
   
    x_k_1 = x_k_bar;
    p_k_1 = p_k_bar;
    
    q = transpose(x_k(1:4,1));
    euler(k, :) = abs(computeEularAngles(q) * (180/pi));
    q_out(k, :) = q;
    x_out(k, :) = transpose(x_k);
end

% Plot Accelometer Data

figure;
plot(time, Accelometer(:,1), 'r', time, x_out(:, 5), 'b');grid on;
title('X - axis Accelometer')
legend('Raw Data','Filtered Data')

figure;
plot(time, Accelometer(:,2), 'r', time, x_out(:, 6), 'b');grid on;
title('Y - axis Accelometer')
legend('Raw Data','Filtered Data')

figure;
plot(time, Accelometer(:,3), 'r', time, x_out(:, 7), 'b');grid on;
title('Z - axis Accelometer')
legend('Raw Data','Filtered Data')

norm = sqrt(Accelometer(:,1).^2 + Accelometer(:,2).^2 + Accelometer(:,3).^2);
filtered_norm = sqrt(x_out(:, 5).^2 + x_out(:, 6).^2 + x_out(:, 7).^2);

figure;
plot(time, norm, 'r', time, filtered_norm, 'b');grid on;
title('Accelometer Norm')
legend('Raw Data','Filtered Data')

%Plot euler angles

figure;

plot(time, euler(:,1), 'r', time, euler(:,2), 'g', time, euler(:,3), 'b', time, filtered_norm(:,1), 'm');grid on;
legend('Roll','Pitch', 'Yaw', 'Accelometer Norm')
